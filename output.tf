output "app-ip" {
  value = [aws_instance.app-instance.*.public_ip]
}

output "app-ip" {
  value = [aws_instance.app-instance.*.public_dns]
}
// output "s3-bucket" {
//   value = aws_s3_bucket.terraform-state.bucket
// }
