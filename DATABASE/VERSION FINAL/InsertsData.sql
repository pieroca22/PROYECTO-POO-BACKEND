USE [MecafabFinal]
GO
SET IDENTITY_INSERT [dbo].[Rol] ON 

INSERT [dbo].[Rol] ([id], [nombre]) VALUES (1, N'Jefe')
INSERT [dbo].[Rol] ([id], [nombre]) VALUES (2, N'Operario')
SET IDENTITY_INSERT [dbo].[Rol] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuario] ON 

INSERT [dbo].[Usuario] ([id], [nombre], [correo], [clave], [rol_id], [estado]) VALUES (1, N'Jefe Maestro', N'jefe@uni.edu.pe', N'clave123', 1, 1)
INSERT [dbo].[Usuario] ([id], [nombre], [correo], [clave], [rol_id], [estado]) VALUES (2, N'Operario 1', N'op1@uni.edu.pe', N'clave123', 2, 1)
INSERT [dbo].[Usuario] ([id], [nombre], [correo], [clave], [rol_id], [estado]) VALUES (3, N'Operario 2', N'op2@uni.edu.pe', N'clave123', 2, 1)
SET IDENTITY_INSERT [dbo].[Usuario] OFF
GO
SET IDENTITY_INSERT [dbo].[Cliente] ON 

INSERT [dbo].[Cliente] ([id], [nombre_razon_social], [documento], [telefono], [correo], [direccion]) VALUES (1, N'Cliente Alpha S.A.', N'20511111111', N'987654321', N'alpha@cliente.com', N'Av. Lima 123')
INSERT [dbo].[Cliente] ([id], [nombre_razon_social], [documento], [telefono], [correo], [direccion]) VALUES (2, N'Cliente Beta SAC', N'20522222222', N'912345678', N'beta@cliente.com', N'Jr. Cusco 456')
INSERT [dbo].[Cliente] ([id], [nombre_razon_social], [documento], [telefono], [correo], [direccion]) VALUES (3, N'Juan Pérez García', N'12345678', N'912345678', N'juan.perez@example.com', N'Av. Arequipa 1234, Lima')
INSERT [dbo].[Cliente] ([id], [nombre_razon_social], [documento], [telefono], [correo], [direccion]) VALUES (4, N'María López Torres', N'87654321', N'919876543', N'maria.lopez@example.com', N'Jr. Cusco 567, Lima')
INSERT [dbo].[Cliente] ([id], [nombre_razon_social], [documento], [telefono], [correo], [direccion]) VALUES (5, N'Carlos Mendoza Ruiz', N'11223344', N'916789012', N'carlos.mendoza@example.com', N'Av. Grau 300, Lima')
INSERT [dbo].[Cliente] ([id], [nombre_razon_social], [documento], [telefono], [correo], [direccion]) VALUES (6, N'Ana Ramírez Díaz', N'44332211', N'917890123', N'ana.ramirez@example.com', N'Jr. Libertad 400, Lima')
INSERT [dbo].[Cliente] ([id], [nombre_razon_social], [documento], [telefono], [correo], [direccion]) VALUES (7, N'Luis Castillo Muñoz', N'55667788', N'920123456', N'luis.castillo@example.com', N'Calle Bolívar 700, Lima')
INSERT [dbo].[Cliente] ([id], [nombre_razon_social], [documento], [telefono], [correo], [direccion]) VALUES (8, N'Marina Torres Vilca', N'88776655', N'921234567', N'marina.torres@example.com', N'Jr. Tacna 800, Lima')
INSERT [dbo].[Cliente] ([id], [nombre_razon_social], [documento], [telefono], [correo], [direccion]) VALUES (9, N'Innova Tech SAC', N'20512345678', N'914567890', N'contacto@innovatech.com.pe', N'Calle Tecnología 100, Lima')
INSERT [dbo].[Cliente] ([id], [nombre_razon_social], [documento], [telefono], [correo], [direccion]) VALUES (10, N'Servicios Globales EIRL', N'20623456789', N'915678901', N'info@serviciosglobales.pe', N'Av. Comercio 200, Lima')
INSERT [dbo].[Cliente] ([id], [nombre_razon_social], [documento], [telefono], [correo], [direccion]) VALUES (11, N'Logística Plus SAC', N'20734567890', N'918901234', N'ventas@logisticaplus.pe', N'Av. Transporte 500, Lima')
INSERT [dbo].[Cliente] ([id], [nombre_razon_social], [documento], [telefono], [correo], [direccion]) VALUES (12, N'Constructora Delta SAC', N'20445678901', N'919012345', N'contacto@constructordelta.com.pe', N'Av. Construcción 600, Lima')
SET IDENTITY_INSERT [dbo].[Cliente] OFF
GO
SET IDENTITY_INSERT [dbo].[EstadoPedido] ON 

INSERT [dbo].[EstadoPedido] ([id], [nombre], [orden_logico], [es_final]) VALUES (1, N'Registrado', 1, 0)
INSERT [dbo].[EstadoPedido] ([id], [nombre], [orden_logico], [es_final]) VALUES (2, N'En Producción', 2, 0)
INSERT [dbo].[EstadoPedido] ([id], [nombre], [orden_logico], [es_final]) VALUES (3, N'Listo para Entregar', 3, 0)
INSERT [dbo].[EstadoPedido] ([id], [nombre], [orden_logico], [es_final]) VALUES (4, N'Entregado', 4, 1)
INSERT [dbo].[EstadoPedido] ([id], [nombre], [orden_logico], [es_final]) VALUES (5, N'En espera', 5, 0)
SET IDENTITY_INSERT [dbo].[EstadoPedido] OFF
GO
SET IDENTITY_INSERT [dbo].[Pedido] ON 

INSERT [dbo].[Pedido] ([id], [codigo], [descripcion_producto], [tipo_trabajo], [fecha_solicitud], [fecha_entrega_comprometida], [fecha_entrega_real], [estado_id], [cliente_id], [operario_asignado_id], [usuario_creador_id], [fecha_registro], [es_entregado], [fecha_entrega_confirmada], [fecha_modificacion]) VALUES (1, N'PED-202306-001', N'Pieza metálica A', N'Torno CNC', CAST(N'2025-06-13' AS Date), CAST(N'2025-06-17' AS Date), CAST(N'2025-06-13' AS Date), 4, 1, 2, 1, CAST(N'2025-06-13T00:53:51.687' AS DateTime), 1, CAST(N'2025-06-13' AS Date), CAST(N'2025-06-13T01:46:33.120' AS DateTime))
INSERT [dbo].[Pedido] ([id], [codigo], [descripcion_producto], [tipo_trabajo], [fecha_solicitud], [fecha_entrega_comprometida], [fecha_entrega_real], [estado_id], [cliente_id], [operario_asignado_id], [usuario_creador_id], [fecha_registro], [es_entregado], [fecha_entrega_confirmada], [fecha_modificacion]) VALUES (2, N'PED-202306-002', N'Soporte estructural', N'Fresadora', CAST(N'2025-06-13' AS Date), CAST(N'2025-06-15' AS Date), CAST(N'2025-06-13' AS Date), 4, 2, 2, 1, CAST(N'2025-06-13T00:53:51.687' AS DateTime), 1, CAST(N'2025-06-13' AS Date), CAST(N'2025-06-13T01:47:51.227' AS DateTime))
INSERT [dbo].[Pedido] ([id], [codigo], [descripcion_producto], [tipo_trabajo], [fecha_solicitud], [fecha_entrega_comprometida], [fecha_entrega_real], [estado_id], [cliente_id], [operario_asignado_id], [usuario_creador_id], [fecha_registro], [es_entregado], [fecha_entrega_confirmada], [fecha_modificacion]) VALUES (3, N'PED-202306-003', N'Eje de acero', N'Corte láser', CAST(N'2025-06-13' AS Date), CAST(N'2025-06-12' AS Date), CAST(N'2025-06-13' AS Date), 4, 1, 2, 1, CAST(N'2025-06-13T00:53:51.687' AS DateTime), 1, CAST(N'2025-06-13' AS Date), CAST(N'2025-06-13T01:49:22.577' AS DateTime))
INSERT [dbo].[Pedido] ([id], [codigo], [descripcion_producto], [tipo_trabajo], [fecha_solicitud], [fecha_entrega_comprometida], [fecha_entrega_real], [estado_id], [cliente_id], [operario_asignado_id], [usuario_creador_id], [fecha_registro], [es_entregado], [fecha_entrega_confirmada], [fecha_modificacion]) VALUES (10, N'PED-202506-010', N'Base metalica 01', N'Fresado CNC 01', CAST(N'2025-06-11' AS Date), CAST(N'2025-06-15' AS Date), CAST(N'2025-06-13' AS Date), 4, 1, 2, 1, CAST(N'2025-06-13T01:01:19.150' AS DateTime), 1, CAST(N'2025-06-12' AS Date), CAST(N'2025-06-13T01:48:54.150' AS DateTime))
INSERT [dbo].[Pedido] ([id], [codigo], [descripcion_producto], [tipo_trabajo], [fecha_solicitud], [fecha_entrega_comprometida], [fecha_entrega_real], [estado_id], [cliente_id], [operario_asignado_id], [usuario_creador_id], [fecha_registro], [es_entregado], [fecha_entrega_confirmada], [fecha_modificacion]) VALUES (11, N'PED-202506-011', N'Base metalica 02', N'Fresado CNC 02', CAST(N'2025-06-11' AS Date), CAST(N'2025-06-15' AS Date), CAST(N'2025-06-13' AS Date), 4, 1, 3, 1, CAST(N'2025-06-13T01:03:56.247' AS DateTime), 1, CAST(N'2025-06-13' AS Date), CAST(N'2025-06-13T01:33:18.763' AS DateTime))
INSERT [dbo].[Pedido] ([id], [codigo], [descripcion_producto], [tipo_trabajo], [fecha_solicitud], [fecha_entrega_comprometida], [fecha_entrega_real], [estado_id], [cliente_id], [operario_asignado_id], [usuario_creador_id], [fecha_registro], [es_entregado], [fecha_entrega_confirmada], [fecha_modificacion]) VALUES (12, N'PED-202506-012', N'Base metalica 03', N'Fresado CNC 03', CAST(N'2025-06-11' AS Date), CAST(N'2025-06-15' AS Date), CAST(N'2025-06-13' AS Date), 2, 1, 2, 1, CAST(N'2025-06-13T01:19:50.350' AS DateTime), 1, CAST(N'2025-06-12' AS Date), CAST(N'2025-06-13T01:48:23.750' AS DateTime))
SET IDENTITY_INSERT [dbo].[Pedido] OFF
GO
SET IDENTITY_INSERT [dbo].[HistorialEstadoPedido] ON 

INSERT [dbo].[HistorialEstadoPedido] ([id], [pedido_id], [estado_anterior_id], [estado_nuevo_id], [fecha_cambio], [usuario_id]) VALUES (1, 2, 1, 2, CAST(N'2025-06-13T00:53:51.690' AS DateTime), 1)
INSERT [dbo].[HistorialEstadoPedido] ([id], [pedido_id], [estado_anterior_id], [estado_nuevo_id], [fecha_cambio], [usuario_id]) VALUES (2, 3, 1, 2, CAST(N'2025-06-10T00:53:51.690' AS DateTime), 1)
INSERT [dbo].[HistorialEstadoPedido] ([id], [pedido_id], [estado_anterior_id], [estado_nuevo_id], [fecha_cambio], [usuario_id]) VALUES (3, 3, 2, 3, CAST(N'2025-06-11T00:53:51.690' AS DateTime), 1)
INSERT [dbo].[HistorialEstadoPedido] ([id], [pedido_id], [estado_anterior_id], [estado_nuevo_id], [fecha_cambio], [usuario_id]) VALUES (4, 3, 3, 4, CAST(N'2025-06-12T00:53:51.690' AS DateTime), 1)
INSERT [dbo].[HistorialEstadoPedido] ([id], [pedido_id], [estado_anterior_id], [estado_nuevo_id], [fecha_cambio], [usuario_id]) VALUES (5, 1, 1, 2, CAST(N'2025-06-13T01:17:49.223' AS DateTime), 1)
INSERT [dbo].[HistorialEstadoPedido] ([id], [pedido_id], [estado_anterior_id], [estado_nuevo_id], [fecha_cambio], [usuario_id]) VALUES (6, 1, 2, 5, CAST(N'2025-06-13T01:36:49.933' AS DateTime), 1)
INSERT [dbo].[HistorialEstadoPedido] ([id], [pedido_id], [estado_anterior_id], [estado_nuevo_id], [fecha_cambio], [usuario_id]) VALUES (7, 1, 5, 4, CAST(N'2025-06-13T01:36:54.380' AS DateTime), 1)
INSERT [dbo].[HistorialEstadoPedido] ([id], [pedido_id], [estado_anterior_id], [estado_nuevo_id], [fecha_cambio], [usuario_id]) VALUES (8, 1, 4, 5, CAST(N'2025-06-13T01:36:58.017' AS DateTime), 1)
INSERT [dbo].[HistorialEstadoPedido] ([id], [pedido_id], [estado_anterior_id], [estado_nuevo_id], [fecha_cambio], [usuario_id]) VALUES (9, 1, 5, 4, CAST(N'2025-06-13T01:37:03.023' AS DateTime), 1)
INSERT [dbo].[HistorialEstadoPedido] ([id], [pedido_id], [estado_anterior_id], [estado_nuevo_id], [fecha_cambio], [usuario_id]) VALUES (10, 1, 4, 5, CAST(N'2025-06-13T01:37:16.437' AS DateTime), 1)
INSERT [dbo].[HistorialEstadoPedido] ([id], [pedido_id], [estado_anterior_id], [estado_nuevo_id], [fecha_cambio], [usuario_id]) VALUES (11, 3, 4, 2, CAST(N'2025-06-13T01:49:19.230' AS DateTime), 1)
INSERT [dbo].[HistorialEstadoPedido] ([id], [pedido_id], [estado_anterior_id], [estado_nuevo_id], [fecha_cambio], [usuario_id]) VALUES (12, 3, 2, 4, CAST(N'2025-06-13T01:49:22.580' AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[HistorialEstadoPedido] OFF
GO
SET IDENTITY_INSERT [dbo].[ComprobanteEntrega] ON 

INSERT [dbo].[ComprobanteEntrega] ([id], [pedido_id], [fecha_generacion], [contenido], [tipo], [usuario_id]) VALUES (1, 3, CAST(N'2025-06-13T00:53:51.690' AS DateTime), N'BASE64-COMPROBANTE-MOCK-ENTREGA', N'PDF', 1)
INSERT [dbo].[ComprobanteEntrega] ([id], [pedido_id], [fecha_generacion], [contenido], [tipo], [usuario_id]) VALUES (2, 11, CAST(N'2025-06-13T01:33:18.767' AS DateTime), N'COMPROBANTE-ENTREGA-PDF', N'PDF', 1)
INSERT [dbo].[ComprobanteEntrega] ([id], [pedido_id], [fecha_generacion], [contenido], [tipo], [usuario_id]) VALUES (3, 12, CAST(N'2025-06-13T01:39:58.173' AS DateTime), N'COMPROBANTE-ENTREGA-PDF', N'PDF', 1)
INSERT [dbo].[ComprobanteEntrega] ([id], [pedido_id], [fecha_generacion], [contenido], [tipo], [usuario_id]) VALUES (4, 1, CAST(N'2025-06-13T01:46:33.127' AS DateTime), N'COMPROBANTE-ENTREGA-PDF', N'PDF', 1)
INSERT [dbo].[ComprobanteEntrega] ([id], [pedido_id], [fecha_generacion], [contenido], [tipo], [usuario_id]) VALUES (5, 2, CAST(N'2025-06-13T01:47:51.233' AS DateTime), N'COMPROBANTE-ENTREGA-PDF', N'PDF', 1)
INSERT [dbo].[ComprobanteEntrega] ([id], [pedido_id], [fecha_generacion], [contenido], [tipo], [usuario_id]) VALUES (6, 10, CAST(N'2025-06-13T01:48:54.153' AS DateTime), N'COMPROBANTE-ENTREGA-PDF', N'PDF', 1)
SET IDENTITY_INSERT [dbo].[ComprobanteEntrega] OFF
GO
