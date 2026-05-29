pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Environment Logic') {
            steps {
                script {
                    // Detect branch, fallback if detached
                    env.ACTUAL_BRANCH = sh(
                        script: "git symbolic-ref --short HEAD || echo 'detached'",
                        returnStdout: true
                    ).trim()

                    echo "Detected branch: ${env.ACTUAL_BRANCH}"

                    if (env.ACTUAL_BRANCH == 'main') {
                        echo "🚀 Deploying to PROD"
                    } else if (env.ACTUAL_BRANCH == 'dev') {
                        echo "🧪 Deploying to DEV"
                    } else {
                        echo "⚙️ Feature branch, only build and test"
                    }
                }
            }
        }
    }
}
