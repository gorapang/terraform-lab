# 수정된 index.html 파일 업로드
resource "aws_s3_object" "modified_index" {
  bucket        = aws_s3_bucket.bucket1.id
  key           = "index.html"
  source        = "index.html"
  content_type  = "text/html"
  
  etag = filemd5("index.html")  # 파일 변경 사항 감지
}
