pipeline {
    agent any

    environment {
        PORT = '8083'
        NAME = 'my-nginx1'
    }

    stages {
        
        stage('Clean') {
            steps {
                sh "podman stop ${NAME}"
                sh "podman rm ${NAME}"
            }
        }
        
        
        stage('Run Pod') {
            steps {
                sh "podman run --restart=always -d -p ${PORT}:80 --name ${NAME} my-nginx-app"
            }
        }

        stage('Test Pod') {
            steps {
                sh "curl http://localhost:${PORT}"
            }
        }
    }
}
