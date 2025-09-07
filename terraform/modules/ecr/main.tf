resource "aws_ecr_repository" "this" {
  name = "notes-api"
  image_scanning_configuration { scan_on_push = true }
}

output "repository_url" {
  value = aws_ecr_repository.this.repository_url
}

