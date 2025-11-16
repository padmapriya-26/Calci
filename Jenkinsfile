pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('docker-creds')
    }
    stages {
        stage('checkout') {
            steps {
                echo "*********** cloning the code **********"
                sh '''
                    rm -rf Calci || true
                    git clone https://github.com/padmapriya-26/Calci.git
                ''' 
            }
        }
        
        stage('Artifact build') {
            steps {
                echo "********** building is done ************"
                dir('Calci/calculator') {
                    sh 'mvn clean package -DskipTests -Dcyclonedx.skip=true -Dcheckstyle.skip=true'
                }
            }
        }
        
        stage('Prepare for Docker Build') {
            steps {
                dir('Calci/calculator/target') {
                    stash name: 'java-artifact', includes: 'calculator-0.0.1-SNAPSHOT.jar'
                }
                dir('Calci') {
                    stash name: 'dockerfile', includes: 'Dockerfile'
                }
            }
        }
        
        stage('Build Docker Image') {
            agent { 
                label 'java-slave'
            } 
            steps {
                dir('Calci') {
                // Unstash artifacts on the slave node
                unstash 'java-artifact'
                unstash 'dockerfile'
                sh '''
                  export DOCKER_BUILDKIT=0
                  docker build -t padmapriya26/calculator:v1 .
                '''
                }     
            }
        }
        
        stage('Push to Docker Hub') {
            agent { 
                label 'java-slave'
            } 
            steps {
                sh """
                echo "${DOCKERHUB_CREDENTIALS_PSW}" | docker login -u "${DOCKERHUB_CREDENTIALS_USR}" --password-stdin
                docker push padmapriya26/calculator:v1
                """
            }
        }
    }
}
