pipeline{
    agent any
    tools {
        jdk 'Java17'
        maven '3.6.3'
    }
    stages{
        /*stage("Cleanup workspace"){
            steps {
                cleanWs()
            }
        }*/


        stage("Checkout from SCM"){
            steps {
                sh 'mvn clean package'
            }
        }

        /*stage("Test application"){
            steps {
                sh 'mvn test'
            }
        }*/
    }

}
