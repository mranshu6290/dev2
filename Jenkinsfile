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
                sh 'podman build . -t docker.io/mranshu6290/$NAME:$BUILD_NUMBER'
            }
        }
        stage('Check') {
            steps {
                sh 'podman images | grep $NAME'
            }
        }
        stage('Upload') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub',
                                         usernameVariable: 'DOCKER_USER',
                                         passwordVariable: 'DOCKER_PASS')]) {
                  sh  ''' echo $DOCKER_PASS | podman login docker.io -u $DOCKER_USER --password-stdin

              podman push docker.io/mranshu6290/$NAME:$BUILD_NUMBER

                '''
                                         }
            }
        }

        stage('Deployment') {
            steps {
                sh '''
                kubectl create deployment $NAME --image=docker.io/mranshu6290/$NAME:$BUILD_NUMBER --replica=3
                '''
            }
        }
        stage('Expose') {
            steps {
                sh 'podman images | grep $NAME'
            }
        }
        stage('Test') {
            steps {
                sh 'podman images | grep $NAME'
            }
        }
        stage('AWS Deployment') {
            steps {
                sh 'podman images | grep $NAME'
            }
        }
    }
}
