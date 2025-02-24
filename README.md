# Esse repositório foi feito apenas com o intuito de facilitar o manejo de arquivos na entrega da atividade da matéria de Administração de Banco de Dados

## A conexão com o banco e todos os comandos foram feitos utilizando o MySQL Workbench.

## O intuito da atividade é realizar restauração, criação de chaves, consultas, análise de performance e backup do banco fornecido pelo professor.

### Estrutura do banco
(foto)

### 1. Restaurar o banco de dados:
O banco de dados foi restaurado usando o MySQL Workbench utilizando os comandos abaixo e rodando o arquivo fornecido.
Usei os comandos:
CREATE DATABASE olist;
USE olist;
E rodei o script fornecido.

### 2. Criar um usuário para o pessoal de Business Intelligence:
Utilizei os comandos: 
CREATE USER -> para criar o usuario
GRANT SELECT ON -> para dar permissão de consulta
REVOKE INSERT, UPDATE, DELETE -> para remover as permissões
REVOKE CREATE, ALTER, DROP -> para remover as permissões
FLUSH PRIVILEGES -> para atualizar as permissões

### 3. Chaves e Restrições:

#### Remoção de duplicatas: 
As tabelas estavam com várias duplicatas, então foi necessário removê-las antes de criar as PK e FK, para cada tabela (customer, geo_location, seller, product, olist.order, order_item, order_review), adicionei uma coluna temporária id do tipo SERIAL para identificar as linhas duplicadas. Em seguida, utilizei consultas com a função ROW_NUMBER() para identificar e remover as duplicatas, mantendo apenas uma ocorrência de cada registro único.

#### Atualização de dados: 
Fiz atualizações nas colunas de cidade e estado para garantir a consistência dos dados, convertendo as cidades para minúsculas e os estados para maiúsculas.

#### Criação das chaves primárias: 
Após a remoção das duplicatas, criei as chaves primárias para cada tabela:
- customer: pk_customer na coluna customer_id.
- geo_location: pk_geo_location nas colunas geolocation_zip_code_prefix, geolocation_city, e geolocation_state.
- seller: pk_seller na coluna seller_id.
- product: pk_product na coluna product_id.
- olist.order: pk_order na coluna order_id.
- order_item: pk_order_item nas colunas order_id e product_id.
- order_review: pk_order_review nas colunas review_id e order_id.

#### Criação das chaves estrangeiras: 
Adicionei chaves estrangeiras para garantir a integridade referencial entre as tabelas:
- customer: fk_customer_geo_location referenciando geo_location nas colunas customer_zip_code_prefix, customer_city, e customer_state.
- seller: fk_seller_geo_location referenciando geo_location nas colunas seller_zip_code_prefix, seller_city, e seller_state.
- order_item: fk_order_item_seller referenciando seller na coluna seller_id.
- olist.order: fk_order_customer referenciando customer na coluna customer_id.
- order_item: fk_order_item_order referenciando olist.order na coluna order_id.
- order_item: fk_order_item_product referenciando product na coluna product_id.
- order_payment: fk_order_payment_order referenciando olist.order na coluna order_id.
- order_review: fk_order_review_order referenciando olist.order na coluna order_id.

#### Inserção de dados faltantes: 
Criei views (vw_customer_without_geo_location e vw_seller_without_geo_location) para identificar registros de customer e seller que não possuíam correspondência em geo_location. Esses registros foram inseridos na tabela geo_location para garantir a integridade referencial.
#### Remoção de colunas temporárias: 
Após a remoção das duplicatas e a criação das chaves, as colunas temporárias `id` foram removidas das tabelas.

### Consultas:
#### [Consulta 4.1](03_queries.sql)
#### [Consulta 4.2](03_queries.sql)

### Otimização das consultas

#### Uso de indexes
#### Reescrita das consultas
#### Resultados

### Auditoria do BD

### Backup




