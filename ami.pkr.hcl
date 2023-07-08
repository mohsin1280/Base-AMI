# If you have your default VPC available, you can specify it here.

# Required plugins for Amazon EC2
packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

# Define the source AMI, instance type, region, and other configuration options
source "amazon-ebs" "amazon-linux" {
  ami_name        = "ami-version-1.0.1-{{timestamp}}"
  instance_type   = "t2.micro"
  region          = "ap-southeast-2"
  ssh_username    = "ec2-user"
  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-2.0.????????.?-x86_64-gp2"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
}

# Define the build process and provisioners
build {
  name    = "hq-packer"
  sources = ["source.amazon-ebs.amazon-linux"]

  provisioner "file" {
    source      = "provisioner.sh"
    destination = "/tmp/provisioner.sh"
  }

  provisioner "shell" {
    inline = [
      "chmod +x /tmp/provisioner.sh",
      "/tmp/provisioner.sh"
    ]
  }
}

