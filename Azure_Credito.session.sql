-- 1. Criação da estrutura da Tabela Fato (DDL)
CREATE TABLE prata.fato_credito (
    id_cliente INT,
    id_cidade INT,
    renda_mensal NUMERIC(15,2),
    score_credito INT
);

-- 2. Transformação, Tipagem Financeira e Carga dos dados (DML)
INSERT INTO prata.fato_credito (
    id_cliente,
    id_cidade,
    renda_mensal,
    score_credito
)
SELECT 
    c.id_cliente::INT,
    l.id_cidade,
    
    -- TIPAGEM FINANCEIRA E BLINDAGEM:
    -- Converte para decimal com 2 casas e, se vier vazio, coloca 0.00
    COALESCE(c.renda_mensal::NUMERIC(15,2), 0.00) AS renda_mensal,
    
    -- TIPAGEM DE SCORE:
    -- Converte para número inteiro e, se vier vazio, coloca 0
    COALESCE(c.score_credito::INT, 0) AS score_credito

FROM staging.cooperados c
-- Faz o cruzamento para ir buscar o ID da cidade em vez do nome
LEFT JOIN prata.dim_localidade l 
    ON UPPER(TRIM(c.cidade)) = l.cidade;