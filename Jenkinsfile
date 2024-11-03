pipeline {
    agent any
    tools {
        maven "maven"
    }
    stages {
        stage("Checkout Code") {
            steps {
                // Realiza el checkout del repositorio
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/maliviaux/prestabanco']])
            }
        }
        stage("Build JAR File") {
            steps {
                dir("prestabanco-backend") {
                    bat "dir" // Verifica el contenido del directorio
                    bat "mvn clean install"
                }
            }
        }
        stage("Test") {
            steps {
                dir("prestabanco-backend") {
                    bat "mvn test"
                }
            }
        }
        stage("Build and Push Docker Image") {
            steps {
                dir("prestabanco-backend") {
                    script {
                        withDockerRegistry(credentialsId: 'docker-credentials') {
                            bat "docker build -t maliviaux/prestabanco-backend:latest ."
                            bat "docker push maliviaux/prestabanco-backend:latest"
                        }
                    }
                }
            }
        }
    }
}
