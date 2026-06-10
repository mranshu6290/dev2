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
                sh 'podman build . -t $NAME:${BUILD_NUMBER}'
            }
        }
        stage('Build & Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub',
                                         usernameVariable: 'DOCKER_USER',
                                         passwordVariable: 'DOCKER_PASS')]) {
                    sh '''

              echo $DOCKER_PASS | podman login docker.io -u $DOCKER_USER --password-stdin

              podman push docker.io/mranshu6290/$NAME:$BUILD_NUMBER
            '''
                                         }
            }
        }
        stage('Deploy') {
            steps {
                sh 'kubectl create deployment $NAME --image=dockerhub.io/mranshu6290:$NAME:$BUILD_NUMBER --replicas=3 || true'
            }
        }
        stage('Test') {
            steps {
                echo 'I am alive'
            }
        }
    }
}
