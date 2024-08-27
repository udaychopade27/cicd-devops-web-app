pipeline {
    agent any
    stages{
        stage('Checkout'){
            steps {
                sh "git --version"
                sh "docker -v"
                sh "echo Branch name: ${GIT_BRANCH}"
            }
        }
        stage('build app'){
            steps{
                sh 'docker build -t uday27/cicd-devops-webapp .'
            }

        }
        stage('push image to dockerhub'){
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
                sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                sh 'docker push uday27/cicd-devops-webapp:latest'
                }
            }
        }

        stage('pull image'){
            steps{
                withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
                sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                sh 'docker pull uday27/cicd-devops-webapp:latest'
                }

            }
        }
        stage('deploy'){
            steps{
                sh 'docker run -d -p 3002:3000 uday27/cicd-devops-webapp:latest'
                }
            }
    }
}