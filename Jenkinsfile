pipeline{
    agent any
    tools {
        jdk 'Java17'
        maven '3.6.3'
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
                withSonarQubeEnv(credentialsId: 'jenkins-sonar-qube-token') {
                    sh 'mvn sonar:sonar'
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
