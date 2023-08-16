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
        stage('Run Latest Docker Image') {
            steps {
                script {
                    sh 'docker run -d --name website_1 -p 8081:8081 --pull always sohanso/ngi-jenkin-test1  '
                }
            }
        }
    }
}
