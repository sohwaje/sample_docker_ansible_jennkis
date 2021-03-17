pipeline {
    agent any
    tools {
  		maven 'M2_HOME'  // maven home dir
  	}

    stages{
        stage('SCM'){
            steps{
                cleanWs()
                git branch: 'main', credentialsId: 'keenedge',
                url: 'http://1.209.6.225:18080/jaeholee/college.git'
            }
        }

        stage('Maven Build'){
            steps{
                sh "mvn clean install"
            }
        }

        stage('Docker Build'){
            steps{
                sh "docker build . -t hiclass.azurecr.io/lys:${BUILD_NUMBER}"
            }
        }

        stage('Dockerhub Push'){
            steps{
                withCredentials([string(credentialsId: 'azure-docker-registry', variable: 'azuredockerhub')]) {
                        sh "docker login hiclass.azurecr.io -u hiclass -p ${azuredockerhub}"
                }
                        sh "docker push hiclass.azurecr.io/college:${BUILD_NUMBER}"
             }
        }
        stage('Docker Deploy'){
            steps{
                ansiblePlaybook credentialsId: 'college-app.azure.i-screammedia.com', disableHostKeyChecking: true, extras: "-e DOCKER_TAG=${BUILD_NUMBER}", installation: 'ansible', inventory: 'dev.inv', playbook: 'deploy-docker.yml'
           }
        }
    }
}
