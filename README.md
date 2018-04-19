# poco_restful-webservice Dockerfile
Dockerfile for building docker image for C++ Restful Webservice server

## Build 

```
docker build -t my_cpp_rest_server .

```

## Run

### 1. Initialize MySQL Database schema

Refer to https://hub.docker.com/r/congtaojiang/cpp-rest-server/

### 2. Start Container

```
docker run --rm -it -e mysql_host='<your-mysql-host-ip-or-FDQN>' -e mysql_user='<your-mysql-db-user>' -e mysql_pass='<your-mysql-db-user-password>' -p 9090:9090 my_cpp_rest_server

```
### 3. Consume Restful service

```
curl -v -X GET --header 'Accept: application/vnd.api+json' --header 'Content-type: application/vnd.api+json' http://localhost:9090 

```

## Reference

### Rebuilt Docker image

https://hub.docker.com/r/congtaojiang/cpp-rest-server/

