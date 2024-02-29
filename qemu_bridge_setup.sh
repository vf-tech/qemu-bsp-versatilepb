#!/bin/sh

start() {
    echo "QEMU NETWORK SETUP STARTING..."
    brctl addbr br0
    brctl addbr br1
    tunctl -t tap0 -u `whoami`
    tunctl -t tap1 -u `whoami`
    tunctl -t tap2 -u `whoami`
    ifconfig tap0 down
    ifconfig tap1 down
    ifconfig tap2 down
    brctl addif br0 tap0
    brctl addif br0 tap1
    brctl addif br1 tap2
    ifconfig tap0 0.0.0.0 up
    ifconfig tap1 0.0.0.0 up
    ifconfig tap2 0.0.0.0 up
    ifconfig br0 10.0.2.1/24 up
    ifconfig br1 10.0.3.1/24 up
#    ifconfig br1 10.0.3.1/24 up
    #route add default gw 10.0.2.50
    brctl show br0
    brctl show br1
    echo "DONE..."
}
stop() {
    echo "QEMU NETWORK DELETING..."
    brctl delif br0 tap0
    brctl delif br0 tap1
    brctl delif br1 tap2
    ifconfig tap0 down
    ifconfig tap1 down
    ifconfig tap2 down
    tunctl -d tap0
    tunctl -d tap1
    tunctl -d tap2
    ifconfig br0 down
    ifconfig br1 down
    brctl delbr br0
    brctl delbr br1
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
