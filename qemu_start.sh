#!/bin/sh

./qemu_bridge_setup.sh restart
qemu-system-arm -M versatilepb -kernel buildroot-2018.08/output/images/zImage -dtb buildroot-2018.08/output/images/versatile-pb.dtb -drive file=buildroot-2018.08/output/images/rootfs.ext2,if=scsi -append "root=/dev/sda console=ttyAMA0,115200" -nographic -netdev tap,id=n1,ifname=tap0,script=no,downscript=no -device e1000,netdev=n1

exit $?
