resource "null_resource" "echo-message" {
  provisioner "local-exec" {
    command = "echo $var.message"
  }
}
