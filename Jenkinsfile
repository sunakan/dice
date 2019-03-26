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
        sh "docker exec -e RAILS_ENV=test -i dice_app bundle exec rspec --no-color --format RspecJunitFormatter --out spec/reports/rspec.xml --format progress spec"
      }
    }
    stage("copy reports") {
      steps {
        sh "mkdir -p spec/reports"
        sh "docker cp dice_app:/app/spec/reports/rspec.xml spec/reports/rspec.xml"
        sh "docker cp dice_app:/app/coverage coverage"
      }
    }
  }
  post {
    always {
      echo "=====rspec result"
      sh "head -n 2 spec/reports/rspec.xml | tail -n 1 | awk 'gsub(/\"/, \"\") {print \$3,\$4,\$5,\$6}'"
      echo "====="
      junit "spec/reports/rspec.xml"
      cobertura(
        autoUpdateHealth: false,
        autoUpdateStability: false,
        coberturaReportFile: "coverage/coverage.xml",
        conditionalCoverageTargets: "70, 0, 0",
        failUnhealthy: false,
        failUnstable: false,
        lineCoverageTargets: "80, 0, 0",
        maxNumberOfBuilds: 0,
        methodCoverageTargets: "80, 0, 0",
        onlyStable: false,
        sourceEncoding: "ASCII",
        zoomCoverageChart: false
      )
    }
  }
}
