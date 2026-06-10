pipeline {
    agent any
    environment {
        NAME = '1106'
       // IMAGE = '1106img'
    }

    stages {
        stage('Cleanup') {
            steps {
                sh 'kubectl remove deployment $NAME || true'
            }
        }
        stage('Build') {
            steps {
                sh 'podman build . -t $NAME:{BUILD_NUMBER}'
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
    }
}
