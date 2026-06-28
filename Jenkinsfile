pipeline {
    environment {
        SVC = 'conn4'
        NAME = '2906'
    }
    agent any

    stages {
        stage('Alive') {
            steps {
                echo 'I am alive'
            }
        }
        stage('Cleanup') {
            steps {
                sh '''
                kubectl delete svc $SVC || true
                kubectl delete deployment $name || true
                '''
            }
        }
        stage('Build') {
            steps {
                sh 'podman build . -t $NAME'
            }
        }
         stage('Check') {
            steps {
                sh 'podman image | grep $NAME'
            }
        }
    }
}

