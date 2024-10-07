pipeline {
    agent { docker { image 'python:3.12.7-alpine3.20' } }
    stages {
        stage('build') {
            steps {
                sh 'python --version'
                // Usar a credencial armazenada no Jenkins para a variável USUARIO
                withCredentials([string(credentialsId: 'USUARIO', variable: 'USUARIO')]) {
                    sh 'echo "O usuário é: $USUARIO"'
                }
            }
        }
    }
}