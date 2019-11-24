output "zone_id" {
  description = "Created Bucket Name"
  value       = aws_route53_record.record.zone_id
}

output "name" {
  description = "Created Record Name"
  value       = aws_route53_record.record.name
}
