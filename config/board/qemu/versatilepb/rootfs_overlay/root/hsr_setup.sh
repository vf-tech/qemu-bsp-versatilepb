#!/bin/sh

# Define interface names
INTERFACE_1="eth0"
INTERFACE_2="eth1"
HSR_INTERFACE="hsr0"

# Set IP addresses and gateway
HSR_IP="10.0.2.100"
HSR_NETMASK="255.255.255.0"
HSR_GATEWAY="10.0.2.1"

# Clean up previous HSR interface if it exists
ip link del $HSR_INTERFACE &> /dev/null

# Set up HSR network
echo "Setting up HSR network..."

ifconfig $INTERFACE_1 0.0.0.0 down
ifconfig $INTERFACE_2 0.0.0.0 down

ifconfig $INTERFACE_1 hw ether 70:FF:76:1C:0E:8C  
ifconfig $INTERFACE_2 hw ether 70:FF:76:1C:0E:8C

ifconfig $INTERFACE_1 up
ifconfig $INTERFACE_2 up

ifconfig -a 

sleep 1

# Create HSR interface
ip link add name $HSR_INTERFACE type hsr slave1 $INTERFACE_1 slave2 $INTERFACE_2 supervision 45 version 1

# Set IP address and netmask for HSR interface
ip addr add $HSR_IP/$HSR_NETMASK dev $HSR_INTERFACE

# Bring up HSR interface
ip link set dev $HSR_INTERFACE up

# Set default gateway
ip route add default via $HSR_GATEWAY dev $HSR_INTERFACE

# Display network configuration
echo "HSR network configuration:"
ip addr show $HSR_INTERFACE 
