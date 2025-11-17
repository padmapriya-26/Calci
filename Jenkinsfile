pipeline {
    agent any

    environment {
        DOCKERHUB = credentials('docker-creds')  
    }

    stages {
        stage('Install Terraform') {
            steps {
                sh '''
                sudo apt-get update -y
                sudo apt-get install -y unzip curl gnupg software-properties-common
                TERRAFORM_VERSION=1.5.7
                curl -O https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
                rm -rf terraform
                unzip -o terraform_${TERRAFORM_VERSION}_linux_amd64.zip
                sudo mv terraform /usr/local/bin/
                terraform version
                '''
            }
        }
        stage('Terraform init') {
            steps {
                cleanWs()
                sh '''
                git clone https://github.com/padmapriya-26/Calci.git
                ls -R .
                cd Calci/calculator/
                terraform init
                terraform apply --auto-approve
                '''
            }
        }
    }
}
