pipeline {
    agent any

environment{
    IMAGE='img0306'
    NAME='0306'
}
    stages {
        stage('cleanup') {
            steps {
                sh 'podman delete deployment $NAME || true'
            }
        }
        stage('build') {
            steps {
                sh 'podman build . -t $NAME'
            }
        }
        stage('run Pod only') {
            steps {
                sh 'podman run -d --name anshu -p 8085:80 -i localhost/$IMAGE'
            }
        }
    }
}
