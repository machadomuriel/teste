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
                HOME_DIR=$(eval echo ~$USER)
                mkdir -p $HOME_DIR/.local/lib/python3.12/site-packages
                export PYTHONUSERBASE=$HOME_DIR/.local
                pip install --user robotframework
                '''
                sh 'robot tests/web/teste.robot'
            }
        }
    }
}
