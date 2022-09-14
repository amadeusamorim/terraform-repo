
resource "aws_eip" "prod-ip1" { vpc = true } # vpc = true need to be added in new versions of AWS Provider
resource "aws_eip" "prod-ip2" { vpc = true }