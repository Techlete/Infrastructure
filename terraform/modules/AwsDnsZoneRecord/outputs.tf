output "name_server" {
  description = "Created Nameservers"
  value = aws_route53_zone.zone.name_servers
}

output "zone_id" {
  description = "Created Zone ID"
  value = aws_route53_zone.zone.id
}
