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
                 withSonarQubeEnv(credentialsId: 'sonar_token') {
                 sh 'mvn clean package sonar:sonar'
                 }
                }
            }
        }
    }
}