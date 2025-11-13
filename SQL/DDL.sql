-- ===========================================================
-- CRIAÇÃO DO BANCO DE DADOS
-- ===========================================================
CREATE DATABASE universidade_db;
\c universidade_db;

-- ===========================================================
-- TABELA: pessoa_fisica
-- ===========================================================
CREATE TABLE pessoa_fisica (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    data_nascimento DATE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ===========================================================
-- TABELA: pessoa_juridica
-- ===========================================================
CREATE TABLE pessoa_juridica (
    id SERIAL PRIMARY KEY,
    razao_social VARCHAR(200) NOT NULL,
    nome_fantasia VARCHAR(200) NOT NULL,
    cnpj VARCHAR(18) UNIQUE NOT NULL,
    produto_fornecido VARCHAR(150) NOT NULL,
    endereco VARCHAR(150),
    cidade TEXT,
    estado TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ===========================================================
-- TABELA: professor (referencia pessoa_fisica)
-- ===========================================================
CREATE TABLE professor (
    id SERIAL PRIMARY KEY,
    pessoa_fisica_id INT NOT NULL REFERENCES pessoa_fisica(id) ON DELETE CASCADE,
    diploma VARCHAR(255) NOT NULL,
    cidade TEXT,
    estado TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ===========================================================
-- TABELA: aluno (referencia pessoa_fisica)
-- ===========================================================
CREATE TABLE aluno (
    id SERIAL PRIMARY KEY,
    pessoa_fisica_id INT NOT NULL REFERENCES pessoa_fisica(id) ON DELETE CASCADE,
    nome_da_mae VARCHAR(150) NOT NULL,
    ano_letivo INT,
    cidade TEXT,
    estado TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
-- ===========================================================
-- TABELA: fornecedor
-- ===========================================================
CREATE TABLE fornecedor (
    id SERIAL PRIMARY KEY,
    pessoa_juridica_id INT NOT NULL REFERENCES pessoa_juridica(id) ON DELETE CASCADE,
    inscricao_estadual VARCHAR(20),
    contato VARCHAR(100),
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

