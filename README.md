# 💈 Sistema de Gerenciamento para Barbearia

Sistema de gerenciamento de barbearia desenvolvido para controle de:

- Clientes
- Barbeiros
- Serviços
- Agendamentos
- Pagamentos

O projeto foi modelado utilizando conceitos de Banco de Dados Relacional e implementado inicialmente em Excel como protótipo funcional.

---

# 📌 Objetivo

O sistema tem como objetivo facilitar o gerenciamento de uma barbearia, permitindo:

- Cadastro de clientes
- Cadastro de barbeiros
- Controle de serviços
- Agendamento de atendimentos
- Controle de pagamentos
- Organização financeira

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
| email | Texto |
| data_nascimento | Data |

---

## ✂️ Barbeiro

Armazena informações dos barbeiros.

### Atributos

| Campo | Tipo |
|---|---|
| id_barbeiro (PK) | Inteiro |
| nome | Texto |
| especialidade | Texto |
| telefone | Texto |

---

## 💇 Serviço

Armazena os serviços oferecidos pela barbearia.

### Atributos

| Campo | Tipo |
|---|---|
| id_servico (PK) | Inteiro |
| nome_servico | Texto |
| preco | Decimal |
| duracao_min | Inteiro |

---

## 📅 Agendamento

Responsável pelo controle dos atendimentos.

### Atributos

| Campo | Tipo |
|---|---|
| id_agendamento (PK) | Inteiro |
| data | Data |
| hora | Hora |
| status | Texto |

### Relacionamentos

- Cliente realiza agendamento
- Barbeiro atende agendamento
- Serviço é oferecido no agendamento

---

## 💳 Pagamento

Controla os pagamentos realizados.

### Atributos

| Campo | Tipo |
|---|---|
| id_pagamento (PK) | Inteiro |
| forma_pagamento | Texto |
| valor | Decimal |
| data | Data |
| status_pagamento | Texto |

### Relacionamento

- Agendamento gera pagamento

---

# 🔗 Relacionamentos do Sistema

| Relacionamento | Cardinalidade |
|---|---|
| Cliente → Agendamento | 1:N |
| Barbeiro → Agendamento | 1:N |
| Serviço → Agendamento | 1:N |
| Agendamento → Pagamento | 1:1 |

---

# 🧩 Modelo Conceitual

O sistema foi modelado utilizando DER (Diagrama Entidade Relacionamento).

## Entidades principais

- Cliente
- Barbeiro
- Serviço
- Agendamento
- Pagamento

---

# 📊 Funcionalidades

✅ Cadastro de clientes  
✅ Cadastro de barbeiros  
✅ Cadastro de serviços  
✅ Controle de agendamentos  
✅ Controle de pagamentos  
✅ Controle financeiro básico  
✅ Organização relacional dos dados  

---

# 🛠 Tecnologias Utilizadas

- Excel
- Modelagem DER
- Banco de Dados Relacional

---

# 🧩 Modelo Conceitual
- O sistema foi modelado utilizando DER (Diagrama Entidade Relacionamento).

# 📷 DER do Sistema

![DER do Sistema](assets/der_barbearia.png)

---

## 📖 Legenda do DER

![Legenda](assets/legenda.png)

---
# 📁 Estrutura das Planilhas

O arquivo Excel contém:

```bash
Clientes
Barbeiros
Servicos
Agendamentos
Pagamentos
 ```
---

# 📁 Arquivo Excel

[📊 Sistema_Barbearia_Tabelas.xlsx](Sistema_Barbearia_Tabelas.xlsx)

