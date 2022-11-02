resource "aws_s3_bucket" "test_s3" {
  bucket = "test-727250514989"
}

resource "aws_s3_bucket_website_configuration" "aws_s3_bucket_website_configuration" {
  bucket = aws_s3_bucket.test_s3.bucket

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_acl" "web_bucket_acl" {
  bucket = aws_s3_bucket.test_s3.id
  acl    = "public-read"
}

data "aws_iam_policy_document" "allow_access_to_s3" {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions = ["s3:GetObject"]
    resources = [aws_s3_bucket.test_s3.arn,
                  "${aws_s3_bucket.test_s3.arn}/*"]
  }
}

resource "aws_s3_bucket_policy" "allow_access_to_s3_policy" {
  bucket = aws_s3_bucket.test_s3.id
  policy = data.aws_iam_policy_document.allow_access_to_s3.json
}