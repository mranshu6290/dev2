pipeline {
    agent any
    environment {
        NAME = '1006'
        IMAGE = '1006img'
        SVC = 'conn'
    }

    stages {
        stage('Cleanup') {
            steps {
                sh 'kubectl delete deployment $NAME || true'
                sh 'kubectl delete service $SVC || true'
            }
        }
        stage('Build') {
            steps {
                sh ' podman build . -t docker.io/mranshu6290/$NAME:latest'
            }
        }

        stage('$NAMEing Image') {
            steps {
                sh 'podman images | grep $NAME'
            }
        }

stage('Build & Push') {
    steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub',
                                         usernameVariable: 'DOCKER_USER',
                                         passwordVariable: 'DOCKER_PASS')]) {
            sh '''
             
              echo $DOCKER_PASS | podman login docker.io -u $DOCKER_USER --password-stdin

              podman push docker.io/mranshu6290/$NAME:latest
            '''
        }
    }
}



        stage('Pull Image') {
            steps {
                sh '''
                  kubectl create deployment $NAME --image=docker.io/mranshu6290/$NAME --replicas=3
                sleep 3
                kubectl expose deployment $NAME --type=NodePort --port=80 --name=$SVC
                '''
            }
        }

        stage('$NAME Deployment') {
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
