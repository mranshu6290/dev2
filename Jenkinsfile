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
                sh 'kubectl delete svc $SVC || true'
            }
        }
        stage('Build') {
            steps {
                sh 'podman build . -t docker.io/mranshu6290/$NAME:$BUILD_NUMBER'
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
                sh '''kubectl create deployment $NAME \
                --image=docker.io/mranshu6290/$NAME:$BUILD_NUMBER --replicas=3
                kubectl expose deployment $NAME --port=80 --type=NodePort --name=$SVC
                sleep 5

'''
            }
        }

        stage('Test') {
            steps {
                sh '''
Port=$(kubectl get svc $SVC -o jsonpath="{.spec.ports[0].nodePort}")
                curl -f localhost:$Port

                '''
            }
        }
        stage('AWS Infra') {
            steps {
                echo 'I am cleanup o 1506'
            }
        }
    }
}
