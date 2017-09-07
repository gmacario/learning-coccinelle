pipeline {
  agent {
    dockerfile {
      filename 'Dockerfile'
    }
  }
  parameters {
    // string(name: 'GITHUB_USER', defaultValue: 'torvalds', description: 'GitHub username or organization')
    // string(name: 'GITHUB_REPO', defaultValue: 'linux', description: 'GitHub repository')
    string(name: 'GIT_URL', defaultValue: 'https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git', description: 'Git URL')
    string(name: 'GIT_BRANCH', defaultValue: 'master', description: 'Git branch')
    // TODO
  }
  environment {
    GIT_URL = "${params.GIT_URL}"
    GIT_BRANCH = "${params.GIT_BRANCH}"
  }
  stages {
   stage('Checkout from git') {
      steps {
        sh '''#!/bin/bash -xe

# DEBUG
id
pwd
ls -la
printenv | sort

[ ! -e linux-mainline ] && git clone -b ${GIT_BRANCH} ${GIT_URL} linux-mainline
cd linux-mainline && git checkout ${GIT_BRANCH} && git pull --all --prune

# EOF'''
      }
    }
    stage('Semantic Checks') {
      steps {
        sh '''#!/bin/bash -xe

# DEBUG
id
pwd
ls -la
printenv | sort

cd linux-mainline

# DEBUG
ls -la
ls -la scripts
# ls -la scripts/coccinelle
find scripts/coccinelle -name "*.cocci" -ls
spatch --version
git status
git show -s

# Run a specific semantic patch on a specific module
make coccicheck M=kernel/sched COCCICHECK=scripts/coccinelle/null/badzero.cocci MODE=report

## Run all semantic patches against the whole Linux kernel source tree
## WARNING: On ies-genbld01-ub16 it will take a few days to complete!
# make coccicheck || true

# EOF'''
      }
    }
  }
}
