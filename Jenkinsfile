pipeline {
    agent any
    environment {
        name = '2607'
        svc = 'conn1'
    }
    stages {
        stage('cleanup') {
            steps {
                sh '''kubectl delete deployment $name || true \
                kubectl delete svc $svc || true
                                '''
            }
        }
        stage('build') {
            steps {
                sh '''podman build . -t docker.io/mranshu6290/$name:$BUILD_NUMBER'''
            }
        }
        stage('image check') {
            steps {
                sh 'podman images | grep $name || true'
            }
        }
        stage('upload') {
            steps {
                echo 'I am testing'
            }
        }
        stage('expose') {
            steps {
                echo 'I am testing'
            }
        }
        stage('final test') {
            steps {
                echo 'I am testing'
            }
        }
        stage('aws') {
            steps {
                echo 'I am testing'
            }
        }
    }
}

