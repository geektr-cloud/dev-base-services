/system identity
set name=git.endpoint

/ip service
set telnet disabled=yes
set ftp disabled=yes
set www port=8080

/ip firewall filter
add chain=forward action=accept               dst-address=10.0.0.4
add chain=forward action=drop                 src-address=!10.0.0.0/8
add chain=forward action=fasttrack-connection

/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1
add action=dst-nat chain=dstnat dst-port=80  in-interface=ether1 protocol=tcp to-addresses=10.0.0.4 to-ports=80
add action=dst-nat chain=dstnat dst-port=443 in-interface=ether1 protocol=tcp to-addresses=10.0.0.4 to-ports=443
add action=dst-nat chain=dstnat dst-port=22  in-interface=ether1 protocol=tcp to-addresses=10.0.0.4 to-ports=22

/ip service set ssh port=2222
