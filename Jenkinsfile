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
    }
}