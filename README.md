BareMetalPi
------------
Authors:
Hunter Scott
Alex Chadwick

This is an operating system written for the Raspberry Pi in ARM6 assembly. I wrote this code as part of an online class with the University of Cambridge, so the makefile and USB driver was written by Alex Chadwick.

To compile:
run "make" from the root directory

To run:
Get a Raspberry PI SD card which has an operating system installed already. If you browse the files in the SD card, you should see one called kernel.img. Rename this file to something else, such as kernel_linux.img. Then, copy the file kernel.img that 'make' generated onto the SD Card. To switch back, simply delete your kernel.img file, and rename the other one back to kernel.img.