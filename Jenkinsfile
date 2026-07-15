pipeline {
    agent any
    environment {
        svc = 'conn1'
        name = '1607'
    }

    stages {
        stage('Remove') {
            steps {
                sh '''kubectl remove deployment $name || true
                kubectl remove svc $svc || true
                '''
            }
        }
        stage('Build') {
            steps {
                sh 'podman build -t docker.io/mranshu6290/$name:BUILD_NUMBER .'
            }
        }
        stage('Upload') {
            steps {
                echo 'I am alive'
            }
        }
        stage('Deploy') {
            steps {
                echo 'I am alive'
            }
        }
        stage('Test') {
            steps {
                echo 'I am alive'
            }
        }
        stage('AWS Infra') {
            steps {
                echo 'I am alive'
            }
        }
    }
}
