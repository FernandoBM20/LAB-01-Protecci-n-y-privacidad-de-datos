-- 05-retencion.sql
-- Política de conservación, archivo y purga de datos inactivos conforme a normativas

CREATE TABLE IF NOT EXISTS clientes_historico_archivado (
    LIKE clientes INCLUDING ALL
);

-- Archivar registros inactivos con más de 5 años de antigüedad
INSERT INTO clientes_historico_archivado
SELECT * FROM clientes
WHERE activo = FALSE 
  AND fecha_registro < NOW() - INTERVAL '5 years'
ON CONFLICT DO NOTHING;

-- Eliminar referencias en la tabla de tokens
DELETE FROM token_mapeo_clientes
WHERE id_cliente_original IN (
    SELECT id FROM clientes 
    WHERE activo = FALSE 
      AND fecha_registro < NOW() - INTERVAL '5 years'
);

-- Purgar de la tabla principal de clientes
DELETE FROM clientes
WHERE activo = FALSE 
  AND fecha_registro < NOW() - INTERVAL '5 years';