locals {
  zone_name   = "dojo.padok.school"
  handle      = "cfpadok"
  applications = {
    frontend = {
        port = 80
        env = {
            "BACKEND_URL" = "http://${local.handle}-backend.${local.zone_name}"
        }
    }
    backend = {
        port = 3000
        env = {
            APPLICATION_USER = cfpadok
        }
    }
  }
  vpc_id = "vpc-06fb0e04e33af79f2"
  arn_listener = "arn:aws:elasticloadbalancing:eu-west-3:450568479740:listener/app/padok-dojo-lb/4f6ff08666222c65/c80aa0027d4819e0"
}