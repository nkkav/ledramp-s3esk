setMode -bs
setCable -port auto
identify
assignFile -p 1 -file ledramp.bit
program -p 1
exit
