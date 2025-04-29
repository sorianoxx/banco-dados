# 🗃️ Projeto de Banco de Dados com ETL e Dashboards

Este repositório contém um projeto completo de banco de dados que inclui:

- Estruturação de um esquema estrela em SQL;
- Pipeline de ETL desenvolvido em Python;
- Geração automatizada de dashboards.

## 📁 Estrutura do Repositório

- `star_schema.sql`: Script SQL para criação do esquema estrela do banco de dados.
- `Dump20250407.sql`: Dump do banco de dados contendo dados de exemplo.
- `etl_pipeline.py`: Script Python responsável pela extração, transformação e carga dos dados.
- `generate_dashboards.py`: Script Python para geração de dashboards com base nos dados processados.
- `requirements.txt`: Lista de dependências Python necessárias para executar os scripts.
- `.env`: Arquivo de variáveis de ambiente (não incluído por padrão) contendo configurações sensíveis, como credenciais de acesso ao banco de dados.

## ⚙️ Funcionalidades

- **Modelagem de Dados**: Implementação de um esquema estrela para análise eficiente de dados.
- **ETL Automatizado**: Pipeline que realiza a extração de dados brutos, transformação conforme regras de negócio e carga no banco de dados.
- **Dashboards Interativos**: Geração de dashboards para visualização e análise dos dados processados.

## 🛠️ Tecnologias Utilizadas

- **Banco de Dados**: PostgreSQL (ou outro SGBD compatível com SQL)
- **Linguagem de Programação**: Python
- **Bibliotecas Python**:
  - `pandas`
  - `sqlalchemy`
  - `dotenv`
  - Outras listadas em `requirements.txt`


## 🚀 Como Executar

1. **Clone o repositório**:

   ```bash
   git clone https://github.com/sorianoxx/banco-dados.git
   cd banco-dados
