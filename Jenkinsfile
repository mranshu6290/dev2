pipeline {
    agent any

    environment {
    NAME='0406'
    IMAGE='docker.io/nginx'
    PORT='8085'
    }
    stages {
        stage('Clean') {
            steps {
                sh '''
                kubectl delete deployment $NAME || true'''
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
                kubectl create deployment $NAME --image=$IMAGE --replicas=3
                '''
            }
        }
        stage('Run Deployment') {
            steps {
                echo 'I am alive'
            }
        }
    }
}
