pipeline {
    agent any

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t sohanso/ngi-jenkin-test1 .'
                }
                
            }
        }
        stage('Push image to Docker Hub') {
            steps {
                script {
                    withCredentials([string(credentialsId: 'dockercred', variable: 'docker_cred')]){
                    sh 'docker login -u sohanso -p ${docker_cred}'
}

                    sh 'docker push sohanso/ngi-jenkin-test1'
                }
            }
        }
    }
}
