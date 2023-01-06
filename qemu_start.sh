#!/bin/sh

./qemu_bridge_setup.sh restart
#qemu-system-arm -M versatilepb -kernel buildroot--netdev tap,id=n1,ifname=tap0,script=no,downscript=no -device e1000,netdev=n1
qemu-system-arm -M type=versatilepb \
    -m 256M \
    -kernel buildroot/output/images/zImage \
    -dtb buildroot/output/images/versatile-pb.dtb \
    -drive file=buildroot/output/images/rootfs.ext2,if=scsi,format=raw \
    -append "console=ttyAMA0,115200 root=/dev/sda rw rootwait rootfstype=ext4" \
    -netdev tap,id=n1,ifname=tap0,script=no,downscript=no -device rtl8139,netdev=n1
    #-serial stdio 

exit $?
