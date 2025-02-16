pipeline {
    agent any

    environment {
        DOCKER_PATH='/usr/local/bin/docker' 
        DOCKER_HUB_CREDENTIALS = credentials('dockerhub-credentials')
        IMAGE_NAME = "kunalpuri123/flask-app"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', credentialsId: 'git-token', url: 'https://github.com/kunalpuri123/flask-jenkins-docker.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh '${DOCKER_PATH} build -t $IMAGE_NAME .'
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                script {
                    sh 'echo $DOCKER_HUB_CREDENTIALS_PSW | docker login -u $DOCKER_HUB_CREDENTIALS_USR --password-stdin'
                    sh '${DOCKER_PATH} push $IMAGE_NAME'
                }
            }
        }

        stage('Deploy Application') {
            steps {
                
                    sh """
                   
                        ${DOCKER_PATH} pull $IMAGE_NAME &&
                        ${DOCKER_PATH} stop flask_app || true &&
                        ${DOCKER_PATH} rm flask_app || true &&
                        ${DOCKER_PATH} run -d --name flask_app -p 5000:5000 $IMAGE_NAME
                    
                    """
                
            }
        }
    }
}
