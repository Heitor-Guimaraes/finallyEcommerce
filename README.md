# 🛒 E-commerce API

API REST de e-commerce desenvolvida em **Java 17** e **Spring Boot**, com autenticação **JWT**, controle de acesso por perfil (`USER` / `ADMIN`), gestão de produtos, pedidos e pagamentos, e upload de imagens.

## Tecnologias

- Java 17
- Spring Boot (Web MVC, Validation)
- Spring Security + JWT (jjwt)
- Spring Data JPA / Hibernate
- MySQL
- Lombok
- Maven

## Funcionalidades

- Cadastro e login de usuários com token JWT (sessão stateless)
- Perfis de acesso `USER` e `ADMIN`, com rotas administrativas protegidas
- CRUD de produtos, com upload de imagem
- Pedidos com itens e controle de status (`AGUARDANDO_PAGAMENTO`, `PAGO`, `ENVIADO`, `ENTREGUE`, `CANCELADO`)
- Registro de pagamentos
- Upload de imagem de perfil do usuário
- Validação de dados de entrada com DTOs

## Arquitetura

Arquitetura em camadas:

```
Controller → Service → Repository → MySQL
```

```
src/main/java/com/senai/ecomerce
├── config/        # Configuração do Spring Security
├── controller/    # Endpoints REST
├── dto/           # Objetos de requisição e resposta
├── entity/        # Entidades JPA
├── enums/         # Roles e status do pedido
├── repositories/  # Interfaces Spring Data JPA
├── security/      # Filtro e provedor de token JWT
└── service/       # Regras de negócio
```

## Endpoints

| Recurso | Método | Rota | Acesso |
|---|---|---|---|
| Auth | `POST` | `/auth/login` | Público |
| Usuário | `POST` | `/usuario/user` | Público (cadastro) |
| Usuário | `GET` | `/usuario/user` · `/usuario/user/{id}` | Autenticado |
| Usuário | `PUT` · `DELETE` | `/usuario/user/{id}` | Autenticado |
| Usuário | `POST` | `/usuario/user/{id}/imagem` | Autenticado |
| Admin | `GET` · `POST` | `/usuario/admin` | `ADMIN` |
| Admin | `PUT` | `/usuario/admin/promote/{id}` | `ADMIN` |
| Produto | `GET` · `POST` | `/produto/user/` | Autenticado |
| Produto | `GET` · `PUT` · `DELETE` | `/produto/user/{id}` | Autenticado |
| Produto | `POST` | `/produto/user/{id}/imagem` | Autenticado |
| Pedido | `GET` · `POST` | `/pedido/user` | Autenticado |
| Pedido | `GET` · `PUT` · `DELETE` | `/pedido/user/{id}` | Autenticado |
| Pagamento | `GET` · `POST` | `/pagamento/user` | Autenticado |
| Pagamento | `GET` · `PUT` · `DELETE` | `/pagamento/user/{id}` | Autenticado |

Rotas autenticadas exigem o header:

```
Authorization: Bearer <token>
```

## Como executar

**Pré-requisitos:** Java 17+, Maven (ou o wrapper `mvnw` incluso) e MySQL.

1. Clone o repositório:

   ```bash
   git clone https://github.com/Heitor-Guimaraes/finallyEcommerce.git
   cd finallyEcommerce
   ```

2. Crie o banco no MySQL:

   ```sql
   CREATE DATABASE ecommerce;
   ```

3. Ajuste as credenciais do banco e a chave JWT em `src/main/resources/application.properties`.

4. Execute:

   ```bash
   ./mvnw spring-boot:run
   ```

A API sobe em `http://localhost:8080`.

## Autor

**Heitor Guimarães Perciliano**, desenvolvedor Back-End Java

[LinkedIn](https://www.linkedin.com/in/heitor-perciliano) · [GitHub](https://github.com/Heitor-Guimaraes)
