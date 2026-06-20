pipeline {
    agent any
    environment {
        NAME = '2106'
        SVC = 'conn4'
    }

    stages {
        stage('Cleanup') {
            steps {
                sh '''
kubectl remove deployment $NAME || true
kubectl remove svc $SVC || true
'''
            }
        }
        stage('Build') {
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
        stage('CHeck') {
            steps {
                sh ''' podman images | grep $NAME || true'''
            }
        }
        stage('Upload') {
            steps {
                sh '''podman login dockerhub.io'''
            }
        }
        stage('Test') {
            steps {
                echo 'Hello'
            }
        }
        stage('AWS Deployment') {
            steps {
                echo 'AWS Deployment'
            }
        }
    }
}

