pipeline {
    agent any
    environment {
        NAME = '1606'
        SVC = 'conn3'
    }

    stages {
        stage('Cleanup') {
            steps {
                sh '''
                kubectl remove deployment $NAME || true
                kubectl remove svc $NAME || true
                '''
            }
        }
        stage('Build') {
            steps {
                sh 'podman build . -t docker.io/mranshu6290/$NAME:$BUILD_NUMBER'
            }
        }
        stage('Check') {
            steps {
                sh 'podman images | grep $NAME:$BUILD_NUMBER'
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
            stage('Infra') {
            steps {
                echo 'I am alive'
            }
            }
    }
}
