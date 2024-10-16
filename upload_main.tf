# S3 버킷에 main.html 파일 업로드
resource "aws_s3_object" "main_html" {
  bucket        = aws_s3_bucket.bucket1.id
  key           = "main.html"
  source        = "main.html"
  content_type  = "text/html"
}
