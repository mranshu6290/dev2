pipeline {
    agent any

    environment {
        PORT = '8083'
        NAME = 'my-nginx1'

        IMAGE = 'nginx-git'
    }

    stages {
        stage('Build') {
            steps {
                sh "podman build -t ${IMAGE}} ."
            }

            stage('Clean') {
                steps {
                    sh "podman stop ${NAME}"
                    sh "podman rm ${NAME}"
                }
            }

            stage('Run Pod') {
                steps {
                    sh "podman run --restart=always -d -p ${PORT}:80 --name ${NAME} ${IMAGE}}"
                }
            }

            stage('Test Pod') {
                steps {
                    sh "curl http://localhost:${PORT}"
                }
            }
        }
    }
}
