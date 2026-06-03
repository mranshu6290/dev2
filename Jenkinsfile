pipeline {
    agent any

    environment {
    NAME='0406'
    IMAGE='0406img'
    PORT='8088'
    }
    stages {
        stage('Clean') {
            steps {
                sh '''
                podman rm -f $NAME || true
                sleep 2'''
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
                echo 'I am alive'
            }
        }
    }
}
