# Módulo AWS RDS (Relational Database Service)

Módulo reutilizável para provisionar instâncias RDS de forma segura e escalável, suportando PostgreSQL, MySQL, MariaDB e SQL Server.

## Características

- **Engines Suportadas**: PostgreSQL, MySQL, MariaDB, SQL Server.
- **Autoscaling de Storage**: Suporte nativo ao aumento automático de disco.
- **Segurança**: Criptografia de disco (KMS) habilitada por padrão e suporte a SG externos.
- **Alta Disponibilidade**: Configuração fácil de Multi-AZ.
- **Observabilidade**: Enhanced Monitoring e Performance Insights integrados.
- **Customização**: Parameter Groups dinâmicos via lista de mapas.

## Exemplos de Uso

### PostgreSQL (Produção)
Veja o exemplo em `examples/rds-postgresql/terragrunt.hcl`. Demonstra configuração com Multi-AZ, Performance Insights e Parameter Group customizado.

### MySQL (Desenvolvimento)
Veja o exemplo em `examples/rds-mysql/terragrunt.hcl`. Demonstra uma configuração simplificada para redução de custos.
