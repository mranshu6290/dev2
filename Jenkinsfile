pipeline {
    agent any
    environment {
        NAME = '1606'
        SVC = 'conn3'
    }

    stages {
        stage('Cleanup') {
            steps {
                sh '''
                kubectl remove deployment $NAME || true
                kubectl remove svc $NAME || true
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
                    sh '''

              echo $DOCKER_PASS | podman login docker.io -u $DOCKER_USER --password-stdin

              podman push docker.io/mranshu6290/$NAME:$BUILD_NUMBER

                '''
                                         }
            }
        }
        stage('Deploy') {
            steps {
                sh 'kubectl create deployment $NAME --image=docker.io/mranshu6290/$NAME:$BUILD_NUMBER --replicas=3'
            }
        }
        stage('Test') {
            steps {
                sh '''
                kubectl expose deployment $NAME --name=$SVC --type=NodePort --port=80
                sleep 5
                kubectl get svc $SVC
                '''
            }
        }
            stage('Infra') {
            steps {
                echo 'I am alive'
            }
            }
    }
}
