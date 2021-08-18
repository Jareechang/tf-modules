 output "aws_iam_access_id" {
     value = aws_iam_access_key.ci_key[0].id
 }

 output "aws_iam_access_key" {
     value = aws_iam_access_key.ci_key[0].secret
 }
