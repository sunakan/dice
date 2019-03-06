pipeline {
  agent any
  options {
    buildDiscarder(logRotator(numToKeepStr: "3"))
  }
  stages {
    stage("checkout") {
      steps {
        checkout scm
      }
    }
    stage("docker-compose build") {
      steps {
        sh "docker-compose build"
      }
    }
  }
  post {
    always {
      echo "ALWAYS"
    }
  }
}
