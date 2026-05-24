# Exemplo: VPC Basic

Este exemplo demonstra a criação de uma VPC com subnets públicas e privadas em múltiplas AZs, incluindo NAT Gateway.

## Uso

```hcl
inputs = {
  name               = "lab-vpc"
  cidr_block         = "10.0.0.0/16"
  availability_zones = ["us-east-1a", "us-east-1b"]
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets    = ["10.0.10.0/24", "10.0.11.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Environment = "Lab"
    Project     = "Portfolio"
  }
}
```
