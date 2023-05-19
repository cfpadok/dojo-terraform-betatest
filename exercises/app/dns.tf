data "aws_route53_zone" "www" {
  name     = local.zone_name
}

data "aws_lb" "mylb" {
  name     = "padok-dojo-lb"
}

resource "aws_route53_record" "newRecords" {
  for_each = local.applications
  zone_id  = data.aws_route53_zone.www.zone_id
  name     = "${local.handle}-${each.key}.${local.zone_name}"
  type     = "CNAME"
  ttl      = "300"
  records  = [data.aws_lb.mylb.dns_name]
}