pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t mentorproj/ngi-jenkin-test1 .'
                }
                
            }
        }
        stage('Push image to Docker Hub') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'dockhubcred', variable: 'dockhub-cred')]) {
                    sh 'docker login -u sohanso -p ${dockhub-cred}'
                    }
                    sh 'docker push mentorproj/ngi-jenkin-test1'
                }
            }
        }
    }
}
