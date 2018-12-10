#!/usr/bin/env ros-bridge

# add new interface to vm
# MAC: 00:15:5D:14:5A:08

# use 10.3.1.2 for the serivces

/ip dhcp-server lease
add address=10.3.1.2 mac-address=00:15:5D:14:5A:08 server=ips_for_service_group

/ip dns static
# for deploy script, using `dig +short dev-server.geektr.cloud`
add address=10.3.1.2 name=dev-server.geektr.cloud
# GitLab
add address=10.3.1.2 name=git.geektr.cloud
# verdaccio
add address=10.3.1.2 name=npm.geektr.cloud
