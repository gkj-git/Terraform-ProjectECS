# AWS region
variable "aws_region" {
  default     = "ca-central-1"
}

# ECS cluster
variable "ecs_cluster_name" {
  default     = "white-hart"
}

# ECS task definition
variable "ecs_task_family" {
  default     = "nginx-task"
}

variable "ecs_task_cpu" {
  
  default     = "256"
}

variable "ecs_task_memory" {
  default     = "512"
}

variable "ecs_container_name" {

  default     = "nginx"
}

variable "ecs_container_image" {
  
  default     = "public.ecr.aws/nginx/nginx:1.28-alpine3.21-slim"
}

variable "ecs_desired_count" {

  default     = 1
}

# Security Groups
variable "ecs_sg_name" {
  
  default     = "ecs-sg"
}

variable "lb_sg_name" {

  default     = "nginx-lb-sg"
}

# CIDR blocks
variable "ecs_ingress_cidr" {
 
  default     = "0.0.0.0/0"
}

variable "ecs_internal_cidr" {

  default     = "10.0.0.0/16"
}

# Load Balancer
variable "lb_name" {
  
  default     = "nginx-lb"
}

variable "lb_target_group_name" {

  default     = "nginx-tg"
}


