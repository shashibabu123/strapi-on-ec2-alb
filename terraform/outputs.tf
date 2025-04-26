output "alb_dns" {
  description = "Public URL to access Strapi"
  value       = aws_lb.strapi_alb.dns_name
}

