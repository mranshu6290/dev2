pipeline {
    agent any

    environment {
        NAME = '1206'
        SVC = 'conn'
    }
    stages {
        stage('Cleanup') {
            steps {
                sh '''
                kubectl delete deployment $NAME || true
                kubectl delete service $SVC || true

                '''
            }
        }
}}
