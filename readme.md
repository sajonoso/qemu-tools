# Description

This repository contains a bunch of scripts to help use qemu

The scripts contained here are:

* generate_exe_launcher.cmd

  A script to create an executable file which will launch a batch file with the same name.
  Wrapping the batch file around the generated executable will prevent the momentary console window from showing.
  The generated executable will be called `rename_me.exe`.  You should rename this file to match your script

* launchpc.cmd

  A batch file that will launch a QEMU virtual machine
