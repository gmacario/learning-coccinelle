pipeline {
  agent {
    dockerfile {
      filename 'Dockerfile'
    }
  }
  parameters {
    string(name: 'GIT_URL', defaultValue: 'https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git', description: 'Git URL')
    string(name: 'GIT_BRANCH', defaultValue: 'master', description: 'Git branch')
    string(name: 'GIT_TAG', defaultValue: '', description: 'Git tag')
    //
    string(name: 'CK_SUBDIR', defaultValue: 'kernel/sched', description: 'Linux subdirectory to check')
    string(name: 'CK_COCCI', defaultValue: 'scripts/coccinelle/null/badzero.cocci', description: 'Semantic patch to apply')
    string(name: 'CK_MODE', defaultValue: 'report', description: 'coccicheck mode (report|patch|context|chain|org|...)')
  }
  environment {
    GIT_URL = "${params.GIT_URL}"
    GIT_BRANCH = "${params.GIT_BRANCH}"
    GIT_TAG = "${params.GIT_TAG}"
    CK_SUBDIR = "${params.CK_SUBDIR}"
    CK_COCCI = "${params.CK_COCCI}"
    CK_MODE = "${params.CK_MODE}"
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

[ ! -e linux-mainline ] && git clone ${GIT_URL} linux-mainline
cd linux-mainline && git fetch --all --prune
if [ "${GIT_BRANCH}" != "" ]; then
  git checkout ${GIT_BRANCH} && git pull
fi
if [ "${GIT_TAG}" != "" ]; then
  git checkout ${GIT_TAG};
fi

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
# ls -la
# ls -la scripts
# ls -la scripts/coccinelle
find scripts/coccinelle -name "*.cocci" -ls
spatch --version
git status
git show -s

# Parameterized check
make coccicheck M=${CK_SUBDIR} COCCICHECK=${CK_COCCI} MODE=${CK_MODE}

## Run one semantic patch against one Linux source subdir
# make coccicheck M=kernel/sched COCCICHECK=scripts/coccinelle/null/badzero.cocci MODE=report

## Run all semantic patches against the whole Linux kernel source tree
## WARNING: On ies-genbld01-ub16 it will take a few days to complete!
# make coccicheck || true

# EOF'''
      }
    }
  }
}
