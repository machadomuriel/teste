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
                # Definindo um diretório temporário para instalação
                TEMP_DIR=/tmp/.local/lib/python3.12/site-packages
                mkdir -p $TEMP_DIR || { echo "Failed to create directory"; exit 1; }
                
                # Definindo a variável de ambiente PYTHONUSERBASE
                export PYTHONUSERBASE=/tmp/.local

                # Adicionando o diretório ao PATH
                export PATH=$PATH:/tmp/.local/bin
                
                # Instalando o Robot Framework
                pip install --user robotframework
                
                # Executando o Robot Framework
                robot tests/web/teste.robot
                '''
            }
        }
    }
}
