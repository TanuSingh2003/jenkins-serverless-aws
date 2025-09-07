provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc"
}

module "rds" {
  source = "./modules/rds"
  vpc_id = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets
}

module "ecr" {
  source = "./modules/ecr"
}

module "lambda" {
  source = "./modules/lambda"
  image_uri = var.image_uri
  subnet_ids = module.vpc.private_subnets
  security_group_ids = [module.vpc.lambda_sg_id]
}

module "apigw" {
  source = "./modules/apigw"
  lambda_arn = module.lambda.lambda_arn
}

output "api_url" {
  value = module.apigw.api_url
}

