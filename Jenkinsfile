pipeline {
    agent any
    environment {
        svc = 'conn1'
        name = '2707'
    }

    stages {
        stage('cleanup') {
            steps {
                sh '''
                kubectl delete svc $svc || true; \
                kubectl delete $name || true '''
            }
        }
        stage('build image') {
            steps {
                sh '''
                podman build . -t docker.io/mranshu6290/$name:$BUILD_NUMBER
                '''
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
        stage('upload image') {
            steps {
                echo 'I am alive'
            }
        }
        stage('create deployment') {
            steps {
                sh '''kubectl create deployment $name --image=docker.io/mranshu6290/$name:$BUILD_NUMBER \
                --replicas=3
                '''
            }
        }
        stage('expose') {
            steps {
                sh '''kubectl expose deployment $name --type=NodePort --port=80 --name=$svc'''
            }
        }
        stage('test') {
            steps {
                echo 'I am alive'
            }
        }
        stage('aws') {
            steps {
                echo 'I am alive'
            }
        }
        stage('changeimage') {
            steps {
                echo 'I am alive'
            }
        }
    }
}
