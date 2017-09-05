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
    stage('Checkout from git') {
      steps {
        sh '''cd && [ ! -e linux-mainline ] && git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-mainline
cd ~/linux-mainline && git fetch --all --prune'''
      }
    }
  }
}