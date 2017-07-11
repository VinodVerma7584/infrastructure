terraform {
  required_version = ">= 0.9.4"
  backend "s3" {
    bucket = "kr.sideeffect.terraform.state"
    key = "ecs-services/terraform.tfstate"
    region = "ap-northeast-1"
    encrypt = true
    lock_table = "SideEffectTerraformStateLock"
    acl = "bucket-owner-full-control"
  }
}