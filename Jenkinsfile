pipeline {
    agent any
    parameters{
        choice(choices:['Build','Delete'], description: 'Build parameter choices', name: 'build')
    }

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
                withCredentials([usernamePassword(credentialsId: 'dockerhubCredentialsUday', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
                sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                sh 'docker push uday27/cicd-devops-webapp:latest'
                }
            }
        }

        stage('pull image'){
            steps{
                withCredentials([usernamePassword(credentialsId: 'dockerhubCredentialsUday', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
                sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
                sh 'docker pull uday27/cicd-devops-webapp:latest'
                }

            }
        }
        stage('deploy'){
            when{
                        expression{params.build == 'Build' }
                    }
            steps{
                sh 'docker run -d --name=cicd-devops-app uday27/cicd-devops-webapp:latest'
                }
            }
        stage('delete'){
            when{
                        expression{params.build == 'Delete' }
                    }
            steps{
                sh 'docker stop cicd-devops-app'
                sh 'docker rm cicd-devops-app'
            }
        }
    }
}