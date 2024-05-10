# Jenkins with Maven and Gradle Docker Image

## Overview
This Dockerfile extends the official Jenkins LTS image by integrating Maven and Gradle, providing a comprehensive environment for continuous integration and automation tasks in software development workflows.

## Features
- Based on the stable Jenkins LTS image with JDK 17.
- Pre-installed Maven and Gradle to facilitate building and managing Java projects.
- Optimized for seamless integration into CI/CD pipelines.

## Usage

1. Build the Docker image using the provided Dockerfile.

```bash
docker build --build-arg GRADLE_VERSION=8.7 --build-arg MAVEN_VERSION=3.9.6 -t jenkins-with-maven-gradle .
```
2. Run the Docker container:
```bash
docker run -d  -p 8080:8080 -p 50000:50000 jenkins-with-maven-gradle
```

3. Access Jenkins in your browser:

`http://localhost:8080`

## Orchestrating with Docker Compose

1. Copy the definition below and paste in a `docker-compose.yml` file:

```yaml
version: "3.8"

volumes:
  jenkins-data: {}
  jenkins-docker-certs: {}

networks:
  jenkins: {}

services:
  jenkins:
    container_name: jenkins
    build:
      context: .
      dockerfile: Dockerfile
      args:
        MAVEN_VERSION: ${MAVEN_VERSION}
        GRADLE_VERSION: ${GRADLE_VERSION}
    volumes:
      - jenkins-data:/var/jenkins_home
      - jenkins-docker-certs:/certs/client
    environment:
      - DOCKER_TLS_CERTDIR=/certs
    ports:
      - 8080:8080
      - 50000:50000
```

2. Define the `MAVEN_VERSION` and `GRADLE_VERSION` variables in the [.env](./.env) File as shown below:

```properties
MAVEN_VERSION=3.9.6
GRADLE_VERSION=8.7
```
3. Run ```docker-compose up -d``` to orchestrate the setup

4. You can access your jenkins deployment via http://localhost:8080

## Configuration

- ***Maven Version:*** Specify the desired Maven version by setting the `MAVEN_VERSION` build argument during the Docker build process.
- ***Gradle Version:*** Specify the desired Gradle version by setting the GRADLE_VERSION build argument during the Docker build process.

## License

This Dockerfile is licensed under the [Apache License](./LICENSE).

