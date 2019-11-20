variable "myvm" {
    type = object({
    name = string
    vcpu = number
    disk_mb = number
    mem_mb = number
    bridge1 = string
    mac1 = string
    ip1 = string
    subnet1 = string
  })
}

variable "base_image_id" {}


