@echo off
set QTYPE=-accel whpx
set QMEM=-m 2048
set QCPU=-smp 2
set QDISPLAY=-vga virtio -display gtk
set QDISK=-drive unit=0,if=virtio,format=vdi,file=V:\debian.qcow2
rem set QCDROM=-cdrom C:\software\debian\install.iso
set QMOUSE=-usb -device usb-tablet
set QNET=-netdev user,id=n1,hostfwd=tcp::2022-:22 -device virtio-net-pci,netdev=n1
rem -net tap,ifname="Wireless Network Connection"
set QAUDIO=-device ac97
set QOTHER=-boot menu=on -rtc base=localtime,clock=host -parallel none -serial none
set QOPTIONS=%QTYPE% %QMEM% %QCPU% %QDISPLAY% %QDISK% %QCDROM% %QMOUSE% %QNET% %QAUDIO% %QOTHER%

qemu-system-x86_64.exe %QOPTIONS%

