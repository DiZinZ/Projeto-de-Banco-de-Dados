-- ============================================================
--  SISTEMA DE GERENCIAMENTO DE BARBEARIA
--  Etapas 2 + 3 + 4 — Arquivo Completo
--  Data: 10/06/2026
-- ============================================================

SET NAMES 'utf8mb4';

-- ============================================================
--  ETAPA 2 — DDL: CRIAÇÃO DO BANCO E TABELAS
-- ============================================================

CREATE DATABASE IF NOT EXISTS barbearia;
USE barbearia;

CREATE TABLE CLIENTE (
    ID_CLIENTE   INT          NOT NULL AUTO_INCREMENT,
    NOME         VARCHAR(100) NOT NULL,
    TELEFONE     VARCHAR(20),
    CPF          VARCHAR(14)  NOT NULL UNIQUE,
    PRIMARY KEY (ID_CLIENTE)
);

CREATE TABLE FUNCIONARIO (
    ID_FUNCIONARIO INT          NOT NULL AUTO_INCREMENT,
    NOME           VARCHAR(100) NOT NULL,
    CPF            VARCHAR(14)  NOT NULL UNIQUE,
    TELEFONE       VARCHAR(20),
    PRIMARY KEY (ID_FUNCIONARIO)
);

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

CREATE TABLE SERVICO (
    ID_SERVICO INT           NOT NULL AUTO_INCREMENT,
    NOME       VARCHAR(80)   NOT NULL,
    PRECO      DECIMAL(10,2) NOT NULL,
    DURACAO    INT           NOT NULL COMMENT 'Duração em minutos',
    PRIMARY KEY (ID_SERVICO)
);

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

CREATE TABLE PRODUTO (
    ID_PRODUTO INT           NOT NULL AUTO_INCREMENT,
    NOME       VARCHAR(80)   NOT NULL,
    PRECO      DECIMAL(10,2) NOT NULL,
    QUANTIDADE INT           NOT NULL DEFAULT 0,
    PRIMARY KEY (ID_PRODUTO)
);

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
--  ETAPA 2 — DML: INSERÇÃO DE DADOS
-- ============================================================

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

INSERT INTO FUNCIONARIO (ID_FUNCIONARIO, NOME, CPF, TELEFONE) VALUES
(1, 'Pedro Alves',   '111.222.333-44', '(62) 91111-2222'),
(2, 'Mariana Lima',  '222.333.444-55', '(62) 93333-4444'),
(3, 'João Ferreira', '333.444.555-66', '(62) 95555-6666'),
(4, 'Beatriz Souza', '444.555.666-77', '(62) 97777-8888'),
(5, 'Carlos Neves',  '555.666.777-88', '(62) 99999-0000');

INSERT INTO BARBEIRO (ID_FUNCIONARIO, ESPECIALIDADE, SALARIO, STATUS) VALUES
(1, 'Corte Masculino', 2500.00, 'Ativo'),
(2, 'Barba e Cabelo',  3000.00, 'Ativo'),
(4, 'Coloração',       2800.00, 'Ativo'),
(5, 'Corte Infantil',  2200.00, 'Inativo');

INSERT INTO ATENDENTE (ID_FUNCIONARIO, SALARIO, STATUS, SETOR) VALUES
(3, 1800.00, 'Ativo', 'Recepção');

INSERT INTO AGENDAMENTO (ID_AGENDAMENTO, DATA_AGENDAMENTO, ID_CLIENTE, ID_FUNCIONARIO) VALUES
( 1, '2026-05-20',  1, 1), ( 2, '2026-05-21',  2, 2),
( 3, '2026-05-22',  3, 1), ( 4, '2026-05-23',  4, 4),
( 5, '2026-05-24',  5, 2), ( 6, '2026-05-25',  6, 1),
( 7, '2026-05-26',  7, 2), ( 8, '2026-05-27',  8, 4),
( 9, '2026-05-28',  9, 1), (10, '2026-05-29', 10, 5);

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

INSERT INTO SERVICO (ID_SERVICO, NOME, PRECO, DURACAO) VALUES
( 1, 'Corte de Cabelo',  35.00, 30), ( 2, 'Barba',           25.00, 20),
( 3, 'Corte + Barba',    55.00, 50), ( 4, 'Hidratação',      45.00, 40),
( 5, 'Coloração',        90.00, 80), ( 6, 'Degradê',         40.00, 35),
( 7, 'Sobrancelha',      15.00, 15), ( 8, 'Luzes',          110.00, 90),
( 9, 'Relaxamento',      70.00, 60), (10, 'Corte Infantil',  30.00, 25);

INSERT INTO ATENDIMENTO_SERVICO (ID_ATENDIMENTO, ID_SERVICO) VALUES
( 1,  1), ( 1,  2), ( 2,  3), ( 3,  1), ( 4,  5),
( 5,  3), ( 6,  6), ( 7,  4), ( 8,  2), (10, 10);

INSERT INTO PRODUTO (ID_PRODUTO, NOME, PRECO, QUANTIDADE) VALUES
( 1, 'Pomada Modeladora',  29.90, 50), ( 2, 'Óleo de Barba',      39.90, 30),
( 3, 'Shampoo Anticaspa',  24.90, 40), ( 4, 'Cera Capilar',       34.90, 25),
( 5, 'Loção Pós-Barba',    49.90, 20), ( 6, 'Condicionador',      22.90, 35),
( 7, 'Tônico Capilar',     59.90, 15), ( 8, 'Gel Fixador',        19.90, 60),
( 9, 'Máscara de Hidrat.', 44.90, 18), (10, 'Balm para Barba',    54.90, 22);

INSERT INTO ATENDIMENTO_PRODUTO (ID_ATENDIMENTO, ID_PRODUTO, QUANTIDADE) VALUES
( 1,  1, 1), ( 2,  2, 1), ( 3,  3, 2), ( 4,  4, 1), ( 5,  5, 1),
( 6,  8, 2), ( 7,  9, 1), ( 8,  2, 1), ( 9,  6, 1), (10, 10, 1);

INSERT INTO PAGAMENTO (ID_PAGAMENTO, VALOR, FORMA_PAGAMENTO, STATUS, ID_ATENDIMENTO) VALUES
( 1,  60.00, 'PIX',      'Pago',      1), ( 2,  55.00, 'Cartão',   'Pago',      2),
( 3,  35.00, 'Dinheiro', 'Pago',      3), ( 4,  90.00, 'PIX',      'Pago',      4),
( 5,  55.00, 'Cartão',   'Pago',      5), ( 6,  40.00, 'Dinheiro', 'Pendente',  6),
( 7,  45.00, 'PIX',      'Pendente',  7), ( 8,  25.00, 'Cartão',   'Pendente',  8),
( 9,  35.00, 'Dinheiro', 'Pendente',  9), (10,  30.00, 'PIX',      'Pendente', 10);


-- ============================================================
--  ETAPA 3 — VIEWS (criadas antes dos SELECTs)
-- ============================================================

CREATE OR REPLACE VIEW vw_relatorio_atendimentos AS
SELECT
    AT.ID_ATENDIMENTO, AT.DATA, AT.HORA,
    AT.STATUS AS STATUS_ATENDIMENTO,
    C.NOME AS CLIENTE, C.TELEFONE,
    F.NOME AS FUNCIONARIO,
    PG.VALOR, PG.FORMA_PAGAMENTO, PG.STATUS AS STATUS_PAGAMENTO
FROM ATENDIMENTO AT
INNER JOIN AGENDAMENTO  AG ON AT.ID_AGENDAMENTO = AG.ID_AGENDAMENTO
INNER JOIN CLIENTE       C ON AG.ID_CLIENTE      = C.ID_CLIENTE
INNER JOIN FUNCIONARIO   F ON AT.ID_FUNCIONARIO  = F.ID_FUNCIONARIO
LEFT  JOIN PAGAMENTO    PG ON AT.ID_ATENDIMENTO  = PG.ID_ATENDIMENTO;

CREATE OR REPLACE VIEW vw_relatorio_financeiro AS
SELECT
    PG.ID_PAGAMENTO, AT.DATA,
    C.NOME AS CLIENTE, F.NOME AS FUNCIONARIO,
    PG.VALOR, PG.FORMA_PAGAMENTO, PG.STATUS
FROM PAGAMENTO PG
INNER JOIN ATENDIMENTO  AT ON PG.ID_ATENDIMENTO = AT.ID_ATENDIMENTO
INNER JOIN AGENDAMENTO  AG ON AT.ID_AGENDAMENTO = AG.ID_AGENDAMENTO
INNER JOIN CLIENTE       C ON AG.ID_CLIENTE      = C.ID_CLIENTE
INNER JOIN FUNCIONARIO   F ON AT.ID_FUNCIONARIO  = F.ID_FUNCIONARIO;

CREATE OR REPLACE VIEW vw_desempenho_funcionarios AS
SELECT
    F.NOME AS FUNCIONARIO, B.ESPECIALIDADE,
    COUNT(AT.ID_ATENDIMENTO) AS TOTAL_ATENDIMENTOS,
    SUM(PG.VALOR) AS FATURAMENTO_GERADO,
    AVG(PG.VALOR) AS TICKET_MEDIO
FROM FUNCIONARIO F
LEFT JOIN BARBEIRO     B  ON F.ID_FUNCIONARIO  = B.ID_FUNCIONARIO
LEFT JOIN ATENDIMENTO  AT ON F.ID_FUNCIONARIO  = AT.ID_FUNCIONARIO
LEFT JOIN PAGAMENTO    PG ON AT.ID_ATENDIMENTO = PG.ID_ATENDIMENTO
GROUP BY F.ID_FUNCIONARIO, F.NOME, B.ESPECIALIDADE;

CREATE OR REPLACE VIEW vw_pagamentos_pendentes AS
SELECT
    PG.ID_PAGAMENTO, C.NOME AS CLIENTE, C.TELEFONE,
    AT.DATA, PG.VALOR, PG.FORMA_PAGAMENTO
FROM PAGAMENTO PG
INNER JOIN ATENDIMENTO  AT ON PG.ID_ATENDIMENTO = AT.ID_ATENDIMENTO
INNER JOIN AGENDAMENTO  AG ON AT.ID_AGENDAMENTO = AG.ID_AGENDAMENTO
INNER JOIN CLIENTE       C ON AG.ID_CLIENTE      = C.ID_CLIENTE
WHERE PG.STATUS = 'Pendente';


-- ============================================================
--  ETAPA 3 — CONSULTAS COM JOINS
-- ============================================================

-- 1.1 INNER JOIN — Clientes com seus agendamentos
SELECT C.ID_CLIENTE, C.NOME AS CLIENTE, C.TELEFONE,
       A.ID_AGENDAMENTO, A.DATA_AGENDAMENTO
FROM CLIENTE C
INNER JOIN AGENDAMENTO A ON C.ID_CLIENTE = A.ID_CLIENTE
ORDER BY A.DATA_AGENDAMENTO;

-- 1.2 INNER JOIN — Agendamentos com funcionário responsável
SELECT A.ID_AGENDAMENTO, A.DATA_AGENDAMENTO,
       C.NOME AS CLIENTE, F.NOME AS FUNCIONARIO
FROM AGENDAMENTO A
INNER JOIN CLIENTE     C ON A.ID_CLIENTE     = C.ID_CLIENTE
INNER JOIN FUNCIONARIO F ON A.ID_FUNCIONARIO = F.ID_FUNCIONARIO
ORDER BY A.DATA_AGENDAMENTO;

-- 1.3 INNER JOIN — Atendimentos com serviços realizados
SELECT AT.ID_ATENDIMENTO, AT.DATA, AT.HORA, AT.STATUS,
       S.NOME AS SERVICO, S.PRECO
FROM ATENDIMENTO AT
INNER JOIN ATENDIMENTO_SERVICO ASV ON AT.ID_ATENDIMENTO = ASV.ID_ATENDIMENTO
INNER JOIN SERVICO              S   ON ASV.ID_SERVICO    = S.ID_SERVICO
ORDER BY AT.DATA, AT.HORA;

-- 1.4 INNER JOIN — Atendimentos com produtos utilizados
SELECT AT.ID_ATENDIMENTO, AT.DATA, C.NOME AS CLIENTE,
       P.NOME AS PRODUTO, AP.QUANTIDADE, P.PRECO
FROM ATENDIMENTO AT
INNER JOIN AGENDAMENTO         AG ON AT.ID_AGENDAMENTO = AG.ID_AGENDAMENTO
INNER JOIN CLIENTE              C ON AG.ID_CLIENTE      = C.ID_CLIENTE
INNER JOIN ATENDIMENTO_PRODUTO AP ON AT.ID_ATENDIMENTO  = AP.ID_ATENDIMENTO
INNER JOIN PRODUTO              P ON AP.ID_PRODUTO      = P.ID_PRODUTO
ORDER BY AT.DATA;

-- 1.5 INNER JOIN — Pagamentos com dados do atendimento e cliente
SELECT PG.ID_PAGAMENTO, C.NOME AS CLIENTE, F.NOME AS FUNCIONARIO,
       AT.DATA, AT.HORA, PG.VALOR, PG.FORMA_PAGAMENTO, PG.STATUS AS STATUS_PAGAMENTO
FROM PAGAMENTO PG
INNER JOIN ATENDIMENTO  AT ON PG.ID_ATENDIMENTO = AT.ID_ATENDIMENTO
INNER JOIN AGENDAMENTO  AG ON AT.ID_AGENDAMENTO = AG.ID_AGENDAMENTO
INNER JOIN CLIENTE       C ON AG.ID_CLIENTE      = C.ID_CLIENTE
INNER JOIN FUNCIONARIO   F ON AT.ID_FUNCIONARIO  = F.ID_FUNCIONARIO
ORDER BY AT.DATA;

-- 1.6 LEFT JOIN — Todos os clientes, mesmo sem agendamento
SELECT C.ID_CLIENTE, C.NOME AS CLIENTE, C.TELEFONE,
       A.ID_AGENDAMENTO, A.DATA_AGENDAMENTO
FROM CLIENTE C
LEFT JOIN AGENDAMENTO A ON C.ID_CLIENTE = A.ID_CLIENTE
ORDER BY A.ID_AGENDAMENTO IS NULL DESC, C.NOME;

-- 1.7 LEFT JOIN — Todos os funcionários e seus atendimentos
SELECT F.ID_FUNCIONARIO, F.NOME AS FUNCIONARIO,
       AT.ID_ATENDIMENTO, AT.DATA, AT.STATUS
FROM FUNCIONARIO F
LEFT JOIN ATENDIMENTO AT ON F.ID_FUNCIONARIO = AT.ID_FUNCIONARIO
ORDER BY AT.ID_ATENDIMENTO IS NULL DESC, F.NOME;

-- 1.8 RIGHT JOIN — Atendimentos com ou sem pagamento
SELECT AT.ID_ATENDIMENTO, AT.DATA, AT.STATUS,
       PG.ID_PAGAMENTO, PG.VALOR, PG.STATUS AS STATUS_PAGAMENTO
FROM PAGAMENTO PG
RIGHT JOIN ATENDIMENTO AT ON PG.ID_ATENDIMENTO = AT.ID_ATENDIMENTO
ORDER BY PG.ID_PAGAMENTO IS NULL DESC, AT.DATA;


-- ============================================================
--  ETAPA 3 — FUNÇÕES AGREGADAS + GROUP BY
-- ============================================================

-- 2.1 Total de atendimentos por funcionário
SELECT F.NOME AS FUNCIONARIO, COUNT(AT.ID_ATENDIMENTO) AS TOTAL_ATENDIMENTOS
FROM FUNCIONARIO F
LEFT JOIN ATENDIMENTO AT ON F.ID_FUNCIONARIO = AT.ID_FUNCIONARIO
GROUP BY F.ID_FUNCIONARIO, F.NOME
ORDER BY TOTAL_ATENDIMENTOS DESC;

-- 2.2 Faturamento total por forma de pagamento
SELECT FORMA_PAGAMENTO, COUNT(*) AS QUANTIDADE,
       SUM(VALOR) AS TOTAL, AVG(VALOR) AS TICKET_MEDIO
FROM PAGAMENTO
GROUP BY FORMA_PAGAMENTO
ORDER BY TOTAL DESC;

-- 2.3 Serviços mais realizados
SELECT S.NOME AS SERVICO, S.PRECO,
       COUNT(ASV.ID_ATENDIMENTO) AS VEZES_REALIZADO,
       SUM(S.PRECO) AS RECEITA_TOTAL
FROM SERVICO S
LEFT JOIN ATENDIMENTO_SERVICO ASV ON S.ID_SERVICO = ASV.ID_SERVICO
GROUP BY S.ID_SERVICO, S.NOME, S.PRECO
ORDER BY VEZES_REALIZADO DESC;

-- 2.4 Produtos mais utilizados
SELECT P.NOME AS PRODUTO, P.PRECO, SUM(AP.QUANTIDADE) AS TOTAL_USADO
FROM PRODUTO P
LEFT JOIN ATENDIMENTO_PRODUTO AP ON P.ID_PRODUTO = AP.ID_PRODUTO
GROUP BY P.ID_PRODUTO, P.NOME, P.PRECO
ORDER BY TOTAL_USADO DESC;

-- 2.5 Agendamentos por mês
SELECT DATE_FORMAT(DATA_AGENDAMENTO, '%Y-%m') AS MES,
       COUNT(*) AS TOTAL_AGENDAMENTOS
FROM AGENDAMENTO
GROUP BY MES ORDER BY MES;


-- ============================================================
--  ETAPA 3 — HAVING
-- ============================================================

-- 3.1 Funcionários com mais de 2 atendimentos
SELECT F.NOME AS FUNCIONARIO, COUNT(AT.ID_ATENDIMENTO) AS TOTAL_ATENDIMENTOS
FROM FUNCIONARIO F
INNER JOIN ATENDIMENTO AT ON F.ID_FUNCIONARIO = AT.ID_FUNCIONARIO
GROUP BY F.ID_FUNCIONARIO, F.NOME
HAVING COUNT(AT.ID_ATENDIMENTO) > 2
ORDER BY TOTAL_ATENDIMENTOS DESC;

-- 3.2 Serviços com receita total acima de R$ 50,00
SELECT S.NOME AS SERVICO,
       COUNT(ASV.ID_ATENDIMENTO) AS VEZES_REALIZADO,
       SUM(S.PRECO) AS RECEITA_TOTAL
FROM SERVICO S
INNER JOIN ATENDIMENTO_SERVICO ASV ON S.ID_SERVICO = ASV.ID_SERVICO
GROUP BY S.ID_SERVICO, S.NOME, S.PRECO
HAVING SUM(S.PRECO) > 50.00
ORDER BY RECEITA_TOTAL DESC;

-- 3.3 Clientes com mais de 1 agendamento
SELECT C.NOME AS CLIENTE, COUNT(A.ID_AGENDAMENTO) AS TOTAL_AGENDAMENTOS
FROM CLIENTE C
INNER JOIN AGENDAMENTO A ON C.ID_CLIENTE = A.ID_CLIENTE
GROUP BY C.ID_CLIENTE, C.NOME
HAVING COUNT(A.ID_AGENDAMENTO) > 1
ORDER BY TOTAL_AGENDAMENTOS DESC;


-- ============================================================
--  ETAPA 3 — SUBQUERIES
-- ============================================================

-- 4.1 Clientes que fizeram pelo menos um agendamento
SELECT NOME, CPF, TELEFONE FROM CLIENTE
WHERE ID_CLIENTE IN (SELECT DISTINCT ID_CLIENTE FROM AGENDAMENTO);

-- 4.2 Clientes que NUNCA fizeram agendamento
SELECT NOME, CPF, TELEFONE FROM CLIENTE
WHERE ID_CLIENTE NOT IN (SELECT DISTINCT ID_CLIENTE FROM AGENDAMENTO);

-- 4.3 Funcionários com atendimentos concluídos
SELECT NOME, CPF, TELEFONE FROM FUNCIONARIO
WHERE ID_FUNCIONARIO IN (
    SELECT DISTINCT ID_FUNCIONARIO FROM ATENDIMENTO WHERE STATUS = 'Concluído'
);

-- 4.4 Serviços com preço acima da média
SELECT NOME, PRECO FROM SERVICO
WHERE PRECO > (SELECT AVG(PRECO) FROM SERVICO)
ORDER BY PRECO DESC;

-- 4.5 Atendimentos com pagamento pendente
SELECT AT.ID_ATENDIMENTO, AT.DATA, AT.STATUS FROM ATENDIMENTO AT
WHERE AT.ID_ATENDIMENTO IN (
    SELECT ID_ATENDIMENTO FROM PAGAMENTO WHERE STATUS = 'Pendente'
);

-- 4.6 Barbeiro com maior salário
SELECT F.NOME, B.ESPECIALIDADE, B.SALARIO
FROM FUNCIONARIO F
INNER JOIN BARBEIRO B ON F.ID_FUNCIONARIO = B.ID_FUNCIONARIO
WHERE B.SALARIO = (SELECT MAX(SALARIO) FROM BARBEIRO);


-- ============================================================
--  ETAPA 3 — DADOS INCONSISTENTES
-- ============================================================

-- 5.1 Clientes sem telefone
SELECT ID_CLIENTE, NOME, CPF, TELEFONE FROM CLIENTE
WHERE TELEFONE IS NULL OR TELEFONE = '';

-- 5.2 Clientes sem CPF
SELECT ID_CLIENTE, NOME, TELEFONE FROM CLIENTE
WHERE CPF IS NULL OR CPF = '';

-- 5.3 Funcionários sem telefone
SELECT ID_FUNCIONARIO, NOME, CPF, TELEFONE FROM FUNCIONARIO
WHERE TELEFONE IS NULL OR TELEFONE = '';

-- 5.4 Barbeiros sem especialidade
SELECT F.NOME, B.ESPECIALIDADE, B.STATUS FROM BARBEIRO B
INNER JOIN FUNCIONARIO F ON B.ID_FUNCIONARIO = F.ID_FUNCIONARIO
WHERE B.ESPECIALIDADE IS NULL OR B.ESPECIALIDADE = '';

-- 5.5 Atendimentos sem pagamento vinculado
SELECT AT.ID_ATENDIMENTO, AT.DATA, AT.HORA, AT.STATUS FROM ATENDIMENTO AT
WHERE AT.ID_ATENDIMENTO NOT IN (SELECT ID_ATENDIMENTO FROM PAGAMENTO);

-- 5.6 Atendimentos sem serviço vinculado
SELECT AT.ID_ATENDIMENTO, AT.DATA, AT.STATUS FROM ATENDIMENTO AT
WHERE AT.ID_ATENDIMENTO NOT IN (SELECT DISTINCT ID_ATENDIMENTO FROM ATENDIMENTO_SERVICO);

-- 5.7 Atendimentos sem produto vinculado
SELECT AT.ID_ATENDIMENTO, AT.DATA, AT.STATUS FROM ATENDIMENTO AT
WHERE AT.ID_ATENDIMENTO NOT IN (SELECT DISTINCT ID_ATENDIMENTO FROM ATENDIMENTO_PRODUTO);

-- 5.8 Resumo geral de inconsistências
SELECT 'Clientes sem telefone'       AS INCONSISTENCIA, COUNT(*) AS TOTAL FROM CLIENTE     WHERE TELEFONE IS NULL OR TELEFONE = ''
UNION ALL
SELECT 'Funcionários sem telefone',   COUNT(*) FROM FUNCIONARIO WHERE TELEFONE IS NULL OR TELEFONE = ''
UNION ALL
SELECT 'Barbeiros sem especialidade', COUNT(*) FROM BARBEIRO    WHERE ESPECIALIDADE IS NULL OR ESPECIALIDADE = ''
UNION ALL
SELECT 'Atendimentos sem pagamento',  COUNT(*) FROM ATENDIMENTO WHERE ID_ATENDIMENTO NOT IN (SELECT ID_ATENDIMENTO FROM PAGAMENTO)
UNION ALL
SELECT 'Atendimentos sem serviço',    COUNT(*) FROM ATENDIMENTO WHERE ID_ATENDIMENTO NOT IN (SELECT DISTINCT ID_ATENDIMENTO FROM ATENDIMENTO_SERVICO)
UNION ALL
SELECT 'Atendimentos sem produto',    COUNT(*) FROM ATENDIMENTO WHERE ID_ATENDIMENTO NOT IN (SELECT DISTINCT ID_ATENDIMENTO FROM ATENDIMENTO_PRODUTO);


-- ============================================================
--  ETAPA 3 — CONSULTAS DAS VIEWS
-- ============================================================

SELECT * FROM vw_relatorio_atendimentos  ORDER BY DATA, HORA;
SELECT * FROM vw_relatorio_financeiro    ORDER BY DATA;
SELECT * FROM vw_desempenho_funcionarios ORDER BY FATURAMENTO_GERADO DESC;
SELECT * FROM vw_pagamentos_pendentes    ORDER BY DATA;


-- ============================================================
--  ETAPA 4 — TRANSAÇÕES E OPERAÇÕES AVANÇADAS
-- ============================================================

-- ------------------------------------------------------------
-- T1: COMMIT — Cadastrar novo cliente + agendamento juntos
-- ------------------------------------------------------------
START TRANSACTION;

    INSERT INTO CLIENTE (ID_CLIENTE, NOME, TELEFONE, CPF) VALUES
    (11, 'Lucas Oliveira', '(62) 98888-7777', '111.999.888-77');

    INSERT INTO AGENDAMENTO (ID_AGENDAMENTO, DATA_AGENDAMENTO, ID_CLIENTE, ID_FUNCIONARIO) VALUES
    (11, '2026-06-10', 11, 1);

COMMIT;
-- ✅ Cliente e agendamento salvos juntos

-- ------------------------------------------------------------
-- T2: ROLLBACK — Pagamento com valor inválido (revertido)
-- ------------------------------------------------------------
START TRANSACTION;

    INSERT INTO ATENDIMENTO (ID_ATENDIMENTO, DATA, HORA, STATUS, ID_AGENDAMENTO, ID_FUNCIONARIO) VALUES
    (12, '2026-06-10', '09:00:00', 'Concluído', 11, 1);

    INSERT INTO PAGAMENTO (ID_PAGAMENTO, VALOR, FORMA_PAGAMENTO, STATUS, ID_ATENDIMENTO) VALUES
    (11, -50.00, 'PIX', 'Pago', 12); -- ❌ valor negativo, operação inválida

ROLLBACK;
-- ⛔ Nenhuma alteração salva — tudo revertido

-- ------------------------------------------------------------
-- T3: COMMIT — Concluir atendimento + serviço + produto + pagamento
-- ------------------------------------------------------------
START TRANSACTION;

    INSERT INTO ATENDIMENTO (ID_ATENDIMENTO, DATA, HORA, STATUS, ID_AGENDAMENTO, ID_FUNCIONARIO) VALUES
    (11, '2026-06-10', '09:00:00', 'Concluído', 11, 1);

    INSERT INTO ATENDIMENTO_SERVICO (ID_ATENDIMENTO, ID_SERVICO) VALUES
    (11, 1), (11, 2);

    INSERT INTO ATENDIMENTO_PRODUTO (ID_ATENDIMENTO, ID_PRODUTO, QUANTIDADE) VALUES
    (11, 1, 1);

    INSERT INTO PAGAMENTO (ID_PAGAMENTO, VALOR, FORMA_PAGAMENTO, STATUS, ID_ATENDIMENTO) VALUES
    (11, 60.00, 'PIX', 'Pago', 11);

COMMIT;
-- ✅ Atendimento completo salvo com segurança

-- ------------------------------------------------------------
-- T4: SAVEPOINT — Reajuste de preços com ponto de retorno
-- ------------------------------------------------------------
START TRANSACTION;

    SAVEPOINT antes_do_reajuste;

    -- Tenta reajuste de 10%
    UPDATE SERVICO SET PRECO = PRECO * 1.10;

    -- Reverte pois o reajuste foi muito alto
    ROLLBACK TO antes_do_reajuste;

    -- Aplica reajuste mais conservador de 5%
    UPDATE SERVICO SET PRECO = PRECO * 1.05;

COMMIT;
-- ✅ Reajuste de 5% aplicado com segurança

-- ------------------------------------------------------------
-- T5: SAVEPOINT — Cadastro de funcionário com retorno parcial
-- ------------------------------------------------------------
START TRANSACTION;

    INSERT INTO FUNCIONARIO (ID_FUNCIONARIO, NOME, CPF, TELEFONE) VALUES
    (6, 'Rafael Moura', '666.777.888-99', '(62) 91212-3434');

    INSERT INTO BARBEIRO (ID_FUNCIONARIO, ESPECIALIDADE, SALARIO, STATUS) VALUES
    (6, 'Degradê', 2600.00, 'Ativo');

    SAVEPOINT antes_do_agendamento;

    INSERT INTO AGENDAMENTO (ID_AGENDAMENTO, DATA_AGENDAMENTO, ID_CLIENTE, ID_FUNCIONARIO) VALUES
    (12, '2026-06-11', 1, 6);

COMMIT;
-- ✅ Funcionário, barbeiro e agendamento salvos

-- ------------------------------------------------------------
-- T6: COMMIT — Atualizar pagamentos pendentes de atendimentos concluídos
-- ------------------------------------------------------------
START TRANSACTION;

    UPDATE PAGAMENTO
    SET STATUS = 'Pago'
    WHERE STATUS = 'Pendente'
    AND ID_ATENDIMENTO IN (
        SELECT ID_ATENDIMENTO FROM ATENDIMENTO WHERE STATUS = 'Concluído'
    );

COMMIT;
-- ✅ Pagamentos sincronizados com status dos atendimentos

-- ------------------------------------------------------------
-- T7: SAVEPOINT — Cancelamento de agendamento com estorno
-- ------------------------------------------------------------
START TRANSACTION;

    SAVEPOINT antes_do_cancelamento;

    UPDATE PAGAMENTO
    SET STATUS = 'Estornado'
    WHERE ID_ATENDIMENTO IN (
        SELECT ID_ATENDIMENTO FROM ATENDIMENTO WHERE ID_AGENDAMENTO = 11
    );

    UPDATE ATENDIMENTO
    SET STATUS = 'Cancelado'
    WHERE ID_AGENDAMENTO = 11;

COMMIT;
-- ✅ Cancelamento e estorno registrados com segurança

-- ------------------------------------------------------------
-- T8: COMMIT — Consistência: criar pagamento pendente para atendimentos sem pagamento
-- ------------------------------------------------------------
START TRANSACTION;

    INSERT INTO PAGAMENTO (VALOR, FORMA_PAGAMENTO, STATUS, ID_ATENDIMENTO)
    SELECT 0.00, 'A definir', 'Pendente', AT.ID_ATENDIMENTO
    FROM ATENDIMENTO AT
    WHERE AT.ID_ATENDIMENTO NOT IN (SELECT ID_ATENDIMENTO FROM PAGAMENTO)
    AND AT.STATUS = 'Concluído';

COMMIT;
-- ✅ Pagamentos pendentes criados para atendimentos sem registro

-- ------------------------------------------------------------
-- T9: SAVEPOINT — Corrigir estoque negativo de produtos
-- ------------------------------------------------------------
START TRANSACTION;

    SAVEPOINT antes_da_correcao_estoque;

    UPDATE PRODUTO SET QUANTIDADE = 0
    WHERE QUANTIDADE < 0;

COMMIT;
-- ✅ Estoque negativo corrigido

-- ------------------------------------------------------------
-- T10: COMMIT — Remover agendamentos antigos sem atendimento
-- ------------------------------------------------------------
START TRANSACTION;

    SAVEPOINT antes_da_limpeza;

    DELETE FROM AGENDAMENTO
    WHERE ID_AGENDAMENTO NOT IN (SELECT ID_AGENDAMENTO FROM ATENDIMENTO)
    AND DATA_AGENDAMENTO < '2026-01-01';

COMMIT;
-- ✅ Agendamentos antigos sem atendimento removidos
