pipeline{
    agent any
    tools {
        jdk 'Java17'
        maven 'Maven3'
    }
    stages{
        stage{"Cleanup workspace"}{
            steps {
                cleanWs()
            }
        }
    }

    stages{
        stage{"Checkout from SCM"}{
            steps {
                git branch: 'main', credentialsId: 'github', url: 'https://github.com/Tr1p79/terraform'
            }
        }
    }
}
