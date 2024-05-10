# Use the Jenkins LTS image with JDK 17
FROM jenkins/jenkins:lts-jdk17

#Metadata
LABEL maintainer="Salim Said Hemed <milas.dev@gmail.com>"
LABEL description="This Docker image extends the official Jenkins LTS image with Maven and Gradle installations, providing a complete environment for continuous integration and automation tasks for Java and Python Projects."
LABEL version="1.0"
LABEL org.opencontainers.image.title="Custom Jenkins with Maven and Gradle"
LABEL org.opencontainers.image.description="A more detailed description of your image"
LABEL org.opencontainers.image.authors="Salim Said Hemed <milas.dev@gmail.com>"
LABEL org.opencontainers.image.version="1.0"
LABEL org.opencontainers.image.vendor="Salim Said Hemed"
LABEL org.opencontainers.image.documentation="https://github.com/salimsaidhemed/jenkins-java-extensions.git"
LABEL org.opencontainers.image.url="https://github.com/salimsaidhemed/jenkins-java-extensions.git"
LABEL org.opencontainers.image.source="https://github.com/salimsaidhemed/jenkins-java-extensions.git"

# Maven and Gradle Versions set from .env file
ARG MAVEN_VERSION
ARG GRADLE_VERSION

# Install required dependencies
USER root
RUN apt-get update -y && apt-get install python3 unzip wget -y
WORKDIR /tmp

# Install Maven
RUN curl -fsSL https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz | tar xz -C /usr/share \
    && mv /usr/share/apache-maven-${MAVEN_VERSION} /usr/share/maven \
    && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

# Install Gradle
RUN wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip && \
    unzip -q gradle-${GRADLE_VERSION}-bin.zip -d /opt && \
    rm gradle-${GRADLE_VERSION}-bin.zip

# Set Gradle environment variables
ENV GRADLE_HOME=/opt/gradle-${GRADLE_VERSION}
ENV PATH=$PATH:$GRADLE_HOME/bin

# Cleanup 
RUN rm -rf /tmp/* && apt-get remove unzip wget

# Expose Jenkins Master/Slave Port
EXPOSE 50000

# Expose Jenkins HTTP Port
EXPOSE 8080


