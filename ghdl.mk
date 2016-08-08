# Filename: ghdl.mk
# Author: Nikolaos Kavvadias (C) 2016

GHDL=ghdl
GHDLFLAGS=-fexplicit --ieee=synopsys --workdir=work
GHDLRUNFLAGS=--stop-time=200000ns

all : run

elab : force
	$(GHDL) -c $(GHDLFLAGS) -e ledramp_tb

run : force
	./ledramp.ghdl $(GHDLRUNFLAGS)

init : force
	mkdir work
	$(GHDL) -i $(GHDLFLAGS) ledramp.vhd
	$(GHDL) -i $(GHDLFLAGS) ledramp_tb.vhd
	$(GHDL) -m $(GHDLFLAGS) -o ledramp.ghdl ledramp_tb
force : 

clean :
	rm -rf *.o *.ghdl work
