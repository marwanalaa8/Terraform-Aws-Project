output "public_ip" {
  value = module.compute.public_ip
}

output "private_ip" {
  value = module.compute.private_ip
}

output "public_http_url" {
  value = "http://${module.compute.public_ip}"
}
