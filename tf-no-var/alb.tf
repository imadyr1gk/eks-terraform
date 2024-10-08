# Application Load Balancer
resource "aws_lb" "imad_alb" {
  name               = "imad-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.imad_sg.id]
  subnets            = [aws_subnet.subnet_pub1.id, aws_subnet.subnet_pub3.id]

  enable_cross_zone_load_balancing = true
  idle_timeout                     = 400

  tags = {
    Name = "imad-alb"
  }
}

# Listener ALB
resource "aws_lb_listener" "imad_http_listener" {
  load_balancer_arn = aws_lb.imad_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.imad_tg.arn
  }
}

# Target Group ALB
resource "aws_lb_target_group" "imad_tg" {
  name     = "imad-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.imad_vpc.id

  depends_on = [aws_lb.imad_alb]

  target_type = "instance"
}

# Target Group Attachment
resource "aws_lb_target_group_attachment" "imad_tg_attachment" {
  target_group_arn = aws_lb_target_group.imad_tg.arn
  target_id        = aws_instance.web.id
  port             = 80
}
