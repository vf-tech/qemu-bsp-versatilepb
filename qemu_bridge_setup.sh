#!/bin/sh

start() {
    echo "QEMU NETWORK SETUP STARTING..."
    brctl addbr br0
    tunctl -t tap0 -u `whoami`
    ifconfig tap0 down
    brctl addif br0 tap0
    ifconfig tap0 0.0.0.0 up
    ifconfig br0 10.0.2.50/24 up
    #route add default gw 10.0.2.50
    brctl show br0
    echo "DONE..."
}
stop() {
    echo "QEMU NETWORK DELETING..."
    brctl delif br0 tap0
    ifconfig tap0 down
    tunctl -d tap0
    ifconfig br0 down
    brctl delbr br0
    echo "DONE..."
}
restart() {
	stop
	start
}

case "$1" in
  start)
	start
	;;
  stop)
	stop
	;;
  restart|reload)
	restart
	;;
  *)
	echo "Usage: $0 {start|stop|restart}"
	exit 1
esac

exit $?
