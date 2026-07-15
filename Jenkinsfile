pipeline {
    agent any
    environment {
        svc = 'conn1'
        name = '1607'
    }

    stages {
        stage('Remove') {
            steps {
                sh '''kubectl remove deployment $name || true
                kubectl remove svc $svc || true
                '''
            }
        }
        stage('Build') {
            steps {
                sh 'podman build -t docker.io/mranshu6290/$name:$BUILD_NUMBER .'
            }
        }

        stage('Check') {
            steps {
                sh 'podman images | grep $name'
            }
        }
        stage('Upload') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub',
                                         usernameVariable: 'DOCKER_USER',
                                         passwordVariable: 'DOCKER_PASS')]) {
                    sh  ''' echo $DOCKER_PASS | podman login docker.io -u $DOCKER_USER --password-stdin

              podman push docker.io/mranshu6290/$name:$BUILD_NUMBER

                '''
                                         }
            }
        }
            stage('Deploy') {
                steps {
                    sh '''kubectl create deployment $name --replicas=3 \
                    --image=docker.io/mranshu6290/$name:$BUILD_NUMBER
                    '''
                }
            }
        stage('Expose') {
                steps {
                    sh '''
                    kubectl expose deployment $name  --name=$svc --type=NodePort --port=80
                    '''
                }
        }

            stage('Test') {
                steps {
                    sh 'kubectl get svc $svc -o wide'
                }
            }
            stage('AWS Infra') {
                steps {
                    echo 'I am alive'
                }
            }
    }
}

