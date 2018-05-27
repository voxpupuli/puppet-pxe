pipeline {
  agent any

  triggers { pollSCM('*/15 * * * *') }

  environment {
    PATH = "$PATH:~/.rbenv/bin"
  }

  stages {
    stage('test') {
      steps {
        sh '. .env.sh && printenv && bundle install --without=development system_tests'
        sh '. .env.sh && bundle exec rake test'
      }
    }

    stage('build') {
      when {
        branch 'master'
      }

      steps {
        sh 'git fetch --all --tags'
        sh '. .env.sh && bundle exec rake clean'
        sh '. .env.sh && bundle exec rake build'

        sh '. .env.sh && [ "$(git rev-list -n 1 $(git tag | tail -n 1 ))" == "$(git rev-list -n 1 HEAD)" ] && bundle exec rake module:push || echo HEAD is not a tag'
      }
    }
  }
}
