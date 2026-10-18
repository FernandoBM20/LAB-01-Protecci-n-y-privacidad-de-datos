-- 02-enmascaramiento.sql
-- Implementación de enmascaramiento dinámico mediante vistas para proteger PII

CREATE OR REPLACE VIEW vw_clientes_enmascarados AS
SELECT 
    id,
    SUBSTRING(nombre FROM 1 FOR 1) || '***' AS nombre,
    SUBSTRING(email FROM 1 FOR 1) || '***@***.com' AS email,
    '******' || RIGHT(telefono, 4) AS telefono,
    '****-****-****-' || RIGHT(tarjeta_credito, 4) AS tarjeta_credito,
    fecha_registro,
    activo
FROM clientes;