pipeline {
    agent any

    environment {
        name = '0510'
        svc = 'conn2'
    }

    stages {
        stage('cleanup') {
            steps {
                sh '''
                kubectl delete svc $svc || true; \
                kubectl delete deployment $name || true '''
            }
        }
        stage('build_image') {
            steps {
                sh '''
podman build . -t docker.io/mranshu6290/$name:$BUILD_NUMBER
'''            }
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
        stage('expose') {
            steps {
                echo 'I am alive'
            }
        }
        stage('test') {
            steps {
                echo 'I am alive'
            }
        }
        stage('changes') {
            steps {
                echo 'I am alive'
            }
        }
        stage('terraform') {
            steps {
                echo 'I am alive'
            }
        }
    }
}
