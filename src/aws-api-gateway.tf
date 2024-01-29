resource "aws_api_gateway_vpc_link" "this" {
  name        = "eks-ingress"
  description = "EKS Ingress VPC Link"
  target_arns = [data.aws_lb.eks_ingress.arn]
}

resource "aws_api_gateway_rest_api" "this" {
  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "fiap-tech-challenge"
      version = "1.0"
    }
    paths = {
      "/autenticar" = {
        post = {
          x-amazon-apigateway-integration = {
            httpMethod           = "POST"
            payloadFormatVersion = "1.0"
            type                 = "AWS_PROXY"
            uri                  = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/${module.lambda_authenticator.lambda_function_arn}/invocations"
          }
        }
      }
      "/clientes" = {
        post = {
          security = [
            {
              fiap-authorizer = []
            }
          ]
          x-amazon-apigateway-integration = {
            httpMethod           = "POST"
            connectionType       = "VPC_LINK"
            connectionId         = aws_api_gateway_vpc_link.this.id
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "http://${data.aws_lb.eks_ingress.dns_name}/ms-cliente/clientes"
          }
        }
      }
      "/clientes/{param}" = {
        get = {
          security = [
            {
              fiap-authorizer = []
            }
          ]
          x-amazon-apigateway-integration = {
            httpMethod           = "GET"
            connectionType       = "VPC_LINK"
            connectionId         = aws_api_gateway_vpc_link.this.id
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "http://${data.aws_lb.eks_ingress.dns_name}/ms-cliente/clientes/{cpf}"
            requestParameters = {
              "integration.request.path.cpf" : "method.request.path.param"
            }
          }
        }
      }
      "/pagamentos" = {
        post = {
          security = [
            {
              fiap-authorizer = []
            }
          ]
          x-amazon-apigateway-integration = {
            httpMethod           = "POST"
            connectionType       = "VPC_LINK"
            connectionId         = aws_api_gateway_vpc_link.this.id
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "http://${data.aws_lb.eks_ingress.dns_name}/ms-pagamento/pagamentos"
          }
        }
      }
      "/pagamentos/confirmar" = {
        post = {
          security = [
            {
              fiap-authorizer = []
            }
          ]
          x-amazon-apigateway-integration = {
            httpMethod           = "POST"
            connectionType       = "VPC_LINK"
            connectionId         = aws_api_gateway_vpc_link.this.id
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "http://${data.aws_lb.eks_ingress.dns_name}/ms-pagamento/pagamentos/confirmar"
          }
        }
      }
      "/pagamentos/status/{param}" = {
        get = {
          security = [
            {
              fiap-authorizer = []
            }
          ]
          x-amazon-apigateway-integration = {
            httpMethod           = "GET"
            connectionType       = "VPC_LINK"
            connectionId         = aws_api_gateway_vpc_link.this.id
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "http://${data.aws_lb.eks_ingress.dns_name}/ms-pagamento/pagamentos/status/{status}"
            requestParameters = {
              "integration.request.path.status" : "method.request.path.param"
            }
          }
        }
      }
      "/pagamentos/{param}" = {
        get = {
          security = [
            {
              fiap-authorizer = []
            }
          ]
          x-amazon-apigateway-integration = {
            httpMethod           = "GET"
            connectionType       = "VPC_LINK"
            connectionId         = aws_api_gateway_vpc_link.this.id
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "http://${data.aws_lb.eks_ingress.dns_name}/ms-pagamento/pagamentos/{pedidoId}"
            requestParameters = {
              "integration.request.path.pedidoId" : "method.request.path.param"
            }
          }
        }
      }
      "/pedidos" = {
        get = {
          security = [
            {
              fiap-authorizer = []
            }
          ]
          x-amazon-apigateway-integration = {
            httpMethod           = "GET"
            connectionType       = "VPC_LINK"
            connectionId         = aws_api_gateway_vpc_link.this.id
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "http://${data.aws_lb.eks_ingress.dns_name}/ms-producao/pedidos"
          }
        }
        post = {
          security = [
            {
              fiap-authorizer = []
            }
          ]
          x-amazon-apigateway-integration = {
            httpMethod           = "POST"
            connectionType       = "VPC_LINK"
            connectionId         = aws_api_gateway_vpc_link.this.id
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "http://${data.aws_lb.eks_ingress.dns_name}/ms-pedido/pedidos"
          }
        }
      }
      "/pedidos/producao" = {
        post = {
          security = [
            {
              fiap-authorizer = []
            }
          ]
          x-amazon-apigateway-integration = {
            httpMethod           = "POST"
            connectionType       = "VPC_LINK"
            connectionId         = aws_api_gateway_vpc_link.this.id
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "http://${data.aws_lb.eks_ingress.dns_name}/ms-producao/pedidos"
          }
        }
      }
      "/pedidos/{param1}/{param2}" = {
        put = {
          security = [
            {
              fiap-authorizer = []
            }
          ]
          x-amazon-apigateway-integration = {
            httpMethod           = "PUT"
            connectionType       = "VPC_LINK"
            connectionId         = aws_api_gateway_vpc_link.this.id
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "http://${data.aws_lb.eks_ingress.dns_name}/ms-producao/pedidos/{pedidoId}/{statusDoPedido}"
            requestParameters = {
              "integration.request.path.pedidoId" : "method.request.path.param1"
              "integration.request.path.statusDoPedido" : "method.request.path.param2"
            }
          }
        }
      }
      "/produtos" = {
        post = {
          security = [
            {
              fiap-authorizer = []
            }
          ]
          x-amazon-apigateway-integration = {
            httpMethod           = "POST"
            connectionType       = "VPC_LINK"
            connectionId         = aws_api_gateway_vpc_link.this.id
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "http://${data.aws_lb.eks_ingress.dns_name}/ms-pedido/produtos"
          }
        }
      }
      "/produtos/{param}" = {
        get = {
          security = [
            {
              fiap-authorizer = []
            }
          ]
          x-amazon-apigateway-integration = {
            httpMethod           = "GET"
            connectionType       = "VPC_LINK"
            connectionId         = aws_api_gateway_vpc_link.this.id
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "http://${data.aws_lb.eks_ingress.dns_name}/ms-pedido/produtos/{categoria}",
            requestParameters = {
              "integration.request.path.categoria" : "method.request.path.param"
            }
          }
        }
        put = {
          security = [
            {
              fiap-authorizer = []
            }
          ]
          x-amazon-apigateway-integration = {
            httpMethod           = "PUT"
            connectionType       = "VPC_LINK"
            connectionId         = aws_api_gateway_vpc_link.this.id
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "http://${data.aws_lb.eks_ingress.dns_name}/ms-pedido/produtos/{id}"
            requestParameters = {
              "integration.request.path.id" : "method.request.path.param"
            }
          }
        }
        delete = {
          security = [
            {
              fiap-authorizer = []
            }
          ]
          x-amazon-apigateway-integration = {
            httpMethod           = "DELETE"
            connectionType       = "VPC_LINK"
            connectionId         = aws_api_gateway_vpc_link.this.id
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "http://${data.aws_lb.eks_ingress.dns_name}/ms-pedido/produtos/{id}"
            requestParameters = {
              "integration.request.path.id" : "method.request.path.param"
            }
          }
        }
      }
    }
    components = {
      securitySchemes = {
        fiap-authorizer = {
          type                         = "apiKey"
          name                         = "Authorization"
          in                           = "header"
          x-amazon-apigateway-authtype = "custom"
          x-amazon-apigateway-authorizer = {
            type                         = "token"
            authorizerUri                = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/${module.lambda_authorizer.lambda_function_arn}/invocations"
            authorizerResultTtlInSeconds = 0
          }
        }
      }

    }
  })

  name        = "fiap-rest-api"
  description = "FIAP REST API for FIAP EKS Cluster"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  triggers = {
    redeployment = sha1(aws_api_gateway_rest_api.this.body)
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "latest" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = "latest"

  # Docs = https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-logging.html
  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api_gateway.arn
    format          = "{ \"requestId\": \"$context.requestId\", \"extendedRequestId\": \"$context.extendedRequestId\", \"ip\": \"$context.identity.sourceIp\", \"caller\": \"$context.identity.caller\", \"user\": \"$context.identity.user\", \"requestTime\": \"$context.requestTime\", \"httpMethod\": \"$context.httpMethod\", \"resourcePath\": \"$context.resourcePath\", \"status\": \"$context.status\", \"protocol\": \"$context.protocol\", \"responseLength\": \"$context.responseLength\" }"
  }
}
