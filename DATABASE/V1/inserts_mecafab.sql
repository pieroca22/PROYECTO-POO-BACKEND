USE MecafabFinal;

-- Insertar roles
INSERT INTO Rol (nombre) VALUES ('Jefe'), ('Operario');

-- Insertar usuarios (1 jefe, 2 operarios)
INSERT INTO Usuario (nombre, correo, clave, rol_id, estado) VALUES
('Jefe Maestro', 'jefe@uni.edu.pe', 'clave123', 1, 1),
('Operario 1', 'op1@uni.edu.pe', 'clave123', 2, 1),
('Operario 2', 'op2@uni.edu.pe', 'clave123', 2, 1);

-- Insertar clientes
INSERT INTO Cliente (nombre_razon_social, documento, telefono, correo, direccion) VALUES
('Cliente Alpha S.A.', '20511111111', '987654321', 'alpha@cliente.com', 'Av. Lima 123'),
('Cliente Beta SAC', '20522222222', '912345678', 'beta@cliente.com', 'Jr. Cusco 456');

-- Insertar estados
INSERT INTO EstadoPedido (nombre, orden_logico, es_final) VALUES
('Registrado', 1, 0),
('En Producción', 2, 0),
('Listo para Entregar', 3, 0),
('Entregado', 4, 1),
('En espera', 5, 0);

-- Insertar pedidos
INSERT INTO Pedido (codigo, descripcion_producto, tipo_trabajo, fecha_solicitud, fecha_entrega_comprometida, estado_id,
cliente_id, operario_asignado_id, usuario_creador_id, fecha_registro, es_entregado, fecha_entrega_confirmada, fecha_entrega_real)
VALUES
-- Pedido sin operario ni entrega aún (para probar registro y asignación)
('PED-202306-001', 'Pieza metálica A', 'Torno CNC', GETDATE(), DATEADD(DAY, 4, GETDATE()), 1, 1, NULL, 1, GETDATE(), 0, NULL, NULL),
-- Pedido asignado a operario y en producción (para probar cambio de estado)
('PED-202306-002', 'Soporte estructural', 'Fresadora', GETDATE(), DATEADD(DAY, 2, GETDATE()), 2, 2, 2, 1, GETDATE(), 0, NULL, NULL),
-- Pedido ya entregado (para probar filtros y comprobante)
('PED-202306-003', 'Eje de acero', 'Corte láser', GETDATE(), DATEADD(DAY, -1, GETDATE()), 4, 1, 2, 1, GETDATE(), 1, GETDATE(), GETDATE());

-- Insertar historial de cambios para pedidos
INSERT INTO HistorialEstadoPedido (pedido_id, estado_anterior_id, estado_nuevo_id, usuario_id, fecha_cambio)
VALUES
-- Pedido 2: registrado -> producción
(2, 1, 2, 1, GETDATE()),
-- Pedido 3: registrado -> producción -> listo -> entregado
(3, 1, 2, 1, DATEADD(DAY, -3, GETDATE())),
(3, 2, 3, 1, DATEADD(DAY, -2, GETDATE())),
(3, 3, 4, 1, DATEADD(DAY, -1, GETDATE()));

-- Insertar comprobante de entrega
INSERT INTO ComprobanteEntrega (pedido_id, contenido, tipo, usuario_id, fecha_generacion)
VALUES
(3, 'BASE64-COMPROBANTE-MOCK-ENTREGA', 'PDF', 1, GETDATE());
