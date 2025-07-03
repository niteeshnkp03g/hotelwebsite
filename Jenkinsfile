
pipeline {
    agent any

    environment {
        IMAGE_NAME = "dockerp241/hotelwebsite"
        TAG = "latest"
        CONTAINER_NAME = "hotelwebsite-container"
    }

    stages {
        stage('Clone') {
            steps {
                git url: 'https://github.com/niteeshnkp03g/hotelwebsite', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME:$TAG .'
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
                        docker push $IMAGE_NAME:$TAG
                    '''
                }
            }
        }

        stage('Deploy Container') {
            steps {
                sh '''
                    docker rm -f $CONTAINER_NAME || true
                    docker run -d -p 1234:80 --name $CONTAINER_NAME $IMAGE_NAME:$TAG
                '''
            }
        }
    }
}

