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
        stage('Upload warfile to nexus'){
            steps{
                script{
                    def pom = readMavenPom file: 'pom.xml'

                    def nexusRepo + readMavenPom.version.endsWith("SNAPSHOT") ? "demo_app_snapshot" : "demo_app_release"
                    nexusArtifactUploader artifacts:
                     [
                        [
                            artifactId: 'springboot', classifier: '', file: 'target/Uber.jar', type: 'jar'
                            ]
                     ],
                      credentialsId: 'nexus_auth',
                      groupId: 'com.example', 
                      nexusUrl: '43.204.148.44:8081', 
                      nexusVersion: 'nexus3', 
                      protocol: 'http', 
                      repository: 'demo_app_release', 
                      version: "${pom.version}"
                }
            }
        }
    }
}
