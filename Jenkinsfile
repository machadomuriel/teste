pipeline {
    agent { 
        docker { 
            image 'python:3.12.7-alpine3.20' 
        } 
    }
    stages {
        stage('build') {
            steps {
                sh 'python --version'
                sh 'ls'
                sh '''
                echo "HOME: $HOME"
                mkdir -p $HOME/.local/lib/python3.12/site-packages || { echo "Failed to create directory"; exit 1; }
                export PYTHONUSERBASE=$HOME/.local
                pip install --user robotframework
                '''
                sh 'robot tests/web/teste.robot'
            }
        }
    }
}
