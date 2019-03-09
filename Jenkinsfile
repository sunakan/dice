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
    //composeでhost側のdocker.sockを使うとコメントアウトしている部分は不要
    // - composeを使っているのでhostでcompose upしていたらportがバッティングする
    //stage("docker-compose build app") {
    //  steps {
    //    sh "docker-compose build app"
    //  }
    //}
    //stage("docker-compose up -d app") {
    //  steps {
    //    sh "docker-compose up -d app"
    //  }
    //}
    stage("setup db") {
      steps {
        sh "docker-compose exec app dockerize -wait tcp://mariadb:3306 -timeout 1m"
        sh "docker-compose exec app bundle exec rake db:create RAILS_ENV=test"
        sh "docker-compose exec app bundle exec rake ext_db:create RAILS_ENV=test"
        sh "docker-compose exec app bundle exec ridgepole -c config/database.yml -E test --apply -f db/Schemafile"
        sh "docker-compose exec app bundle exec rake ext_db:ridgepole:apply RAILS_ENV=test"
      }
    }
    stage("rspec") {
      steps {
        sh "docker-compose exec app bundle exec rspec"
      }
    }
  }
  post {
    always {
      //sh "docker-compose down"
      echo "ALWAYS"
    }
  }
}
