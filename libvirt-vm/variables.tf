
variable "base_image_id" {}

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
}
