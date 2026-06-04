pipeline {
    agent any

    stages {
        stage('Terraform Init') {
            steps {
                sh 'terraform init -input=false -migrate-state -auto-approve'
            }
        }

        stage('Terraform Plan') {
            steps {
                sh 'terraform plan'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
    }
}
