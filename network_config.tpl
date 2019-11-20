version: 1
config:
- type: physical
  name: eth0
  #mac_address: aa:11:22:33:44:55
  subnets:
  - type: static
    address: ${myip}
    netmask: ${mysubnet}

