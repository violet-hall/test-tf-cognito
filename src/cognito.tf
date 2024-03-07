terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.39.1"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

resource "aws_cognito_user_pool" "pool" {
  name = "test-pool"
}

resource "aws_cognito_resource_server" "service_scopes" {
  user_pool_id = aws_cognito_user_pool.pool.id
  identifier   = "test-cognito"
  name         = "test-cognito"

  scope {
    scope_name        = "SAMPLE-SCOPE"
    scope_description = "Scope 1"
  }
  #   scope {
  #     scope_name        = "MISSING-SCOPE"
  #     scope_description = "Scope 2"
  #   }
}

output "scopes" {
  value = aws_cognito_resource_server.service_scopes.scope_identifiers
}
