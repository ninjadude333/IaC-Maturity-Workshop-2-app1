resource "aws_route53_record" "app" {
  zone_id = data.aws_route53_zone.dudelabxxx.id
  name    = "${local.tags.Phase}-${var.App_Name}.dudelabxxx.com"
  type    = "A"
  ttl     = 60
  records = [for ip in data.aws_instances.app.public_ips : ip]
  depends_on = [
    aws_autoscaling_group.app_asg
  ]
}