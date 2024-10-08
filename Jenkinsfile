pipeline {
    agent { docker { image 'python:3.12.7-alpine3.20' } }
    stages {
        stage('build') {
            steps {
                sh 'python --version'
                sh 'ls'
                sh 'pip install robotframework'
                sh 'robot tests/web/teste.robot'
            }
        }
    }
}