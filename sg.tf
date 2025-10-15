# Security Group for ECS tasks
resource "aws_security_group" "ecs_sg" {
  name        = var.ecs_sg_name
  description = "Allow inbound HTTP traffic to ECS containers"
}
  resource "aws_vpc_security_group_ingress_rule" "ecs_sg_01" {
    security_group_id = aws_security_group.ecs_sg.id
    from_port   = 80
    to_port     = 80
    ip_protocol = "tcp"
    cidr_ipv4   =   var.ecs_ingress_cidr
  }

  resource "aws_vpc_security_group_ingress_rule" "ecs_sg_02"  {
        security_group_id = aws_security_group.ecs_sg.id
      from_port   = 0
    to_port     = 65535
    ip_protocol  = "tcp"
    cidr_ipv4 =   var.ecs_internal_cidr # Update with your VPC CIDR
  }

  resource "aws_vpc_security_group_egress_rule" "ecg_sg_03" {
    security_group_id = aws_security_group.ecs_sg.id
    from_port   = 0
    to_port     = 0
    ip_protocol = "-1"
    cidr_ipv4  = "0.0.0.0/0"
  }


# Security Group for Load Balancer
resource "aws_security_group" "lb_sg" {
  name        = var.lb_sg_name
  description = "Allow inbound HTTP traffic to load balancer"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.ecs_ingress_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
