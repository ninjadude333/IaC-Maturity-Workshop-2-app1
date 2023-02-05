resource "aws_autoscaling_group" "app_asg" {
  name                 = "${var.Phase}-${var.app_name}_asg"
  min_size             = 2
  max_size             = 4
  desired_capacity     = 2
  launch_configuration = aws_launch_configuration.app_launch_config.name
  vpc_zone_identifier  = var.vpc_public_subnet_ids
  tag {
	key                 = "Name"
	propagate_at_launch = true
	value               = "${var.Phase}-${var.app_name}_asg"
  }
  tag {
	key                 = "terraform"
	propagate_at_launch = true
	value               = "true"
  }
  lifecycle {
	ignore_changes = [
	  tags
	]
  }
}

resource "aws_launch_configuration" "app_launch_config" {
  name_prefix          = "${var.Phase}-${var.app_name}-"
  image_id             = data.aws_ami.amazonLnx.id
  instance_type        = "t2.micro"
  key_name             = aws_key_pair.generated_key.key_name
  security_groups      = [aws_security_group.app-sg.id]
  iam_instance_profile = aws_iam_instance_profile.app_s3_access.name

  root_block_device {
    delete_on_termination = true
    volume_size           = 8
    volume_type           = "gp2"
  }

  ebs_block_device {
    device_name           = "/dev/sdh"
    volume_size           = 8
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }

  lifecycle {
    create_before_destroy = true
  }

  user_data = <<-EOF
#! /bin/bash
yum update -y
yum install -y amazon-linux-extras
yum install -y awscli

mkdir /tmp

# Create script to sync nginx logs to S3 bucket
cat <<EOT > /tmp/sync_logs_to_s3.sh
#!/bin/bash
aws s3 sync /var/log/httpd s3://${aws_s3_bucket.app-logs.id}
EOT

# Make script executable
chmod +x /tmp/sync_logs_to_s3.sh

# Add script to crontab to run every hour
echo "0 * * * * /tmp/sync_logs_to_s3.sh" | crontab -
yum install -y jq
yum install -y httpd
service httpd start
service httpd enable
echo "<h1>Hello World from ${var.Phase} - App: ${var.app_name} in subnet: $(hostname -f)</h1>" > /var/www/html/index.html
EOF
}