-- 1. Criação da estrutura (DDL)
CREATE TABLE prata.dim_cooperados (
    id_cliente INT PRIMARY KEY,
    estado_civil VARCHAR(50),
    data_filiacao DATE,
    id_cidade INT
);

-- 2. Transformação, Cruzamento e Carga dos dados (DML)

INSERT INTO prata.dim_cooperados (
    id_cliente,
    estado_civil,
    data_filiacao,
    id_cidade
)
SELECT DISTINCT ON (c.id_cliente)
    c.id_cliente::INT,
    UPPER(TRIM(c.estado_civil)),
    c.data_filiacao::DATE,
    l.id_cidade
FROM staging.cooperados c
INNER JOIN prata.dim_localidade l 
    ON UPPER(TRIM(c.cidade)) = l.cidade;