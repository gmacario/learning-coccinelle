#!/bin/bash

set -e
# set -x

SRC_DIR=~/linux-mainline

cd ${SRC_DIR}
SRC_SHA=$(git rev-parse --verify HEAD)
LOGFILE=coccicheck-${SRC_SHA}.log

function body {
  echo "INFO: $(date): Script start"
  echo "INFO: Saving logfile to ${LOGFILE}"
  echo "INFO: hostname=$(hostname)"
  echo "INFO: SRC_DIR=${SRC_DIR}"
  echo "INFO: SRC_SHA=${SRC_SHA}"
  k=0
  find scripts/coccinelle -name "*.cocci" -print | while read smpl; do
    echo "================================================================================================"
    k=$[ k + 1 ]
    echo "INFO: Applying SmPL ${k}: ${smpl}"
    CMDLINE="make coccicheck COCCI=${smpl} MODE=report V=1"
    echo "INFO: Running ${CMDLINE}"
    ${CMDLINE} || true
    echo "INFO: $(date): Command completed"
  done
  echo "INFO: $(date): Script end"
}

body | tee ${LOGFILE}

# EOF
