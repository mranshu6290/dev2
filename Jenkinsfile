pipeline {
    agent any
    environment {
        NAME = '1006'
        IMAGE = '1006img'
    }

    stages {
        stage('Cleanup') {
            steps {
                sh 'podman rm -f deplopyment $NAME || true'
            }
        }
        stage('Build') {
            steps {
                sh 'podman build . -t $IMAGE'
            }
        }

        stage('Test2') {
            steps {
                echo 'Testing'
            }
        }
    }
}
