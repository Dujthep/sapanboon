pipeline {
  agent any
  environment {
    ENV_DEPLOY = 'prod'
    NAMESPACE = 'sapanboon'
    APP_NAME = 'sapanboon-phx'
    GIT_HOST = 'gitlab.odds.team'
    REGISTRY = 'registry.odds.team'
  }
  options {
    timeout(time: 1, unit: 'HOURS')
  }
  stages {
    stage('checkout') {
      steps {
        cleanWs()
        git branch: 'develop', credentialsId: 'sapanboon-gitlab-odds', url: "https://${env.GIT_HOST}/${env.NAMESPACE}/${env.APP_NAME}.git"
      }
    }
    stage('registry') {
      steps {
        script{
          withDockerRegistry(credentialsId: 'sapanboon-gitlab-odds', url: "https://${env.REGISTRY}") {
            def image = docker.build("${env.REGISTRY}/${env.NAMESPACE}/${env.APP_NAME}", "--build-arg ENV_DEPLOY=$ENV_DEPLOY .")
            image.push()
          }
        }
      }
    }
    stage('start') {
      steps {
        sh '''#!/bin/bash -xe
          ssh nc-user@139.5.145.171 /home/nc-user/sapanboon-cmd/phx.sapanboon.org/run.sh
        '''
      }
    }
  }
  post {
    success {
      withCredentials([string(credentialsId: 'sapanboon-slack-token', variable: 'slackCredentials')]) {
        slackSend (token: slackCredentials, color: '#00FF00', message: "SUCCESSFUL: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
      }
    }
    failure {
      withCredentials([string(credentialsId: 'sapanboon-slack-token', variable: 'slackCredentials')]) {
        slackSend (token: slackCredentials, color: '#FF0000', message: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]' (${env.BUILD_URL})")
      }
    }
  }
}
