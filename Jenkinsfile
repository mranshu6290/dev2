pipeline {
    agent any

    environment {
    NAME='n0406'
    IMAGE='docker.io/mranshu6290/0406img'
    SVC='conn'
    }
    stages {
        stage('Clean') {
            steps {
                sh '''
                kubectl delete deployment $NAME || true'''
            }
        }
        stage('Build') {
            steps {
                sh '''
                podman build . -t $IMAGE
                '''
            }
        }
        stage('Run Pod') {
            steps {
                sh '''
                kubectl create deployment $NAME --image=$IMAGE --replicas=3
                sleep 3
                kubectl expose deployment $NAME --type=NodePort --port=80 --name=$SVC
                '''
            }
        }
        stage('Test Deployment') {
            steps {
                sh '''
                PORT=$(kubectl get svc $SVC -o jsonpath="{.spec.ports[0].nodePort}")
                curl -f localhost:$PORT
                '''
            }
        }
    }
}
