terraform {
  backend "s3" {
    bucket = "ta-terraform-tfstates-727250514989"
    key    = "final_challenge/testing/s3/terraform.tfstates"
    dynamodb_table = "terraform-lock"
  }
}