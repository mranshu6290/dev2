pipeline {
    agent any
    environment {
        NAME = '1006'
        IMAGE = '1006img'
        SVC='conn'
    }

    stages {
        stage('Cleanup') {
            steps {
                sh 'podman rm -f deployment $NAME || true'
                sh 'podman rm -f service $SVC || true'
            }
        }
        stage('Build') {
            steps {
                sh 'podman build . -t $IMAGE'
            }
        }

        stage('Testing Image') {
            steps {
                sh 'podman images | grep $IMAGE'
            }
        }
        stage('Pull Image') {
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
                sleep 2
                curl -f localhost:$PORT || true
                '''
            }
        }
    }
}
