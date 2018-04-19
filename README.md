# poco_restful-webservice Dockerfile
Dockerfile for building docker image for C++ Restful Webservice server

## Build 

```
docker build -t my_cpp_rest_server .

```

## Run

```
docker run --rm -it -e mysql_host='<your-mysql-host-ip-or-FDQN>' -e mysql_user='<your-mysql-db-user>' -e mysql_pass='<your-mysql-db-user-password>' -p 9090:9090 my_cpp_rest_server

```

## Reference

https://hub.docker.com/r/congtaojiang/cpp-rest-server/

