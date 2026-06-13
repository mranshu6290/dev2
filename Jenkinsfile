pipeline {
    agent any

    environment {
        NAME = '1406'
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

        stage('build') {
            steps {
                sh '''
                podman build . -t docker.io/mranshu6290/$NAME
                '''
            }
        }
        stage('checkup') {
            steps {
                sh '''
                podman images | grep $NAME

                '''
            }
        }

        stage('Upload') {
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
    }
}
