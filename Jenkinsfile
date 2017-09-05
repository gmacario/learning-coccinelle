pipeline {
  agent {
    dockerfile {
      filename 'Dockerfile'
    }
    
  }
  stages {
   stage('Checkout from git') {
      steps {
        sh '''#!/bin/bash

# DEBUG
id
pwd
ls -la

cd && [ ! -e linux-mainline ] && git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-mainline
cd ~/linux-mainline && git fetch --all --prune

# EOF'''
      }
    }
    stage('Semantic Checks') {
      steps {
        sh '''#!/bin/bash -xe

# DEBUG
pwd
ls -la

cd linux-mainline

# DEBUG
ls -la
ls -la scripts
ls -la scripts/cocci
spatch --version

make coccicheck

# EOF'''
      }
    }
  }
 }
