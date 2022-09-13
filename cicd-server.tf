resource "aws_instance" "cicd-server1" {
  ami                         = "ami-0b89f7b3f054b957e"
  instance_type               = "c3.xlarge"
  vpc_security_group_ids      = [aws_security_group.apache.id]
#   vpc_id                      = "vpc-03ed34629d50653ca"
  associate_public_ip_address = true
#   subnet_id                   = aws_subnet.vpc.id
  key_name                    = aws_key_pair.deployer.id
  user_data =<<-EOF
#! /bin/bash
yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
sudo yum -y install terraform
yum install git -y
git clone git@github.com:rajkumargit12/mahammad.git

wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum upgrade -y
amazon-linux-extras install java-openjdk11 -y
yum install jenkins -y
systemctl start jenkins
systemctl enable jenkins
systemctl status jenkins
  EOF

  tags = {
    name      = "cicd-server1"
    terraform = "true"
  }
}
resource "aws_instance" "apache-server1" {
  ami                         = "ami-0b89f7b3f054b957e"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.apache.id]
#   vpc_id                      = "vpc-03ed34629d50653ca"
  associate_public_ip_address = true
#   subnet_id                   = aws_subnet.vpc.id
  key_name                    = aws_key_pair.deployer.id
user_data = <<-EOF
  #! /bin/bash
  sudo su -
   yum install httpd -y
   yum update httpd -y
   systemctl start httpd
   sytemctl enable httpd
   systemctl status httpd
    EOF

  tags = {
    name      = "apache-server1"
    terraform = "true"
  }
}



  
