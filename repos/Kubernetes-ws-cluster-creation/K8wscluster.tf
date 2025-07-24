resource "aws_instance" "K8wscluster" {
  ami           = local.ami_id
  #instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_all_K8wscluster.id]
  instance_type = "t3.medium"
  # need more for terraform
  root_block_device {
    volume_size = 50
    volume_type = "gp3" # or "gp2", depending on your preference
  }
  user_data = file("K8wscluster.sh")
  #iam_instance_profile = "TerraformAdmin"
  tags = {
     Name = "${var.project}-${var.environment}-Kubernetes-instance"
  }
}

resource "aws_security_group" "allow_all_K8wscluster" {
    name        = "allow_all_K8wscluster"
    description = "allow all traffic"

    ingress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }

    lifecycle {
      create_before_destroy = true
    }

    tags = {
        Name = "allow-all-K8wscluster"
    }
}