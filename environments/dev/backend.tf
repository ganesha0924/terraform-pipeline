terraform {
  backend "s3" {
    bucket         = "ggaann-terraform-state-1786794486"
    key            = "dev/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
