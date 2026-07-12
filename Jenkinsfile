pipeline {
    agent any
    environment {
        svc = 'conn1'
        name = '1307'
    }

    stages {
        stage('CLeaanup') {
            steps {
                sh '''
                kubectl delete svc $svc || true
                kubectl delete deployment $name || true
                '''
            }
        }
        stage('Build') {
            steps {
                sh 'podman build -t docker.io/mranshu6290/$name:$BUILD_NUMBER .'
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
                sh '''kubectl create deployment $name --image=docker.io/mranshu6290/$name:$BUILD_NUMBER /
                 --replicas=3'''
            }
        }
        stage('Test') {
            steps {
                sh 'podman images | grep $name || true'
            }
        }
        stage('Alive1') {
            steps {
                echo 'I am alive'
            }
        }
    }
}

