pipeline {
    agent any

    environment {
        NAME = '1506'
        SVC = 'conn'
    }

    stages {
        stage('Cleanup') {
            steps {
                sh 'kubectl delete deployment $NAME || true'
            }
        }
        stage('Build') {
            steps {
                sh 'podman build . -t dockerhub.io/mranshu6290/$NAME:$BUILD_NUMBER'
            }
        }
        stage('Docker Image check') {
            steps {
                sh 'podman images | grep $NAME'
            }
        }
        stage('Docker Upload') {
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
                sh 'kubectl create deployment $NAME \
                --image=docker.io/mranshu6290/$NAME:$BUILD_NUMBER --replicas=3'
            }
        }

         stage('Test') {
            steps {
                sh 'kubectl get deployments $NAME -o wide || true'
            }
        }
        stage('AWS Infra') {
            steps {
                echo 'I am cleanup o 1506'
            }
        }
    }
}
