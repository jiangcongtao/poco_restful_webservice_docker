FROM centos:centos7 AS builder
LABEL com.nick.poco.rest.app = "1.0" \
    com.nick.poco.rest.author="Congtao Jiang <congtao.jiang@outlook.com>" \
    com.nick.poco.rest.builddate="2018-04-19" \
    com.nick.poco.rest.description="Multi-stage builder image for building C++ Restful Server"

RUN yum install -y wget sudo openssl-devel make automake gcc gcc-c++ git
RUN wget -t 0 -c http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
    && rpm -ivh epel-release-latest-7.noarch.rpm \
    && yum install -y mysql++-devel \
    && wget -t 0 -c https://cmake.org/files/v3.11/cmake-3.11.1-Linux-x86_64.sh \
    && chmod a+x ./cmake-3.11.1-Linux-x86_64.sh \
    && ./cmake-3.11.1-Linux-x86_64.sh --skip-license --prefix=/usr/local/

RUN mkdir /build && cd /build \
    && wget -t 0 -c https://pocoproject.org/releases/poco-1.9.0/poco-1.9.0-all.tar.gz
WORKDIR /build
RUN tar -xvzf poco-1.9.0-all.tar.gz && cd poco-1.9.0-all \
        && cmake ./ && make -j2 && make install
RUN cd /build && \
    git clone https://github.com/jiangcongtao/poco_restful_webservice.git && \
    cd poco_restful_webservice && cmake -DCMAKE_INSTALL_PREFIX=/app ./ && make -j2 && make install && \
    ls -ls /app && find ./ && \
    cp /usr/local/lib/libPoco* /app/lib/. && \
    find /app


FROM centos:centos7
LABEL com.nick.poco.rest.app = "1.0" \
    com.nick.poco.rest.author="Congtao Jiang <congtao.jiang@outlook.com>" \
    com.nick.poco.rest.builddate="2018-04-19" \
    com.nick.poco.rest.description="C++ Restful Server"

COPY --from=builder /app /app/webservice
RUN yum install -y mariadb-libs && yum install -y sudo
RUN chmod a+x -R /app && useradd -d /home/cppuser -ms /bin/bash -g root -p cppuser cppuser \
    && echo cppuser | passwd cppuser --stdin && usermod -aG wheel cppuser
USER cppuser
WORKDIR /home/cppuser
ENV LD_LIBRARY_PATH="/app/webservice/lib"
ENV PATH="/app/webservice/bin:${PATH}"
CMD ["webservice"]
EXPOSE 9090