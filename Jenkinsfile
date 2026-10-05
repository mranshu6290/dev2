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
        stage('uokoad') {
            steps {
                echo 'I am alive'
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
