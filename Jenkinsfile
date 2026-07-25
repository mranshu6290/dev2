pipeline {
    agent any
    environment {
        name = '2607'
        svc = 'conn1'
    }
    stages {
        stage('cleanup') {
            steps {
                sh '''kubectl delete deployment $name || true; \
                kubectl delete svc $svc || true
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
        stage('scan') {
            steps {
                echo 'testing inage'
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
        stage('get service') {
            steps {
                sh '''

              port=$(kubectl get svc $svc -o jsonpath='{.spec.ports[0].nodePort}')

            curl -f localhost:$port || true
                '''
            }
        }

                stage('aws') {
            steps {
                sh '''kubectl set image deployment/$name $name=nginx:latest; \
             if kubectl rollout status deployment/$name --timeout=20s
then
    echo "Deployment successful"
else
    echo "Deployment failed"
    kubectl rollout undo deployment/$name
fi
                '''
            }
                }
    }
}
