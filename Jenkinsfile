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
        sh "docker exec dice_app dockerize -wait tcp://mariadb:3306 -timeout 1m"
        sh "docker exec dice_app bundle exec rake db:create RAILS_ENV=test"
        sh "docker exec dice_app bundle exec rake ext_db:create RAILS_ENV=test"
        sh "docker exec dice_app bundle exec ridgepole -c config/database.yml -E test --apply -f db/Schemafile"
        sh "docker exec dice_app bundle exec rake ext_db:ridgepole:apply RAILS_ENV=test"
      }
    }
    stage("rspec") {
      steps {
        sh "docker exec -e RAILS_ENV=test -e SPEC_OPTS='--no-color' -i dice_app bundle exec rspec --format RspecJunitFormatter --out spec/reports/rspec.xml --format progress spec"
      }
    }
  }
  post {
    always {
      //sh "docker-compose down"
      junit "spec/reports/rspec.xml"
      cobertura autoUpdateHealth: false, autoUpdateStability: false, coberturaReportFile: 'coverage/coverage.xml', conditionalCoverageTargets: '70, 0, 0', failUnhealthy: false, failUnstable: false, lineCoverageTargets: '80, 0, 0', maxNumberOfBuilds: 0, methodCoverageTargets: '80, 0, 0', onlyStable: false, sourceEncoding: 'ASCII', zoomCoverageChart: false
    }
  }
}
