
pipeline {
    agent any

    environment {
        IMAGE_NAME = "dockerp241/hotelwebsite"
        TAG = "latest"
        DOCKER_HUB_CREDENTIALS = "dockerhub"
    }

    stages {
        stage('Clone') {
            steps {
                git url: 'https://github.com/niteeshnkp03g/hotelwebsite', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}:${TAG}")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', "${DOCKER_HUB_CREDENTIALS}") {
                        docker.image("${IMAGE_NAME}:${TAG}").push()
                    }
                }
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                    docker rm -f hotelwebsite-container || true
                    docker run -d -p 1234:80 --name hotelwebsite-container ${IMAGE_NAME}:${TAG}
                '''
            }
        }
    }
}
