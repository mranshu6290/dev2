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
                sh 'podman rm deployment $NAME || true'

                sh 'podman rm container $NAME || true'
            }
        }
        stage('Build') {
            steps {
                sh 'podman build . -t $IMAGE'
            }
        }
        stage('Run Pod') {
            steps {
                sh 'podman run -d -it $IMAGE -p $PORT:80 --name $NAME'
            }
        }
        stage('Run Deployment') {
            steps {
                sh 'I am alive'
            }
        }
    }
}
