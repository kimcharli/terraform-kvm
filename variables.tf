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
    user_data_template = string
  }))
  default = [
    {
      name = "centos-1"
      vcpu = 1
      disk_mb = 100000000000
      mem_mb = 1000
      bridge1 = "brc0"
      mac1 = "02:00:0a:04:05:8d"
      ip1 = "10.4.5.141"
      subnet1 = "255.255.255.0"
      user_data_template = "cloud_init_resize.cfg"
    },
    {
      name = "centos-2"
      vcpu = 1
      disk_mb = 100000000000
      mem_mb = 1000
      bridge1 = "brc0"
      mac1 = "02:00:0a:04:05:8e"
      ip1 = "10.4.5.142"
      subnet1 = "255.255.255.0"
      user_data_template = "cloud_init_resize.cfg"
    },
    {
      name = "centos-3"
      vcpu = 1
      disk_mb = 100000000000
      mem_mb = 1000
      bridge1 = "brc0"
      mac1 = "02:00:0a:04:05:8f"
      ip1 = "10.4.5.143"
      subnet1 = "255.255.255.0"
      user_data_template = "cloud_init_resize.cfg"
    }

  ]

}