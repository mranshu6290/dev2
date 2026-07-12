pipeline {
    agent any
    environment {
        svc = conn1
        name = 1307
    }

    stages {
        stage('CLeaanup') {
            steps {
                sh '''
                kubeclt remove svc $svc
                kubectl remove deployment $name
                '''
            }
        }
        stage('Build') {
            steps {
                sh 'podman build -t docker.io/mranshu6290/$name:$BUILD_NUMBER'
            }
        }
        stage('Upload') {
            steps {
                echo 'I am alive'
            }
        }
        stage('Deploy') {
            steps {
                echo 'I am alive'
            }
        }
        stage('Test') {
            steps {
                echo 'I am alive'
            }
        }
        stage('Alive1') {
            steps {
                echo 'I am alive'
            }
        }
    }
}

