terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-east-1"
}
resource "aws_instance" "lopes_instance" {
  ami= "ami-0faac27e2fc42cead"
  instance_type = "t2.micro"

  tags = {
    Name = "lopes_instance"
  }
}
resource "aws_s3_bucket" "lopes-lab5-bucket" {
  bucket = "lopes-lab5-bucket"
  tags = {
    Name = "My bucket"
    Environment = "Dev"
  }
}
resource "aws_s3_bucket_public_access_block" "lopes-lab5-bucket" {
  bucket = aws_s3_bucket.lopes-lab5-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
resource "aws_s3_bucket_website_configuration" "s3_website_config" {
  bucket = aws_s3_bucket.lopes-lab5-bucket.id

  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}
resource "aws_s3_bucket_ownership_controls" "mybucket" {
  bucket = aws_s3_bucket.lopes-lab5-bucket.id
  rule {
  object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket_acl" "s3_acl" {
  depends_on = [aws_s3_bucket_ownership_controls.mybucket]

  bucket = aws_s3_bucket.lopes-lab5-bucket.id
  acl= "public-read"
}
resource "aws_s3_bucket_policy" "mybucket" {
  bucket = aws_s3_bucket.lopes-lab5-bucket.id

  policy = jsonencode({
  Version = "2012-10-17"
  Statement = [
    {
    Sid = "PublicReadGetObject"
    Effect = "Allow"
    Principal = "*"
    Action= "s3:GetObject"
    Resource = [
      aws_s3_bucket.lopes-lab5-bucket.arn,
      "${aws_s3_bucket.lopes-lab5-bucket.arn}/*",
    ]
    },
  ]
  })
  depends_on = [
  aws_s3_bucket_public_access_block.lopes-lab5-bucket
  ]
}
resource "aws_cloudfront_distribution" "mycdn" {
  origin {
    domain_name = aws_s3_bucket.lopes-lab5-bucket.bucket_regional_domain_name
    origin_id = "S3-${aws_s3_bucket.lopes-lab5-bucket.id}"
  }

  enabled = true
  default_root_object = "index.html"

  default_cache_behavior {
    target_origin_id = "S3-${aws_s3_bucket.lopes-lab5-bucket.id}"
    viewer_protocol_policy = "redirect-to-https"
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
    allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods = ["GET", "HEAD"]
    min_ttl = 0
    default_ttl= 3600
    max_ttl= 86400
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
