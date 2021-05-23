# Filename: ghdl.mk
# Author: Nikolaos Kavvadias (C) 2016-2021

GHDL=ghdl
GHDLFLAGS=--ieee=standard --std=08 --workdir=work
GHDLRUNFLAGS=--stop-time=1000000ns

all : run

elab : force
	$(GHDL) -c $(GHDLFLAGS) -e ledramp_tb

run : force
	$(GHDL) --elab-run $(GHDLFLAGS) ledramp_tb $(GHDLRUNFLAGS)

init : force
	mkdir work
	$(GHDL) -a $(GHDLFLAGS) ledramp.vhd
	$(GHDL) -a $(GHDLFLAGS) ledramp_tb.vhd
force : 

clean :
	rm -rf *.o *.ghdl work *_results.txt
