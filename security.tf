
# resource "aws_security_group" "bastion88" {
#   name        = "bastion88.sg"
#   description = "Allow admion with ssh"
#   vpc_id      = "vpc-03ed34629d50653ca"

#   ingress {
#     description = "connecting admin with ssh"
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["103.110.170.85/32"]
#   }

#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name      = "stage-bastion-sg"
#     terraform = true
#   }
# }
resource "aws_security_group" "apache" {
  name        = "apache.sg"
  description = "Allow end user "
  vpc_id      = "vpc-03ed34629d50653ca"

  ingress {
    description = "connecting  admin with ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["103.110.170.85/32"]
    # security_groups = [aws_security_group.bastion88.id]
  }
  ingress {
    description = "connecting end user"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    # security_groups = [aws_security_group.loadbalancer.id]
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name      = "stage-apache-sg"
    terraform = true
  }
}
# resource "aws_security_group" "loadbalancer" {
#   name        = "loadbalancer.sg"
#   description = "Allow end user "
#   vpc_id      = "vpc-03ed34629d50653ca"

#   ingress {
#     description = "connecting ssh with end user"
#     from_port   = 80
#     to_port     =80
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"]
#   }
#   egress {
#     from_port        = 0
#     to_port          = 0
#     protocol         = "-1"
#     cidr_blocks      = ["0.0.0.0/0"]
#     ipv6_cidr_blocks = ["::/0"]
#   }

#   tags = {
#     Name      = "stage-loadbalancer-sg"
#     terraform = true
#   }
# }