resource "aws_route53_record" "app" {
  zone_id = data.aws_route53_zone.dudelabz.id
  name    = "${local.tags.Phase}-${var.app_name}.dudelabz.com"
  type    = "A"
  ttl     = 60
  records = [for ip in data.aws_instances.app.public_ips : ip]
  depends_on = [
    aws_autoscaling_group.app_asg
  ]
}