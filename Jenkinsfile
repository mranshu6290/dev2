pipeline {
    agent any
    environment {
        NAME = '1006'
        IMAGE = '1006img'
        SVC = 'conn'
    }

    stages {
        stage('Cleanup') {
            steps {
                sh 'kubectl delete service $SVC || true'
            }
        }
        stage('Build') {
            steps {
                sh "podman build . -t docker.io/mranshu6290/$NAME:$BUILD_NUMBER"
            }
        }

        stage('$NAMEing Image') {
            steps {
                sh 'podman images | grep $NAME'
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

        stage('Pull Image') {
            steps {
                sh '''
                  kubectl create deployment $NAME --image=docker.io/mranshu6290/$NAME:$BUILD_NUMBER --replicas=3
                sleep 3
                kubectl expose deployment $NAME --type=NodePort --port=80 --name=$SVC
                '''
            }
        }
stage('Deploy (FIXED - Rolling Update)') {
            steps {
                sh """
                    # 🟢 Try rolling update first (THIS ENABLES ROLLBACK)
                    kubectl set image deployment/$NAME \
                    $NAME=docker.io/mranshu6290/$NAME:$BUILD_NUMBER || true

                    # 🟢 If first deploy (no deployment exists)
                    kubectl create deployment $NAME \
                    --image=docker.io/mranshu6290/$NAME:$BUILD_NUMBER \
                    --replicas=3 || true

                    # 🟢 Expose service only once
                    kubectl expose deployment $NAME \
                    --type=NodePort \
                    --port=80 \
                    --name=$SVC || true

                    sleep 5
                """
            }
        }
        stage('$NAME Deployment') {
            steps {
                script {
                    def status = sh(
                script: '''
                    PORT=$(kubectl get svc $SVC -o jsonpath="{.spec.ports[0].nodePort}")
                    sleep 2
                    curl -f localhost:$PORT
                ''',
                returnStatus: true
            )

                    if (status != 0) {
                        echo '❌ Health check failed — triggering rollback'

                        sh "kubectl rollout history deployment $NAME"
                        sh "kubectl rollout undo deployment $NAME"

                        error('Rollback executed due to failed deployment')
            } else {
                        echo '✅ Deployment healthy'
                    }
                }
            }
        }
    }
}
