pipeline{
    agent any
    stages{
        stage('git checkout'){
            steps{
                git branch: 'main', url: 'https://github.com/naren4897/demo-counter-app.git'
            }
        }
        stage('Unit Testing'){
            steps{
                sh 'mvn test'
            }
        }
        stage('Integration Testing'){
            steps{
                sh 'mvn verify -DskipUnitTests'
            }
        }
        stage('Maven Build'){
            steps{
                sh 'mvn clean install'
            }
        }
        stage('SonarQube Analysis'){
            steps{
                script{
                    withSonarQubeEnv(credentialsId: 'sonar_api') {
                    sh 'mvn clean package sonar:sonar'
                    }
                }
            }
        }
        stage('Quality Gate status'){
            steps{
                script{
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonar_api'
                    }
                }
            }
        }
    }
}