# Filename : ledramp-syn.sh
# Author   : Nikolaos Kavvadias
# Copyright: (C) 2012, 2013, 2014, 2015, 2016 Nikolaos Kavvadias

#!/bin/bash

# Change XDIR according to your host configuration.
#export XDIR=/cygdrive/c/Xilinx/12.3/ISE_DS/ISE
#export XDIR=/cygdrive/c/XilinxISE/14.6/ISE_DS/ISE
export XDIR=/c/XilinxISE/14.6/ISE_DS/ISE
make -f xst.mk clean
make -f xst.mk PROJECT="ledramp" SOURCES="ledramp.vhd" TOPDIR="./log" TOP="ledramp" \
  ARCH="spartan3" PART="xc3s500e-fg320-4"

# Invoke impact.exe for manual download of the generated bitstream to a 
# hardware platform.
${XDIR}/bin/nt64/impact.exe -batch impact.bat

# Generate statistics.
if [ "$SECONDS" -eq 1 ]
then
  units=second
else
  units=seconds
fi
echo "The XST synthesis script has been running for $SECONDS $units."
exit 0
