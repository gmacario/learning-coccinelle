pipeline {
  agent {
    dockerfile {
      filename 'Dockerfile'
    }
    
  }
  stages {
    stage('Check') {
      steps {
        sh 'spatch --version'
        echo 'TODO: make coccicheck'
      }
    }
  }
}