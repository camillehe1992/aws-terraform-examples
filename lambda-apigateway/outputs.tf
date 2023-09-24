# Output value definitions
output "base_url" {
  description = "Base URL for API Gateway stage."
  value       = aws_api_gateway_stage.this.invoke_url
}

output "hello_invoke_url" {
  description = "The invoke url for Hello world"
  value       = "${aws_api_gateway_stage.this.invoke_url}/hello"
}
