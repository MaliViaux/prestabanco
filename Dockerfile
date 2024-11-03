# Usa la imagen oficial de Jenkins LTS como base
FROM jenkins/jenkins:lts

# Cambia a usuario root para instalar herramientas adicionales
USER root

# Instala Docker dentro del contenedor
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates curl software-properties-common && \
    curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" && \
    apt-get update && \
    apt-get install -y docker-ce-cli

# Instala Maven
ARG MAVEN_VERSION=3.8.5
ARG SHA=5b59d9d48445c1c2a4c7b5afc9e6ebaf80c33ec45a9cd0a2850847b13b205ce2
RUN curl -fsSL https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz -o /tmp/apache-maven.tar.gz && \
    echo "$SHA  /tmp/apache-maven.tar.gz" | sha256sum -c - && \
    tar -xzf /tmp/apache-maven.tar.gz -C /opt && \
    ln -s /opt/apache-maven-$MAVEN_VERSION /opt/maven && \
    ln -s /opt/maven/bin/mvn /usr/local/bin/mvn && \
    rm -f /tmp/apache-maven.tar.gz

# Añade Maven al PATH
ENV MAVEN_HOME /opt/maven
ENV PATH $MAVEN_HOME/bin:$PATH

# Crea un directorio para el Docker socket (necesario para montar el socket Docker del host)
VOLUME /var/run/docker.sock

# Cambia el usuario de vuelta a Jenkins
USER jenkins

# Expone el puerto 8080 para la interfaz de Jenkins y el puerto 50000 para el agente JNLP
EXPOSE 8080 50000