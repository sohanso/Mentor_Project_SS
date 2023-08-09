data "aws_ami" "ami_with_ansi_dock" {
  most_recent      = true
  owners           = [var.owner_id_ami]
  filter {
    name   = "name"
    values = ["ubuntu-ansi-docker-*"]
}
}