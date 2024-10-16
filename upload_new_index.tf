# S3 버킷에 새로운 index.html 파일 업로드
resource "aws_s3_object" "index" {
  bucket        = aws_s3_bucket.bucket1.id
  key           = "index.html"
  source        = "index.html"
  content_type  = "text/html"
}
