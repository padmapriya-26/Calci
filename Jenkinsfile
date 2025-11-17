pipeline {
    agent any

    environment {
        DOCKERHUB = credentials('docker-creds')  
    }

    stages {

        stage('Clone Repo') {
            steps {
                git url: 'https://github.com/padmapriya-26/Calci.git'
                    branch: 'main'
            }
        }

        stage('Terraform init') {
            steps {
                sh '''
                git clone https://github.com/padmapriya-26/Calci.git
                ls -R .
                cd Calci/calculator
                terraform init
                terraform apply -auto-approve
                '''
            }
        }
    }
}
