# Some sanity checking to make sure we are in the right account - very important if you use multiple accounts

data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "caller_arn" {
  value = data.aws_caller_identity.current.arn
}

output "caller_user" {
  value = data.aws_caller_identity.current.user_id
}
output "cyber_desktop" {
  description = "Public Ip address"
  value = aws_eip.jupyter-public-ip.public_ip
}

