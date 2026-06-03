pipeline {
    agent any

    environment {
    NAME='0406'
    IMAGE='0406img'
    PORT='8085'
    }
    stages {
        stage('Clean') {
            steps {
                sh '''
                podman rm $NAME || true'''
            }
        }
        stage('Build') {
            steps {
                sh '''
                podman build . -t $IMAGE
                '''
            }
        }
        stage('Run Pod') {
            steps {
                sh '''
                podman run -d --name $NAME -p $PORT:80 $IMAGE
                '''
            }
        }
        stage('Run Deployment') {
            steps {
                sh 'I am alive'
            }
        }
    }
}
