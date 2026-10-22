output "public_ip" {
  description = "Public IP Address Of The GenKey Server"
  value       = aws_instance.jenkins_server.public_ip
}
