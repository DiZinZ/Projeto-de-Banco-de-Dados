# 💈 Sistema de Gerenciamento para Barbearia

Sistema de gerenciamento de barbearia desenvolvido para controle de:

- Clientes
- Funcionários (Barbeiros e Atendentes)
- Serviços e Produtos
- Agendamentos e Atendimentos
- Pagamentos

O projeto foi modelado utilizando conceitos de Banco de Dados Relacional com DER (Diagrama Entidade-Relacionamento) e implementado inicialmente em Excel como protótipo funcional.

---

# 📌 Objetivo

O sistema tem como objetivo facilitar o gerenciamento de uma barbearia, permitindo:

- Cadastro de clientes
- Cadastro de funcionários (barbeiros e atendentes)
- Controle de serviços e produtos
- Agendamento e controle de atendimentos
- Controle de pagamentos
- Organização financeira

---

# ✅ Requisitos Funcionais

| Código | Descrição |
|--------|-----------|
| RF01 | O sistema deve permitir cadastrar um cliente com nome, telefone, CPF e email. |
| RF02 | O sistema deve permitir editar e excluir o cadastro de um cliente. |
| RF03 | O sistema deve permitir cadastrar um barbeiro com nome, telefone, CPF, especialidade, salário e status. |
| RF04 | O sistema deve permitir cadastrar um atendente com nome, telefone, CPF, salário e status. |
| RF05 | O sistema deve permitir editar e excluir o cadastro de funcionários. |
| RF06 | O sistema deve permitir cadastrar serviços com nome e preço. |
| RF07 | O sistema deve permitir cadastrar produtos com nome e preço. |
| RF08 | O sistema deve permitir registrar um agendamento vinculando um cliente e um barbeiro, com data e hora. |
| RF09 | O sistema deve registrar atendimentos vinculados a agendamentos, contendo serviços e produtos. |
| RF10 | O sistema deve suportar múltiplos serviços e produtos em um mesmo atendimento (relação N:N). |
| RF11 | O sistema deve gerar automaticamente um pagamento ao concluir um atendimento. |
| RF12 | O sistema deve registrar a forma de pagamento, o valor e a data do pagamento. |
| RF13 | O sistema deve permitir atualizar o status do pagamento para: pendente, pago ou estornado. |
| RF14 | O sistema deve garantir que cada atendimento possua no máximo um pagamento associado (1:1). |

---

# 🗂 Estrutura do Projeto

O banco de dados foi dividido nas seguintes entidades:

## 👤 Cliente

Armazena informações dos clientes da barbearia.

### Atributos

| Campo | Tipo |
|---|---|
| id_cliente (PK) | Inteiro |
| nome | Texto |
| telefone | Texto |
| cpf | Texto |
| email | Texto |

---

## 👔 Funcionário *(Superclasse)*

Entidade genérica que representa todos os funcionários da barbearia. Especializada em **Barbeiro** e **Atendente**.

---

## ✂️ Barbeiro *(especialização de Funcionário)*

Armazena informações dos barbeiros.

### Atributos

| Campo | Tipo |
|---|---|
| id_barbeiro (PK) | Inteiro |
| nome | Texto |
| telefone | Texto |
| cpf | Texto |
| especialidade | Texto |
| status | Texto |
| salario | Decimal |

---

## 🧾 Atendente *(especialização de Funcionário)*

Armazena informações dos atendentes.

### Atributos

| Campo | Tipo |
|---|---|
| id_atendente (PK) | Inteiro |
| nome | Texto |
| telefone | Texto |
| cpf | Texto |
| status | Texto |
| salario | Decimal |

---

## 💇 Serviço

Armazena os serviços oferecidos pela barbearia.

### Atributos

| Campo | Tipo |
|---|---|
| id_servico (PK) | Inteiro |
| nome_servico | Texto |
| preco | Decimal |

---

## 📦 Produto

Armazena os produtos comercializados pela barbearia.

### Atributos

| Campo | Tipo |
|---|---|
| id_produto (PK) | Inteiro |
| nome_produto | Texto |
| preco | Decimal |

---

## 📅 Agendamento

Responsável pelo controle dos agendamentos dos clientes com os barbeiros.

### Atributos

| Campo | Tipo |
|---|---|
| id_agendamento (PK) | Inteiro |
| id_cliente (FK) | Inteiro |
| id_barbeiro (FK) | Inteiro |
| data_agendamento | Data |
| hora_agendamento | Hora |

### Relacionamentos

- Cliente **realiza** Agendamento (M:N → via entidade Agenda)
- Agendamento **gera** Atendimento

---

## 🪑 Atendimento

Representa a execução do serviço agendado. Vincula os serviços e produtos consumidos.

### Relacionamentos

- Atendimento **contém** Serviços (N:N)
- Atendimento **contém** Produtos (N:N)
- Atendimento é **atendido por** Funcionário (1:1)
- Atendimento **gera** Pagamento (1:1)

---

## 💳 Pagamento

Controla os pagamentos realizados por atendimento.

### Atributos

| Campo | Tipo |
|---|---|
| id_pagamento (PK) | Inteiro |
| id_atendimento (FK) | Inteiro |
| forma_pagamento | Texto |
| valor | Decimal |
| data_pagamento | Data |
| status_pagamento | Texto |

---

# 🔗 Relacionamentos do Sistema

| Relacionamento | Cardinalidade |
|---|---|
| Cliente → Agendamento | M:N (via Agenda) |
| Agendamento → Atendimento | 1:N |
| Atendimento → Serviço | N:N (via Contém) |
| Atendimento → Produto | N:N (via Contém) |
| Funcionário → Atendimento | 1:1 (Atendido Por) |
| Funcionário ← Barbeiro | Especialização |
| Funcionário ← Atendente | Especialização |
| Atendimento → Pagamento | 1:1 (Gera) |

---

# 🧩 Modelo Conceitual

O sistema foi modelado utilizando DER (Diagrama Entidade Relacionamento).

## Entidades principais

- Cliente
- Funcionário (Barbeiro / Atendente)
- Serviço
- Produto
- Agendamento
- Atendimento
- Pagamento

---

# 📊 Funcionalidades

✅ Cadastro de clientes  
✅ Cadastro de barbeiros e atendentes  
✅ Cadastro de serviços e produtos  
✅ Controle de agendamentos  
✅ Controle de atendimentos  
✅ Controle de pagamentos  
✅ Controle financeiro básico  
✅ Organização relacional dos dados com herança (Funcionário → Barbeiro / Atendente)  

---

# 🛠 Tecnologias Utilizadas

- Excel
- Modelagem DER
- Banco de Dados Relacional

---

# 📷 DER do Sistema

![DER do Sistema](assets/)

---

## 📖 Legenda do DER

| Símbolo | Significado |
|---|---|
| Elipse (cinza) | Atributo |
| Retângulo (azul) | Entidade |
| Losango (azul) | Relacionamento |

![Legenda](assets/)

---

# 📁 Estrutura das Planilhas

O arquivo Excel contém:

```bash
Clientes
Barbeiros
Atendentes
Servicos
Produtos
Agendamentos
Atendimentos
Pagamentos
```

---

# 📁 Arquivo Excel

[📊 Sistema_Barbearia_Tabelas.xlsx](Sistema_Barbearia_Tabelas.xlsx)
