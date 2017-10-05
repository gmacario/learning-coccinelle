#!/bin/bash

# set -x

echo "INFO: $(date): Script start"
echo "INFO: hostname=$(hostname)"

cd ~/linux-mainline
k=0
find scripts/coccinelle -name "*.cocci" -print | while read smpl; do
    echo "================================================================================================"
    k=$[ k + 1 ]
    echo "INFO: Applying SmPL ${k}: ${smpl}"
    echo "INFO: make coccicheck COCCI=${smpl} MODE=report"
    make coccicheck COCCI=${smpl} MODE=report V=1
    echo "INFO: $(date): make coccicheck end"
done
echo "INFO: $(date): Script end"

# EOF
