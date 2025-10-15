# ECS Cluster
resource "aws_ecs_cluster" "foo" {
  name = var.ecs_cluster_name
}

# ECS Task Definition
resource "aws_ecs_task_definition" "nginx_task" {
  family                   = var.ecs_task_family
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.ecs_task_cpu
  memory                   = var.ecs_task_memory
  execution_role_arn       = aws_iam_role.test.arn

  container_definitions = jsonencode([
    {
      name      = var.ecs_container_name
      image     = var.ecs_container_image
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
        }
      ]
    }
  ])
}

# ECS Service
resource "aws_ecs_service" "ECS" {
  name            = "ECS"
  cluster         = aws_ecs_cluster.foo.id
  task_definition = aws_ecs_task_definition.nginx_task.arn
  desired_count   = var.ecs_desired_count
  launch_type     = "FARGATE"
  depends_on      = [aws_iam_policy.policy, aws_iam_role.test]

  network_configuration {
    subnets         = data.aws_subnets.default.ids
    security_groups = [aws_security_group.ecs_sg.id]  # from sg.tf
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.nginx_task.arn  # from lb.tf
    container_name   = var.ecs_container_name
    container_port   = 80
  }
}
