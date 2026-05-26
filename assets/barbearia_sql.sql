-- ============================================================
--  ETAPA 2 — IMPLEMENTAÇÃO FÍSICA
--  Sistema de Gerenciamento de Barbearia
--  Data: 27/05/2026
-- ============================================================

SET NAMES 'utf8mb4';

-- ============================================================
--  DDL — CRIAÇÃO DO BANCO E TABELAS
-- ============================================================

CREATE DATABASE IF NOT EXISTS barbearia;
USE barbearia;

-- ------------------------------------------------------------
-- CLIENTE
-- ------------------------------------------------------------
CREATE TABLE CLIENTE (
    ID_CLIENTE   INT          NOT NULL AUTO_INCREMENT,
    NOME         VARCHAR(100) NOT NULL,
    TELEFONE     VARCHAR(20),
    CPF          VARCHAR(14)  NOT NULL UNIQUE,
    PRIMARY KEY (ID_CLIENTE)
);

-- ------------------------------------------------------------
-- FUNCIONÁRIO (superclasse)
-- ------------------------------------------------------------
CREATE TABLE FUNCIONARIO (
    ID_FUNCIONARIO INT          NOT NULL AUTO_INCREMENT,
    NOME           VARCHAR(100) NOT NULL,
    CPF            VARCHAR(14)  NOT NULL UNIQUE,
    TELEFONE       VARCHAR(20),
    PRIMARY KEY (ID_FUNCIONARIO)
);

-- ------------------------------------------------------------
-- BARBEIRO (especialização de FUNCIONÁRIO)
-- ------------------------------------------------------------
CREATE TABLE BARBEIRO (
    ID_FUNCIONARIO INT           NOT NULL,
    ESPECIALIDADE  VARCHAR(80),
    SALARIO        DECIMAL(10,2) NOT NULL,
    STATUS         VARCHAR(20)   NOT NULL DEFAULT 'Ativo',
    PRIMARY KEY (ID_FUNCIONARIO),
    CONSTRAINT fk_barbeiro_funcionario
        FOREIGN KEY (ID_FUNCIONARIO) REFERENCES FUNCIONARIO(ID_FUNCIONARIO)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- ------------------------------------------------------------
-- ATENDENTE (especialização de FUNCIONÁRIO)
-- ------------------------------------------------------------
CREATE TABLE ATENDENTE (
    ID_FUNCIONARIO INT           NOT NULL,
    SALARIO        DECIMAL(10,2) NOT NULL,
    STATUS         VARCHAR(20)   NOT NULL DEFAULT 'Ativo',
    SETOR          VARCHAR(50),
    PRIMARY KEY (ID_FUNCIONARIO),
    CONSTRAINT fk_atendente_funcionario
        FOREIGN KEY (ID_FUNCIONARIO) REFERENCES FUNCIONARIO(ID_FUNCIONARIO)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- ------------------------------------------------------------
-- AGENDAMENTO
-- ------------------------------------------------------------
CREATE TABLE AGENDAMENTO (
    ID_AGENDAMENTO   INT  NOT NULL AUTO_INCREMENT,
    DATA_AGENDAMENTO DATE NOT NULL,
    ID_CLIENTE       INT  NOT NULL,
    ID_FUNCIONARIO   INT  NOT NULL,
    PRIMARY KEY (ID_AGENDAMENTO),
    CONSTRAINT fk_agendamento_cliente
        FOREIGN KEY (ID_CLIENTE) REFERENCES CLIENTE(ID_CLIENTE)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_agendamento_funcionario
        FOREIGN KEY (ID_FUNCIONARIO) REFERENCES FUNCIONARIO(ID_FUNCIONARIO)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- ------------------------------------------------------------
-- ATENDIMENTO
-- ------------------------------------------------------------
CREATE TABLE ATENDIMENTO (
    ID_ATENDIMENTO INT         NOT NULL AUTO_INCREMENT,
    DATA           DATE        NOT NULL,
    HORA           TIME        NOT NULL,
    STATUS         VARCHAR(20) NOT NULL DEFAULT 'Agendado',
    ID_AGENDAMENTO INT         NOT NULL,
    ID_FUNCIONARIO INT         NOT NULL,
    PRIMARY KEY (ID_ATENDIMENTO),
    CONSTRAINT fk_atendimento_agendamento
        FOREIGN KEY (ID_AGENDAMENTO) REFERENCES AGENDAMENTO(ID_AGENDAMENTO)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_atendimento_funcionario
        FOREIGN KEY (ID_FUNCIONARIO) REFERENCES FUNCIONARIO(ID_FUNCIONARIO)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- ------------------------------------------------------------
-- SERVIÇO
-- ------------------------------------------------------------
CREATE TABLE SERVICO (
    ID_SERVICO INT           NOT NULL AUTO_INCREMENT,
    NOME       VARCHAR(80)   NOT NULL,
    PRECO      DECIMAL(10,2) NOT NULL,
    DURACAO    INT           NOT NULL COMMENT 'Duração em minutos',
    PRIMARY KEY (ID_SERVICO)
);

-- ------------------------------------------------------------
-- ATENDIMENTO_SERVIÇO (N:N — Possui)
-- ------------------------------------------------------------
CREATE TABLE ATENDIMENTO_SERVICO (
    ID_ATENDIMENTO INT NOT NULL,
    ID_SERVICO     INT NOT NULL,
    PRIMARY KEY (ID_ATENDIMENTO, ID_SERVICO),
    CONSTRAINT fk_atserv_atendimento
        FOREIGN KEY (ID_ATENDIMENTO) REFERENCES ATENDIMENTO(ID_ATENDIMENTO)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_atserv_servico
        FOREIGN KEY (ID_SERVICO) REFERENCES SERVICO(ID_SERVICO)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- ------------------------------------------------------------
-- PRODUTO
-- ------------------------------------------------------------
CREATE TABLE PRODUTO (
    ID_PRODUTO INT           NOT NULL AUTO_INCREMENT,
    NOME       VARCHAR(80)   NOT NULL,
    PRECO      DECIMAL(10,2) NOT NULL,
    QUANTIDADE INT           NOT NULL DEFAULT 0,
    PRIMARY KEY (ID_PRODUTO)
);

-- ------------------------------------------------------------
-- ATENDIMENTO_PRODUTO (N:N — Utiliza)
-- ------------------------------------------------------------
CREATE TABLE ATENDIMENTO_PRODUTO (
    ID_ATENDIMENTO INT NOT NULL,
    ID_PRODUTO     INT NOT NULL,
    QUANTIDADE     INT NOT NULL DEFAULT 1,
    PRIMARY KEY (ID_ATENDIMENTO, ID_PRODUTO),
    CONSTRAINT fk_atprod_atendimento
        FOREIGN KEY (ID_ATENDIMENTO) REFERENCES ATENDIMENTO(ID_ATENDIMENTO)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_atprod_produto
        FOREIGN KEY (ID_PRODUTO) REFERENCES PRODUTO(ID_PRODUTO)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- ------------------------------------------------------------
-- PAGAMENTO
-- ------------------------------------------------------------
CREATE TABLE PAGAMENTO (
    ID_PAGAMENTO    INT           NOT NULL AUTO_INCREMENT,
    VALOR           DECIMAL(10,2) NOT NULL,
    FORMA_PAGAMENTO VARCHAR(30)   NOT NULL,
    STATUS          VARCHAR(20)   NOT NULL DEFAULT 'Pendente',
    ID_ATENDIMENTO  INT           NOT NULL UNIQUE,
    PRIMARY KEY (ID_PAGAMENTO),
    CONSTRAINT fk_pagamento_atendimento
        FOREIGN KEY (ID_ATENDIMENTO) REFERENCES ATENDIMENTO(ID_ATENDIMENTO)
        ON DELETE RESTRICT ON UPDATE CASCADE
);


-- ============================================================
--  DML — INSERÇÃO DE DADOS
-- ============================================================

-- ------------------------------------------------------------
-- CLIENTE (10 registros)
-- ------------------------------------------------------------
INSERT INTO CLIENTE (ID_CLIENTE, NOME, TELEFONE, CPF) VALUES
( 1, 'Ana Silva',      '(62) 91234-5678', '123.456.789-00'),
( 2, 'Bruno Costa',    '(62) 99876-5432', '987.654.321-00'),
( 3, 'Carla Mendes',   '(62) 98765-4321', '456.789.123-00'),
( 4, 'Diego Rocha',    '(62) 97654-3210', '321.654.987-00'),
( 5, 'Elena Farias',   '(62) 96543-2109', '654.321.098-00'),
( 6, 'Felipe Martins', '(62) 95432-1098', '741.852.963-00'),
( 7, 'Gabriela Lopes', '(62) 94321-0987', '852.963.741-00'),
( 8, 'Henrique Dias',  '(62) 93210-9876', '963.741.852-00'),
( 9, 'Isabela Nunes',  '(62) 92109-8765', '159.357.486-00'),
(10, 'João Pereira',   '(62) 91098-7654', '357.159.486-00');

-- ------------------------------------------------------------
-- FUNCIONÁRIO (5 registros)
-- ------------------------------------------------------------
INSERT INTO FUNCIONARIO (ID_FUNCIONARIO, NOME, CPF, TELEFONE) VALUES
(1, 'Pedro Alves',   '111.222.333-44', '(62) 91111-2222'),
(2, 'Mariana Lima',  '222.333.444-55', '(62) 93333-4444'),
(3, 'João Ferreira', '333.444.555-66', '(62) 95555-6666'),
(4, 'Beatriz Souza', '444.555.666-77', '(62) 97777-8888'),
(5, 'Carlos Neves',  '555.666.777-88', '(62) 99999-0000');

-- ------------------------------------------------------------
-- BARBEIRO (4 registros — IDs 1,2,4,5)
-- ------------------------------------------------------------
INSERT INTO BARBEIRO (ID_FUNCIONARIO, ESPECIALIDADE, SALARIO, STATUS) VALUES
(1, 'Corte Masculino', 2500.00, 'Ativo'),
(2, 'Barba e Cabelo',  3000.00, 'Ativo'),
(4, 'Coloração',       2800.00, 'Ativo'),
(5, 'Corte Infantil',  2200.00, 'Inativo');

-- ------------------------------------------------------------
-- ATENDENTE (1 registro — ID 3)
-- ------------------------------------------------------------
INSERT INTO ATENDENTE (ID_FUNCIONARIO, SALARIO, STATUS, SETOR) VALUES
(3, 1800.00, 'Ativo', 'Recepção');

-- ------------------------------------------------------------
-- AGENDAMENTO (10 registros)
-- ------------------------------------------------------------
INSERT INTO AGENDAMENTO (ID_AGENDAMENTO, DATA_AGENDAMENTO, ID_CLIENTE, ID_FUNCIONARIO) VALUES
( 1, '2026-05-20',  1, 1),
( 2, '2026-05-21',  2, 2),
( 3, '2026-05-22',  3, 1),
( 4, '2026-05-23',  4, 4),
( 5, '2026-05-24',  5, 2),
( 6, '2026-05-25',  6, 1),
( 7, '2026-05-26',  7, 2),
( 8, '2026-05-27',  8, 4),
( 9, '2026-05-28',  9, 1),
(10, '2026-05-29', 10, 5);

-- ------------------------------------------------------------
-- ATENDIMENTO (10 registros)
-- ------------------------------------------------------------
INSERT INTO ATENDIMENTO (ID_ATENDIMENTO, DATA, HORA, STATUS, ID_AGENDAMENTO, ID_FUNCIONARIO) VALUES
( 1, '2026-05-20', '10:00:00', 'Concluído',  1, 1),
( 2, '2026-05-21', '14:30:00', 'Concluído',  2, 2),
( 3, '2026-05-22', '09:00:00', 'Concluído',  3, 1),
( 4, '2026-05-23', '11:00:00', 'Concluído',  4, 4),
( 5, '2026-05-24', '16:00:00', 'Concluído',  5, 2),
( 6, '2026-05-25', '08:30:00', 'Agendado',   6, 1),
( 7, '2026-05-26', '13:00:00', 'Agendado',   7, 2),
( 8, '2026-05-27', '15:30:00', 'Agendado',   8, 4),
( 9, '2026-05-28', '10:30:00', 'Agendado',   9, 1),
(10, '2026-05-29', '17:00:00', 'Agendado',  10, 5);

-- ------------------------------------------------------------
-- SERVIÇO (10 registros)
-- ------------------------------------------------------------
INSERT INTO SERVICO (ID_SERVICO, NOME, PRECO, DURACAO) VALUES
( 1, 'Corte de Cabelo',  35.00, 30),
( 2, 'Barba',            25.00, 20),
( 3, 'Corte + Barba',    55.00, 50),
( 4, 'Hidratação',       45.00, 40),
( 5, 'Coloração',        90.00, 80),
( 6, 'Degradê',          40.00, 35),
( 7, 'Sobrancelha',      15.00, 15),
( 8, 'Luzes',           110.00, 90),
( 9, 'Relaxamento',      70.00, 60),
(10, 'Corte Infantil',   30.00, 25);

-- ------------------------------------------------------------
-- ATENDIMENTO_SERVIÇO (10 registros)
-- ------------------------------------------------------------
INSERT INTO ATENDIMENTO_SERVICO (ID_ATENDIMENTO, ID_SERVICO) VALUES
( 1,  1),
( 1,  2),
( 2,  3),
( 3,  1),
( 4,  5),
( 5,  3),
( 6,  6),
( 7,  4),
( 8,  2),
(10, 10);

-- ------------------------------------------------------------
-- PRODUTO (10 registros)
-- ------------------------------------------------------------
INSERT INTO PRODUTO (ID_PRODUTO, NOME, PRECO, QUANTIDADE) VALUES
( 1, 'Pomada Modeladora',  29.90, 50),
( 2, 'Óleo de Barba',      39.90, 30),
( 3, 'Shampoo Anticaspa',  24.90, 40),
( 4, 'Cera Capilar',       34.90, 25),
( 5, 'Loção Pós-Barba',    49.90, 20),
( 6, 'Condicionador',      22.90, 35),
( 7, 'Tônico Capilar',     59.90, 15),
( 8, 'Gel Fixador',        19.90, 60),
( 9, 'Máscara de Hidrat.', 44.90, 18),
(10, 'Balm para Barba',    54.90, 22);

-- ------------------------------------------------------------
-- ATENDIMENTO_PRODUTO (10 registros)
-- ------------------------------------------------------------
INSERT INTO ATENDIMENTO_PRODUTO (ID_ATENDIMENTO, ID_PRODUTO, QUANTIDADE) VALUES
( 1,  1, 1),
( 2,  2, 1),
( 3,  3, 2),
( 4,  4, 1),
( 5,  5, 1),
( 6,  8, 2),
( 7,  9, 1),
( 8,  2, 1),
( 9,  6, 1),
(10, 10, 1);

-- ------------------------------------------------------------
-- PAGAMENTO (10 registros)
-- ------------------------------------------------------------
INSERT INTO PAGAMENTO (ID_PAGAMENTO, VALOR, FORMA_PAGAMENTO, STATUS, ID_ATENDIMENTO) VALUES
( 1,  60.00, 'PIX',      'Pago',      1),
( 2,  55.00, 'Cartão',   'Pago',      2),
( 3,  35.00, 'Dinheiro', 'Pago',      3),
( 4,  90.00, 'PIX',      'Pago',      4),
( 5,  55.00, 'Cartão',   'Pago',      5),
( 6,  40.00, 'Dinheiro', 'Pendente',  6),
( 7,  45.00, 'PIX',      'Pendente',  7),
( 8,  25.00, 'Cartão',   'Pendente',  8),
( 9,  35.00, 'Dinheiro', 'Pendente',  9),
(10,  30.00, 'PIX',      'Pendente', 10);
