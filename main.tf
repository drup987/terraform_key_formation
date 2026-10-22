resource "aws_instance" "jenkins_server" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key
    vpc_security_group_ids = [aws_security_group.sg_key.id]

tags = {
    Name = "new_jenkins_server"
}
}

resource "aws_security_group" "sg_key" {
    #ssh
    ingress  {
        description = "port for inbound"
        from_port = var.port_nu[0]
        to_port = var.port_nu[0]
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    #http
    ingress  {
        description = "port for inbound"
        from_port = var.port_nu[1]
        to_port = var.port_nu[1]
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
   
    egress  {
        description = "port for outbound"
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}