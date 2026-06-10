pipeline {
    agent any
    environment {
        NAME = '1106'
        // IMAGE = '1106img'
        SVC = 'conn'
    }

    stages {
        stage('Cleanup') {
            steps {
                // sh 'kubectl delete deployment $NAME || true'
                sh 'kubectl delete service $SVC || true'
            }
        }
        stage('Build') {
            steps {
                sh 'podman build . -t docker.io/mranshu6290/$NAME:${BUILD_NUMBER}'
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
                sh '''
kubectl set image deployment/$NAME \
                    $NAME=docker.io/mranshu6290/$NAME:$BUILD_NUMBER || true

                kubectl create deployment $NAME \
                --image=docker.io/mranshu6290/$NAME:$BUILD_NUMBER --replicas=3 || true

             kubectl expose deployment $NAME \
                    --type=NodePort \
                    --port=80 \
                    --name=$SVC || true
                '''
            }
        }
        stage('Test') {
            steps {
                sh '''
                PORT=$(kubectl get svc $SVC -o jsonpath="{.spec.ports[0].nodePort}")
                    sleep 5
                    curl -f localhost:$PORT

                '''
            }
        }
    }
}
