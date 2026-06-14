pipeline {
    agent any

    environment {
        NAME = '1506'
        SVC = 'conn'
    }

    stages {
        stage('Cleanup') {
            steps {
                sh 'kubectl delete deployment $NAME || true'
            }
        }
        stage('Build') {
            steps {
                sh 'podman build . -t dockerhub.io/mranshu6290/$NAME:$BUILD_NUMBER'
            }
        }
        stage('Docker Image check') {
            steps {
                sh 'podman images | grep $NAME'
            }
        }
        stage('Docker Upload') {
            steps {
                sh '''
              podman dockerhub login -username -password
                                '''
            }
        }
        stage('Test') {
            steps {
                echo 'I am cleanup o 1506'
            }
        }
        stage('AWS Infra') {
            steps {
                echo 'I am cleanup o 1506'
            }
        }
    }
}
