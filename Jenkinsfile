pipeline {
    agent any
    environment {
        name = '2607'
        svc = 'conn1'
    }
    stages {
        stage('cleanup') {
            steps {
                sh '''kubectl remove deployment $name || true \
                kubectl remove svc $svc || true
                                '''
            }
        }
        stage('build') {
            steps {
                sh '''podman build . -t docker.io/mranshu6290/$name:$BUILD_NUMBER'''
            }
        }
        stage('image check') {
            steps {
                sh 'podman images | grep $name || true'
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

        stage('create') {
            steps {
                sh '''kubectl create deployment $name --replicas=3 \
                --image=docker.io/mranshu6290/$name:$BUILD_NUMBER
                '''
            }
        }
        stage('expose') {
            steps {
                sh ''' 
                kubectl expose deployment $name --type=NodePort \
                --port=80 \
                --name=$svc
                '''
            }
        }
        stage('final test') {
            steps {
                echo 'I am testing'
            }
        }
        stage('aws') {
            steps {
                echo 'I am testing'
            }
        }
    }
}

