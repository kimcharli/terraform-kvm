variable "vms" {
  type = list(object({
    name = string
    vcpu = number
    disk_mb = number
    mem_mb = number
    bridge1 = string
    mac1 = string
  }))
  default = [
    {
      name = "centos-1"
      vcpu = 1
      disk_mb = 100000000000
      mem_mb = 1000
      bridge1 = "brc0"
      mac1 = "02:00:0a:04:05:80"
    },
    {
      name = "centos-2"
      vcpu = 1
      disk_mb = 100000000000
      mem_mb = 1000
      bridge1 = "brc0"
      mac1 = "02:00:0a:04:05:81"
    }

  ]

}