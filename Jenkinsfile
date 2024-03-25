pipeline{
    agent any
    tools {
        jdk 'Java17'
        //maven '3.6.3'
        maven 'Maven3'
    }
    environment {
        APP_NAME = "e2e-pipepline"
        RELEASE = "1.0.0"
        DOCKER_USER = "tompli"
        DOCKER_PASS = 'dockerhub'
        IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
    }
    stages{ 
        stage("Checkout from SCM"){
            steps {
                sh 'mvn clean package'
            }
        }

        stage("Test application"){
            steps {
                sh 'mvn test'
            }
        }

        
        stage("Sonarqube Analysis"){
            steps {
                script {
                    withSonarQubeEnv(credentialsId: 'jenkins-sonar-qube-token') {
                    sh 'mvn sonar:sonar'
                    }
                }   
            }
        }

        stage("Quality Gate"){
            steps {
                script {
                    waitForQualityGate abortPipepline: false, credentialsId: 'jenkins-sonar-qube-token'
                    
                    
                }   
            }
        }

        stage("Build & Push Docker Image"){
            steps {
                script {
                    docker.withRegistry('', DOCKER_PASS) {
                        docker_image = docker.build "${IMAGE_NAME}"
                    }

                    docker.withRegistry('', DOCKER_PASS) {
                        docker_image.push("${IMAGE_TAG}")
                    }
                }   
            }
        }
    }

    post { 
        always { 
            cleanWs()
        }
    }

}
