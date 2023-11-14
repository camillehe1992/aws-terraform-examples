data "archive_file" "this" {
  type        = "zip"
  source_file = var.source_file
  output_path = var.output_path
}
