pipeline {
    agent any

    // Parameters for user to select OS and Architecture
    parameters {
        choice(
            name: 'ARCH',
            choices: ['TARGETARCH=amd64', 'TARGETARCH=arm64'],
            description: 'Select the target ARCH'
        )
    }

    environment {
        REPO = "https://github.com/SartSR/kbot"
        BRANCH = "main"
    }

    stages {
        stage('Clone') {
            steps {
                echo 'Cloning repository...'
                git branch: "${BRANCH}", url: "${REPO}"
            }
        }

        stage('Test') {
            steps {
                echo 'Executing tests...'
                sh 'make test'
            }
        }

        stage('Build') {
            steps {
                echo 'Building application...'
                sh "make build ${params.ARCH}"
            }
        }

        stage('Docker Image') {
            steps {
                echo 'Building Docker image...'
                sh "make image ${params.ARCH}"
            }
        }

        stage('Docker Image Push') {
            steps {
                script {
                    docker.withRegistry('', 'dockerhub'){
                    sh 'make push'
                    }
                }
            }
        }

        stage('Clean') {
            steps {
                echo 'Cleaning previous builds...'
                sh 'make clean'
            }
        }
    }
}