data "aws_iam_policy_document" "gr4_lambda_assume_role_policies" {
    statement {
        actions =["sts:AssumeRole"]
        principals {
          type = "Service"
          identifiers = ["lambda.amazonaws.com"]
        }
    }
}

data "aws_iam_policy_document" "gr4_lambda_policies" {
    statement {
        sid = "AllObjectActions"
        effect = "Allow"
        actions = ["s3:GetObject"]
        #change the name of the bucket!!!
        resources = ["arn:aws:s3:::test-727250514989/*"]
    }
    statement {
        effect = "Allow"
        actions = ["rekognition:DetectFaces"]
        resources = ["*"]
    }

    statement {
        sid = "SpecificTable"
        effect = "Allow"
        actions = ["dynamodb:BatchWrite*"]
        resources =["arn:aws:dynamodb:*:*:table/images-meta"]
    }
}

resource "aws_iam_role" "gr4_lambda_role" {
  name   = "gr4-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.gr4_lambda_assume_role_policies.json
}

resource "aws_iam_policy" "gr4_lambda_policy" {
  name = "gr4-lambda-policy"
  policy = data.aws_iam_policy_document.gr4_lambda_policies.json
}

resource "aws_iam_role_policy_attachment" "gr4_lambda_role_policy_attach" {
    role = aws_iam_role.gr4_lambda_role.name
    policy_arn = aws_iam_policy.gr4_lambda_policy.arn
}