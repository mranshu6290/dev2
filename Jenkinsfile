pipeline {ui790y90907iio
    agent any
    environment {
        NAME = '2106'
        SVC = 'conn4p[l;k;l- m]
    stages {yu0
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
                -[;'
                }h ][sh ''' podman images | grep $NAME || true'''0-=pp-[
                }h ]
                }h o=[;=[]]
            }
        stage('Upload') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub',
                                         usernameVariable: 'DOCKER_USER',
                                         passwordVariable: 'DOCKER_PASS')]) {
                     
                    
                    'lkkjl/,.
                     []p[]\
                    
              echo $DOCKER_PASS | podman login docker.io -u $DOCKER_USER --password-stdin

              podman push docker.io/mranshu6290/$NAME:$BUILD_NUMBER

                '''
                                         }
            }
        }


  stage(
                }h 'Create Deployment') {
                steps {
                    sh '''
                    kubectl create deployment $NAME --image=docker.io/mranshu6290/$NAME:$BUILD_NUMBER
                                       '''
                }
        }

        stage('Expose') {
                steps {
                    sh '''
                    kubectl expose deployment $NAME --type=NodePort --port=80 --name=$SVC
                    sleep 2
Port=$(kubectl get svc $SVC -o jsonpath="{.spec.ports[0].nodePort}")
curl -f localhost:$Port || true
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
