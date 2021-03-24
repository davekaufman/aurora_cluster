terraform {
  backend "s3" {
    bucket  = "davekaufman"
    key     = "terraform/cluster.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
