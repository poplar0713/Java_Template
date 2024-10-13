# heathcheck
Sample RestAPI, Git Action CI



# 1.  실행 테스트



```sh

$ curl localhost:8080/health -i


HTTP/1.1 200
Content-Type: text/plain;charset=UTF-8
Content-Length: 17
Date: Mon, 09 Sep 2024 03:33:43 GMT

Server is running


```



# 2.  Dockerizing



## 1) Dockerfile

```yaml
# Stage 1: Build the application using Maven
FROM maven:3.8.4-openjdk-17 AS build
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run the application using OpenJDK
#FROM openjdk:17-jdk-slim
FROM openjdk:17-jdk
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]

```







## 2) Docker build 및 실행

```sh

# Docker 빌드 명령
$ docker build -t <registry_name>/<project_name>:v1.4 .


# Docker 컨테이너 실행
$ docker run -p 8080:8080 <registry_name>/<project_name>:v1.4


# test
# 다른 터미널에서...
$ curl localhost:8080/health -i


```

이제 http://localhost:8080/health에서 Spring Boot 애플리케이션을 확인







# 3. [Buildx] **빌드 캐시 사용**

Docker에서 buildx 명령을 사용하여 이미지를 빌드하고 푸시할 때, 기본적으로 빌드된 이미지는 로컬에 저장되지 않는다. 로컬에 이미지를 생성하려면 --load 또는 --output 옵션을 사용해야 한다.

```sh

# push만 사용
docker buildx build \
    --cache-from=type=registry,ref=<registry_name>/<project_name>:cache \
    --cache-to=type=registry,ref=<registry_name>/<project_name>:cache,mode=max \
    --push \
    -t <registry_name>/<project_name> .


# push, load 모두 사용
docker buildx build \
    --cache-from=type=registry,ref=<registry_name>/<project_name>:cache \
    --cache-to=type=registry,ref=<registry_name>/<project_name>:cache,mode=max \
    --push \
    --load \
    -t <registry_name>/<project_name>:v1.1 .


# push 없이 load 만 : registry 에 push 는 안된다.
docker buildx build \
    --cache-from=type=registry,ref=<registry_name>/<project_name>:cache \
    --cache-to=type=registry,ref=<registry_name>/<project_name>:cache,mode=max \
    --load \
    -t <registry_name>/<project_name>:v1.3 .
    
```

* --load 옵션은 멀티 플랫폼 빌드를 지원하지 않는다. 단일 플랫폼(--platform linux/amd64)에서만 작동한다.



#### 컨테이너 실행

```sh


# Docker 컨테이너 실행
$ docker run -p 8080:8080 <registry_name>/<project_name>


# test
# 다른 터미널에서...
$ curl localhost:8080/health -i


```

