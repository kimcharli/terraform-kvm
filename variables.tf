variable "vms" {
  type = list(object({
    name = string
    vcpu = number
    disk_mb = number
    mem_mb = number
    bridge1 = string
    mac1 = string
    ip1 = string
    subnet1 = string
  }))
  default = [
    {
      name = "centos-1"
      vcpu = 1
      disk_mb = 100000000000
      mem_mb = 1000
      bridge1 = "brc0"
      mac1 = "02:00:0a:04:05:80"
      ip1 = "10.4.5.128"
      subnet1 = "255.255.255.0"
    },
    {
      name = "centos-2"
      vcpu = 1
      disk_mb = 100000000000
      mem_mb = 1000
      bridge1 = "brc0"
      mac1 = "02:00:0a:04:05:81"
      ip1 = "10.4.5.129"
      subnet1 = "255.255.255.0"
    },
    {
      name = "centos-3"
      vcpu = 1
      disk_mb = 100000000000
      mem_mb = 1000
      bridge1 = "brc0"
      mac1 = "02:00:0a:04:05:82"
      ip1 = "10.4.5.130"
      subnet1 = "255.255.255.0"
    }

  ]

}