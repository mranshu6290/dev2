pipeline {
    agent any

environment{
    IMAGE='img0306'
    NAME='0306'
    PORT='8082'
}
    stages {
        stage('cleanup') {
            steps {
                sh 'podman rm deployment $NAME || true'
                sh 'podman rm container $NAME || true'

            }
        }
        stage('build') {
            steps {
                sh 'podman build . -t $IMAGE'
            }
        }
        stage('run Pod only') {
            steps {
                sh 'ppodman run -d --name $NAME -p $PORT:80 -i $IMAGE'
            }
        }
    }
}
