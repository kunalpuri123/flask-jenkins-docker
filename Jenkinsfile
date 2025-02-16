pipeline {
    agent any

    environment {
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
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Push Image to Docker Hub') {
            steps {
                script {
                    sh 'echo $DOCKER_HUB_CREDENTIALS_PSW | docker login -u $DOCKER_HUB_CREDENTIALS_USR --password-stdin'
                    sh 'docker push $IMAGE_NAME'
                }
            }
        }

        stage('Deploy Application') {
            steps {
                
                    sh """
                   
                        docker pull $IMAGE_NAME &&
                        docker stop flask_app || true &&
                        docker rm flask_app || true &&
                        docker run -d --name flask_app -p 5000:5000 $IMAGE_NAME
                    
                    """
                
            }
        }
    }
}
