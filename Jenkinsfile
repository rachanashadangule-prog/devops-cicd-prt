pipeline {
    agent { label 'docker-agent' }
    environment {
        IMAGE_NAME = "rachanashadangule/prt-webapp:latest"
    }
    stages {
        stage('Pull Code') {
            steps {
                checkout scm
            }
        }
        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }
        stage('Verify & Push Image') {
            steps {
                sh 'docker run --rm $IMAGE_NAME cat /usr/share/nginx/html/index.html | grep "PRT - CI/CD Completed Successfully"'
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
                    sh 'docker push $IMAGE_NAME'
                }
            }
        }
    }
}