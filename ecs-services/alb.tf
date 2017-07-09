resource "aws_alb" "side_effect" {
  name = "side-effect"
  internal = false
  security_groups = [
    "${data.terraform_remote_state.vpc.side_effect_default_sg}",
    "${data.terraform_remote_state.vpc.side_effect_ephemeral_ports_sg}",
  ]
  subnets = [
    "${data.terraform_remote_state.vpc.side_effect_public_subnets}"
  ]

  enable_deletion_protection = true

  access_logs {
    bucket = "${data.terraform_remote_state.global.s3_bucket_logs_bucket}"
    prefix = "alb"
  }

  tags {
    Environment = "production"
  }
}

resource "aws_alb_listener" "side_effect" {
  load_balancer_arn = "${aws_alb.side_effect.arn}"
  port = "80"
  protocol = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.popular_convention.arn}"
    type             = "forward"
  }
}

resource "aws_alb_listener_rule" "popular_convention" {
  listener_arn = "${aws_alb_listener.side_effect.arn}"
  priority = 100

  action {
    type = "forward"
    target_group_arn = "${aws_alb_target_group.popular_convention.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/popularconvention/*"]
  }
}
