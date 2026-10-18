-- 04-anonimizacion.sql
-- Eliminación total de PII para generar datasets estadísticos irreversibles

CREATE TABLE IF NOT EXISTS clientes_anonimizados (
    id SERIAL PRIMARY KEY,
    categoria_cliente VARCHAR(50),
    antiguedad_meses INT,
    activo BOOLEAN
);

INSERT INTO clientes_anonimizados (categoria_cliente, antiguedad_meses, activo)
SELECT 
    'General',
    EXTRACT(MONTH FROM AGE(NOW(), fecha_registro))::INT AS antiguedad_meses,
    activo
FROM clientes;