-- 1. Criação da estrutura (DDL)
CREATE TABLE prata.dim_localidade (
    id_cidade SERIAL PRIMARY KEY,
    cidade VARCHAR(100) NOT NULL
);

-- 2. Limpeza e carga dos dados (DML)
INSERT INTO prata.dim_localidade (cidade)
SELECT DISTINCT UPPER(TRIM(cidade))
FROM staging.cooperados
WHERE cidade IS NOT NULL;