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
kubectl delete deployment $NAME || true
kubectl delete svc $SVC || true
'''
            }
        }
        stage('Build') {
                steps {
                    sh ''' podman build . -t docker.io/mranshu6290/$NAME:$BUILD_NUMBER'''
                }
        }

            stage('CHeck') {
                steps {
                    sh ''' podman images | grep $NAME || true'''
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

        stage('Expose') {
                steps {
                    sh '''
                    kubectl expose deployment $NAME --type=NodePort --port=80 --name=$SVC
                    sleep 2
kubectl get svc $SVC -o wide
                    '''
                }
        }
            stage('AWS Deployment') {
                steps {
                    echo 'AWS Deployment1'
                }
            }
    }
}
