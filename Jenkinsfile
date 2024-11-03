pipeline{
    agent any
    tools{
        maven "maven"

    }
    stages{
        stage("Build JAR File"){
            steps{
                checkout scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/maliviaux/prestabanco']])
                dir("prestabanco-backend"){
                    bat "mvn clean install"
                }
            }
        }
        stage("Test"){
            steps{
                dir("prestabanco-backend"){
                    bat "mvn test"
                }
            }
        }        
        stage("Build and Push Docker Image"){
            steps{
                dir("prestabanco-backend"){
                    script{
                         withDockerRegistry(credentialsId: 'docker-credentials'){
                            bat "docker build -t maliviaux/prestabanco-backend:latest ."
                            bat "docker push maliviaux/prestabanco-backend:latest"
                        }
                    }                    
                }
            }
        }
    }
}