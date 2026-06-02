pipeline {
    agent any

environment{
    IMAGE='img0306'
    NAME='0306'
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
                sh 'podman run -d --name $NAME -p 8085:80 -i $IMAGE'
            }
        }
    }
}
