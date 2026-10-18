-- 01-clasificacion.sql
-- Creación de la tabla base e identificación de datos sensibles (PII y PCI-DSS)

CREATE TABLE IF NOT EXISTS clientes (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefono VARCHAR(20),
    tarjeta_credito VARCHAR(20),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE
);

-- Documentación de metadatos para clasificación de datos
COMMENT ON COLUMN clientes.nombre IS 'Dato Sensible - Identificativo PII';
COMMENT ON COLUMN clientes.email IS 'Dato Sensible - Contacto PII';
COMMENT ON COLUMN clientes.telefono IS 'Dato Sensible - Contacto';
COMMENT ON COLUMN clientes.tarjeta_credito IS 'Dato Altamente Sensible - Financiero PCI-DSS';

-- Inserción de datos de prueba
INSERT INTO clientes (nombre, email, telefono, tarjeta_credito, fecha_registro, activo) VALUES
('Juan Pérez', 'juan.perez@email.com', '555-1234', '4532-1111-2222-3333', '2023-01-15 10:00:00', TRUE),
('María Gómez', 'maria.gomez@email.com', '555-5678', '4532-4444-5555-6666', '2020-05-20 12:30:00', FALSE),
('Carlos López', 'carlos.lopez@email.com', '555-9012', '5412-7777-8888-9999', '2024-02-10 09:15:00', TRUE),
('Ana Torres', 'ana.torres@email.com', '555-3456', '3782-0000-1111-2222', '2018-11-05 14:20:00', FALSE),
('Luis Ramírez', 'luis.ramirez@email.com', '555-7890', '4532-3333-4444-5555', '2025-01-01 08:00:00', TRUE);