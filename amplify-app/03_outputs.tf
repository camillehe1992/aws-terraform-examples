output "amplify_app_main_url" {
  value = "https:main.${aws_amplify_app.this.default_domain}"
}
