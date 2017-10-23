#!/bin/bash

# Configurable parameters - override them from commandline

[ "${COCCI_DIR}" = "" ] && COCCI_DIR=~/linux-mainline/scripts/coccinelle
[ "${SRC_DIR}" = "" ] && SRC_DIR=~/linux-mainline

# ---------------------------------------------------------

set -e
# set -x

cd ${COCCI_DIR}
COCCI_SHA=$(git rev-parse --verify HEAD)
cd ${SRC_DIR}
SRC_SHA=$(git rev-parse --verify HEAD)
LOGFILE=coccicheck-${SRC_SHA}.log

function body {
  echo "INFO: $(date): Script start"
  echo "INFO: Saving logfile to ${LOGFILE}"
  echo "INFO: hostname=$(hostname)"
  echo "INFO: spatch_version=$(spatch --version | grep spatch)"
  echo "INFO: COCCI_DIR=${COCCI_DIR}"
  echo "INFO: COCCI_SHA=${COCCI_SHA}"
  echo "INFO: SRC_DIR=${SRC_DIR}"
  echo "INFO: SRC_SHA=${SRC_SHA}"
  k=0
  find "${COCCI_DIR}" -name "*.cocci" -print | sort | while read smpl; do
    echo "================================================================================================"
    k=$[ k + 1 ]
    echo "INFO: Applying SmPL ${k}: ${smpl}"
    # CMDLINE="make coccicheck COCCI=${smpl} MODE=report V=1"
    CMDLINE="spatch -D report --no-show-diff --very-quiet --cocci-file ${smpl} --dir ."
    echo "INFO: Running ${CMDLINE}"
    ${CMDLINE} || true
    echo "INFO: $(date): Command completed"
  done
  echo "INFO: $(date): Script end"
}

body | tee ${LOGFILE}

# EOF
