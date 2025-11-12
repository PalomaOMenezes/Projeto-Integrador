-- ===========================================================
-- PROJETO INTEGRADOR - SENAC EAD (2ª ENTREGA)
-- PARTE: DML - Linguagem de Manipulação de Dados (SQL)
-- ===========================================================

-- 1) INSERÇÕES (INSERT)
INSERT INTO pessoa_fisica (id, nome, cpf, data_nascimento, email, telefone, endereco) VALUES
  (1, 'Carlos Silva', '123.456.789-00', '1998-05-12', 'carlos.silva@exemplo.com', '(11)99999-0001', 'Rua A, 100, SP'),
  (2, 'Mariana Souza', '987.654.321-00', '1985-11-03', 'mariana.souza@exemplo.com', '(11)99999-0002', 'Av B, 200, SP'),
  (3, 'André Gomes', '555.666.777-88', '2003-02-20', 'andre.gomes@exemplo.com', '(11)99999-0003', 'Praça C, 30, SP');

INSERT INTO pessoa_juridica (id, razao_social, cnpj, email, telefone, endereco) VALUES
  (1, 'Fornecedora Tech Ltda', '12.345.678/0001-90', 'contato@fornecedora.com', '(11)3333-4444', 'Rua Fornecedor, 50, SP'),
  (2, 'Serviços Educacionais SA', '98.765.432/0001-11', 'vendas@servicosedu.com', '(11)3333-5555', 'Av Escola, 400, SP');

INSERT INTO professor (id, pessoa_fisica_id, matricula, area, titulacao, ativo) VALUES
  (1, 2, 'PROF-2025-001', 'Algoritmos e Programação', 'Mestrado', true);

INSERT INTO aluno (id, pessoa_fisica_id, matricula, curso, periodo, data_matricula, ativo) VALUES
  (1, 3, 'ALU-2025-1001', 'Análise e Desenvolvimento de Sistemas', '3', '2025-02-10', true);

INSERT INTO fornecedor (id, pessoa_juridica_id, inscricao_estadual, contato, ativo) VALUES
  (1, 1, '123456789', 'Paula Lima', true);

INSERT INTO administrador (id, pessoa_fisica_id, usuario, senha_hash, nivel_acesso, ativo) VALUES
  (1, 1, 'admin_carlos', 'HASH_SENHA_EXEMPLO', 'SUPER', true);

-- 2) ATUALIZAÇÕES (UPDATE)
UPDATE pessoa_fisica
SET email = 'andre.gomes2025@exemplo.com', telefone = '(11)98888-0003'
WHERE id = 3;

UPDATE professor
SET ativo = false
WHERE id = 1;

UPDATE pessoa_juridica
SET telefone = '(11)4444-7777', endereco = 'Av Nova, 999, SP'
WHERE id = 1;

-- 3) EXCLUSÕES (DELETE ou SOFT DELETE)
UPDATE aluno
SET ativo = false
WHERE id = 1;

DELETE FROM fornecedor WHERE id = 1;

-- 4) CONSULTAS (SELECT)
SELECT a.id AS aluno_id, a.matricula, a.curso, pf.nome, pf.cpf, pf.email, pf.telefone
FROM aluno a
JOIN pessoa_fisica pf ON a.pessoa_fisica_id = pf.id
WHERE a.ativo = true;

SELECT p.id AS professor_id, p.matricula, pf.nome, p.area, p.titulacao, p.ativo
FROM professor p
JOIN pessoa_fisica pf ON p.pessoa_fisica_id = pf.id
ORDER BY pf.nome;

SELECT f.id, pj.razao_social, pj.cnpj, f.contato, pj.email, pj.telefone
FROM fornecedor f
JOIN pessoa_juridica pj ON f.pessoa_juridica_id = pj.id
WHERE f.ativo = true;

-- 5) TRANSAÇÃO DE MATRÍCULA
BEGIN;
INSERT INTO pessoa_fisica (id, nome, cpf, data_nascimento, email, telefone, endereco)
VALUES (10, 'Lucas Pereira', '222.333.444-55', '2004-07-01', 'lucas@exemplo.com', '(11)97777-1111', 'Rua X, 10, SP');
INSERT INTO aluno (id, pessoa_fisica_id, matricula, curso, periodo, data_matricula, ativo)
VALUES (10, 10, 'ALU-2025-1010', 'ADS', '1', NOW()::DATE, true);
INSERT INTO matricula (id, aluno_id, ano, semestre, status)
VALUES (1, 10, 2025, 1, 'Matriculado');
COMMIT;

-- 6) PREPARED STATEMENT (PostgreSQL)
PREPARE ins_pessoa_fisica(text, text, text, date, text, text, text) AS
  INSERT INTO pessoa_fisica (nome, cpf, rg, data_nascimento, email, telefone, endereco)
  VALUES ($1, $2, $3, $4, $5, $6, $7);
EXECUTE ins_pessoa_fisica('Ana Clara', '111.222.333-44', 'MG-12.345.678', '2000-03-15', 'ana@exemplo.com', '(11)96666-0000', 'Rua Y, 20, SP');
DEALLOCATE ins_pessoa_fisica;

-- 7) CONSULTAS AVANÇADAS
SELECT curso, COUNT(*) AS total_alunos
FROM aluno
WHERE ativo = true
GROUP BY curso
ORDER BY total_alunos DESC;

SELECT area, COUNT(*) AS num_professores
FROM professor
WHERE ativo = true
GROUP BY area;

SELECT pf.id, pf.nome, pf.email, pf.updated_at
FROM pessoa_fisica pf
ORDER BY pf.updated_at DESC
LIMIT 20;

-- ===========================================================
-- FIM DOS SCRIPTS DML
-- ===========================================================
