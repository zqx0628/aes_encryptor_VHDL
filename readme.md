# AES_encryptor
* Aes-128/192/256 encrption hardware implementation using VHDL
* Simulation based on Vivado 2019
* Helper scripts are written by Python 3

## testbench/input.txt
* Plain text and keys, can be either 128 bits, 192 bits or 256 bits. 

## Simulation
set digit width
``` 
$ python init.py
```
launch simulation with Vivado TCL mode
```
$ vivado -mode tcl -source sim.tcl
```
test output
```
$ python test.py
```
