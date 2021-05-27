pipeline {
    agent any
    environment {
        //be sure to replace "maxtonk/eschool-back" with your own Docker Hub username and repository
        DOCKER_IMAGE_NAME_BACK = "maxtonk/eschool-back"
    }
    stages {
        stage('checkout'){
            steps{
                git branch: 'master', url: 'https://github.com/tonkonozhenko-mi/eSchool.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    app = docker.build(DOCKER_IMAGE_NAME_BACK)
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'Docker_Hub') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
        stage('Deploy To Kuber Cluster AWS') {
            steps {
                input 'Deploy to Production?'
                milestone(1)
                kubernetesDeploy(
                    kubeconfigId: 'kubeconfig',
                    configs: 'kubernetes-back.yml',
                    enableConfigSubstitution: true
                )
            }
        }
    }
}
