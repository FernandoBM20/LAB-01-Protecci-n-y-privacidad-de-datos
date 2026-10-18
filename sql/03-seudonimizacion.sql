    -- 03-seudonimizacion.sql
-- Separación de identidad mediante funciones hash (SHA-256) y tablas de mapeo

CREATE EXTENSION IF NOT EXISTS pgcrypto;

DROP TABLE IF EXISTS analisis_clientes_seudonimo CASCADE;
DROP TABLE IF EXISTS token_mapeo_clientes CASCADE;

CREATE TABLE token_mapeo_clientes (
    id_pseudonimo VARCHAR(64) PRIMARY KEY,
    id_cliente_original INT REFERENCES clientes(id) ON DELETE CASCADE
);

CREATE TABLE analisis_clientes_seudonimo (
    id_pseudonimo VARCHAR(64) PRIMARY KEY,
    segmento_tarjeta VARCHAR(10),
    fecha_registro TIMESTAMP,
    activo BOOLEAN
);

-- Generación de tokens seudonimizados
INSERT INTO token_mapeo_clientes (id_pseudonimo, id_cliente_original)
SELECT ENCODE(DIGEST(id::text || email, 'sha256'), 'hex'), id
FROM clientes
ON CONFLICT (id_pseudonimo) DO NOTHING;

-- Inserción de datos desvinculados para análisis
INSERT INTO analisis_clientes_seudonimo (id_pseudonimo, segmento_tarjeta, fecha_registro, activo)
SELECT 
    t.id_pseudonimo,
    LEFT(c.tarjeta_credito, 4) AS segmento_tarjeta,
    c.fecha_registro,
    c.activo
FROM clientes c
JOIN token_mapeo_clientes t ON c.id = t.id_cliente_original
ON CONFLICT (id_pseudonimo) DO NOTHING;