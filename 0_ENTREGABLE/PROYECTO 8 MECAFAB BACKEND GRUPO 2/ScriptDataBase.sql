USE [master]
GO
/****** Object:  Database [MecafabFinal]    Script Date: 14/06/2025 06:45:24 ******/
CREATE DATABASE [MecafabFinal]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'MecafabFinal', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\MecafabFinal.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'MecafabFinal_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\MecafabFinal_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [MecafabFinal] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [MecafabFinal].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [MecafabFinal] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [MecafabFinal] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [MecafabFinal] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [MecafabFinal] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [MecafabFinal] SET ARITHABORT OFF 
GO
ALTER DATABASE [MecafabFinal] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [MecafabFinal] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [MecafabFinal] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [MecafabFinal] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [MecafabFinal] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [MecafabFinal] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [MecafabFinal] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [MecafabFinal] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [MecafabFinal] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [MecafabFinal] SET  ENABLE_BROKER 
GO
ALTER DATABASE [MecafabFinal] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [MecafabFinal] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [MecafabFinal] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [MecafabFinal] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [MecafabFinal] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [MecafabFinal] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [MecafabFinal] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [MecafabFinal] SET RECOVERY FULL 
GO
ALTER DATABASE [MecafabFinal] SET  MULTI_USER 
GO
ALTER DATABASE [MecafabFinal] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [MecafabFinal] SET DB_CHAINING OFF 
GO
ALTER DATABASE [MecafabFinal] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [MecafabFinal] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [MecafabFinal] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [MecafabFinal] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'MecafabFinal', N'ON'
GO
ALTER DATABASE [MecafabFinal] SET QUERY_STORE = ON
GO
ALTER DATABASE [MecafabFinal] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [MecafabFinal]
GO
/****** Object:  Table [dbo].[Cliente]    Script Date: 14/06/2025 06:45:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cliente](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre_razon_social] [varchar](150) NOT NULL,
	[documento] [varchar](20) NOT NULL,
	[telefono] [varchar](20) NULL,
	[correo] [varchar](100) NULL,
	[direccion] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ComprobanteEntrega]    Script Date: 14/06/2025 06:45:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ComprobanteEntrega](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[pedido_id] [int] NOT NULL,
	[fecha_generacion] [datetime] NOT NULL,
	[contenido] [text] NOT NULL,
	[tipo] [varchar](50) NOT NULL,
	[usuario_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EstadoPedido]    Script Date: 14/06/2025 06:45:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EstadoPedido](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
	[orden_logico] [int] NOT NULL,
	[es_final] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HistorialEstadoPedido]    Script Date: 14/06/2025 06:45:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistorialEstadoPedido](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[pedido_id] [int] NOT NULL,
	[estado_anterior_id] [int] NOT NULL,
	[estado_nuevo_id] [int] NOT NULL,
	[fecha_cambio] [datetime] NOT NULL,
	[usuario_id] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pedido]    Script Date: 14/06/2025 06:45:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pedido](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[codigo] [varchar](50) NULL,
	[descripcion_producto] [text] NOT NULL,
	[tipo_trabajo] [varchar](100) NOT NULL,
	[fecha_solicitud] [date] NOT NULL,
	[fecha_entrega_comprometida] [date] NOT NULL,
	[fecha_entrega_real] [date] NULL,
	[estado_id] [int] NOT NULL,
	[cliente_id] [int] NOT NULL,
	[operario_asignado_id] [int] NULL,
	[usuario_creador_id] [int] NOT NULL,
	[fecha_registro] [datetime] NULL,
	[es_entregado] [bit] NOT NULL,
	[fecha_entrega_confirmada] [date] NULL,
	[fecha_modificacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rol]    Script Date: 14/06/2025 06:45:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rol](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 14/06/2025 06:45:24 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[correo] [varchar](100) NOT NULL,
	[clave] [varchar](255) NOT NULL,
	[rol_id] [int] NOT NULL,
	[estado] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
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
SET IDENTITY_INSERT [dbo].[ComprobanteEntrega] ON 

INSERT [dbo].[ComprobanteEntrega] ([id], [pedido_id], [fecha_generacion], [contenido], [tipo], [usuario_id]) VALUES (1, 3, CAST(N'2025-06-13T00:53:51.690' AS DateTime), N'BASE64-COMPROBANTE-MOCK-ENTREGA', N'PDF', 1)
INSERT [dbo].[ComprobanteEntrega] ([id], [pedido_id], [fecha_generacion], [contenido], [tipo], [usuario_id]) VALUES (2, 11, CAST(N'2025-06-13T01:33:18.767' AS DateTime), N'COMPROBANTE-ENTREGA-PDF', N'PDF', 1)
INSERT [dbo].[ComprobanteEntrega] ([id], [pedido_id], [fecha_generacion], [contenido], [tipo], [usuario_id]) VALUES (3, 12, CAST(N'2025-06-13T01:39:58.173' AS DateTime), N'COMPROBANTE-ENTREGA-PDF', N'PDF', 1)
INSERT [dbo].[ComprobanteEntrega] ([id], [pedido_id], [fecha_generacion], [contenido], [tipo], [usuario_id]) VALUES (4, 1, CAST(N'2025-06-13T01:46:33.127' AS DateTime), N'COMPROBANTE-ENTREGA-PDF', N'PDF', 1)
INSERT [dbo].[ComprobanteEntrega] ([id], [pedido_id], [fecha_generacion], [contenido], [tipo], [usuario_id]) VALUES (5, 2, CAST(N'2025-06-13T01:47:51.233' AS DateTime), N'COMPROBANTE-ENTREGA-PDF', N'PDF', 1)
INSERT [dbo].[ComprobanteEntrega] ([id], [pedido_id], [fecha_generacion], [contenido], [tipo], [usuario_id]) VALUES (6, 10, CAST(N'2025-06-13T01:48:54.153' AS DateTime), N'COMPROBANTE-ENTREGA-PDF', N'PDF', 1)
INSERT [dbo].[ComprobanteEntrega] ([id], [pedido_id], [fecha_generacion], [contenido], [tipo], [usuario_id]) VALUES (7, 13, CAST(N'2025-06-13T07:15:52.907' AS DateTime), N'COMPROBANTE-ENTREGA-PDF', N'PDF', 1)
INSERT [dbo].[ComprobanteEntrega] ([id], [pedido_id], [fecha_generacion], [contenido], [tipo], [usuario_id]) VALUES (8, 14, CAST(N'2025-06-13T07:48:31.300' AS DateTime), N'COMPROBANTE-ENTREGA-PDF', N'PDF', 1)
SET IDENTITY_INSERT [dbo].[ComprobanteEntrega] OFF
GO
SET IDENTITY_INSERT [dbo].[EstadoPedido] ON 

INSERT [dbo].[EstadoPedido] ([id], [nombre], [orden_logico], [es_final]) VALUES (1, N'Registrado', 1, 0)
INSERT [dbo].[EstadoPedido] ([id], [nombre], [orden_logico], [es_final]) VALUES (2, N'En Producción', 2, 0)
INSERT [dbo].[EstadoPedido] ([id], [nombre], [orden_logico], [es_final]) VALUES (3, N'Listo para Entregar', 3, 0)
INSERT [dbo].[EstadoPedido] ([id], [nombre], [orden_logico], [es_final]) VALUES (4, N'Entregado', 4, 1)
INSERT [dbo].[EstadoPedido] ([id], [nombre], [orden_logico], [es_final]) VALUES (5, N'En espera', 5, 0)
SET IDENTITY_INSERT [dbo].[EstadoPedido] OFF
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
INSERT [dbo].[HistorialEstadoPedido] ([id], [pedido_id], [estado_anterior_id], [estado_nuevo_id], [fecha_cambio], [usuario_id]) VALUES (13, 13, 2, 3, CAST(N'2025-06-13T07:13:46.090' AS DateTime), 2)
INSERT [dbo].[HistorialEstadoPedido] ([id], [pedido_id], [estado_anterior_id], [estado_nuevo_id], [fecha_cambio], [usuario_id]) VALUES (14, 13, 4, 3, CAST(N'2025-06-13T07:20:19.890' AS DateTime), 2)
INSERT [dbo].[HistorialEstadoPedido] ([id], [pedido_id], [estado_anterior_id], [estado_nuevo_id], [fecha_cambio], [usuario_id]) VALUES (15, 13, 3, 4, CAST(N'2025-06-13T07:20:24.910' AS DateTime), 2)
INSERT [dbo].[HistorialEstadoPedido] ([id], [pedido_id], [estado_anterior_id], [estado_nuevo_id], [fecha_cambio], [usuario_id]) VALUES (16, 14, 2, 3, CAST(N'2025-06-13T07:46:44.010' AS DateTime), 3)
INSERT [dbo].[HistorialEstadoPedido] ([id], [pedido_id], [estado_anterior_id], [estado_nuevo_id], [fecha_cambio], [usuario_id]) VALUES (17, 15, 2, 3, CAST(N'2025-06-13T09:19:56.687' AS DateTime), 3)
SET IDENTITY_INSERT [dbo].[HistorialEstadoPedido] OFF
GO
SET IDENTITY_INSERT [dbo].[Pedido] ON 

INSERT [dbo].[Pedido] ([id], [codigo], [descripcion_producto], [tipo_trabajo], [fecha_solicitud], [fecha_entrega_comprometida], [fecha_entrega_real], [estado_id], [cliente_id], [operario_asignado_id], [usuario_creador_id], [fecha_registro], [es_entregado], [fecha_entrega_confirmada], [fecha_modificacion]) VALUES (1, N'PED-202306-001', N'Pieza metálica A', N'Torno CNC', CAST(N'2025-06-13' AS Date), CAST(N'2025-06-17' AS Date), CAST(N'2025-06-13' AS Date), 4, 1, 2, 1, CAST(N'2025-06-13T00:53:51.687' AS DateTime), 1, CAST(N'2025-06-13' AS Date), CAST(N'2025-06-13T01:46:33.120' AS DateTime))
INSERT [dbo].[Pedido] ([id], [codigo], [descripcion_producto], [tipo_trabajo], [fecha_solicitud], [fecha_entrega_comprometida], [fecha_entrega_real], [estado_id], [cliente_id], [operario_asignado_id], [usuario_creador_id], [fecha_registro], [es_entregado], [fecha_entrega_confirmada], [fecha_modificacion]) VALUES (2, N'PED-202306-002', N'Soporte estructural', N'Fresadora', CAST(N'2025-06-13' AS Date), CAST(N'2025-06-15' AS Date), CAST(N'2025-06-13' AS Date), 4, 2, 2, 1, CAST(N'2025-06-13T00:53:51.687' AS DateTime), 1, CAST(N'2025-06-13' AS Date), CAST(N'2025-06-13T01:47:51.227' AS DateTime))
INSERT [dbo].[Pedido] ([id], [codigo], [descripcion_producto], [tipo_trabajo], [fecha_solicitud], [fecha_entrega_comprometida], [fecha_entrega_real], [estado_id], [cliente_id], [operario_asignado_id], [usuario_creador_id], [fecha_registro], [es_entregado], [fecha_entrega_confirmada], [fecha_modificacion]) VALUES (3, N'PED-202306-003', N'Eje de acero', N'Corte láser', CAST(N'2025-06-13' AS Date), CAST(N'2025-06-12' AS Date), CAST(N'2025-06-13' AS Date), 4, 1, 2, 1, CAST(N'2025-06-13T00:53:51.687' AS DateTime), 1, CAST(N'2025-06-13' AS Date), CAST(N'2025-06-13T01:49:22.577' AS DateTime))
INSERT [dbo].[Pedido] ([id], [codigo], [descripcion_producto], [tipo_trabajo], [fecha_solicitud], [fecha_entrega_comprometida], [fecha_entrega_real], [estado_id], [cliente_id], [operario_asignado_id], [usuario_creador_id], [fecha_registro], [es_entregado], [fecha_entrega_confirmada], [fecha_modificacion]) VALUES (10, N'PED-202506-010', N'Base metalica 01', N'Fresado CNC 01', CAST(N'2025-06-11' AS Date), CAST(N'2025-06-15' AS Date), CAST(N'2025-06-13' AS Date), 4, 1, 2, 1, CAST(N'2025-06-13T01:01:19.150' AS DateTime), 1, CAST(N'2025-06-12' AS Date), CAST(N'2025-06-13T01:48:54.150' AS DateTime))
INSERT [dbo].[Pedido] ([id], [codigo], [descripcion_producto], [tipo_trabajo], [fecha_solicitud], [fecha_entrega_comprometida], [fecha_entrega_real], [estado_id], [cliente_id], [operario_asignado_id], [usuario_creador_id], [fecha_registro], [es_entregado], [fecha_entrega_confirmada], [fecha_modificacion]) VALUES (11, N'PED-202506-011', N'Base metalica 02', N'Fresado CNC 02', CAST(N'2025-06-11' AS Date), CAST(N'2025-06-15' AS Date), CAST(N'2025-06-13' AS Date), 4, 1, 3, 1, CAST(N'2025-06-13T01:03:56.247' AS DateTime), 1, CAST(N'2025-06-13' AS Date), CAST(N'2025-06-13T01:33:18.763' AS DateTime))
INSERT [dbo].[Pedido] ([id], [codigo], [descripcion_producto], [tipo_trabajo], [fecha_solicitud], [fecha_entrega_comprometida], [fecha_entrega_real], [estado_id], [cliente_id], [operario_asignado_id], [usuario_creador_id], [fecha_registro], [es_entregado], [fecha_entrega_confirmada], [fecha_modificacion]) VALUES (12, N'PED-202506-012', N'Base metalica 03', N'Fresado CNC 03', CAST(N'2025-06-11' AS Date), CAST(N'2025-06-15' AS Date), CAST(N'2025-06-13' AS Date), 4, 1, 3, 1, CAST(N'2025-06-13T01:19:50.350' AS DateTime), 1, CAST(N'2025-06-12' AS Date), CAST(N'2025-06-13T07:45:46.800' AS DateTime))
INSERT [dbo].[Pedido] ([id], [codigo], [descripcion_producto], [tipo_trabajo], [fecha_solicitud], [fecha_entrega_comprometida], [fecha_entrega_real], [estado_id], [cliente_id], [operario_asignado_id], [usuario_creador_id], [fecha_registro], [es_entregado], [fecha_entrega_confirmada], [fecha_modificacion]) VALUES (13, N'PED-202506-013', N'Base metalica 04', N'Fresado CNC 04', CAST(N'2025-06-12' AS Date), CAST(N'2025-06-19' AS Date), CAST(N'2025-06-13' AS Date), 4, 1, 2, 1, CAST(N'2025-06-13T07:11:32.810' AS DateTime), 1, CAST(N'2025-06-13' AS Date), CAST(N'2025-06-13T07:20:24.910' AS DateTime))
INSERT [dbo].[Pedido] ([id], [codigo], [descripcion_producto], [tipo_trabajo], [fecha_solicitud], [fecha_entrega_comprometida], [fecha_entrega_real], [estado_id], [cliente_id], [operario_asignado_id], [usuario_creador_id], [fecha_registro], [es_entregado], [fecha_entrega_confirmada], [fecha_modificacion]) VALUES (14, N'PED-202506-014', N'Base metálica', N'Fresado CNC', CAST(N'2025-06-10' AS Date), CAST(N'2025-06-14' AS Date), CAST(N'2025-06-13' AS Date), 4, 1, 3, 1, CAST(N'2025-06-13T07:39:27.957' AS DateTime), 1, CAST(N'2025-06-13' AS Date), CAST(N'2025-06-13T07:48:31.293' AS DateTime))
INSERT [dbo].[Pedido] ([id], [codigo], [descripcion_producto], [tipo_trabajo], [fecha_solicitud], [fecha_entrega_comprometida], [fecha_entrega_real], [estado_id], [cliente_id], [operario_asignado_id], [usuario_creador_id], [fecha_registro], [es_entregado], [fecha_entrega_confirmada], [fecha_modificacion]) VALUES (15, N'PED-202506-015', N'Placa base de aluminio', N'Fresado de contornos', CAST(N'2025-06-13' AS Date), CAST(N'2025-06-15' AS Date), NULL, 3, 7, 2, 1, CAST(N'2025-06-13T09:12:57.733' AS DateTime), 0, NULL, CAST(N'2025-06-13T09:19:56.683' AS DateTime))
SET IDENTITY_INSERT [dbo].[Pedido] OFF
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
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Pedido__40F9A20657F3F58E]    Script Date: 14/06/2025 06:45:24 ******/
ALTER TABLE [dbo].[Pedido] ADD UNIQUE NONCLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Usuario__2A586E0B81269B20]    Script Date: 14/06/2025 06:45:24 ******/
ALTER TABLE [dbo].[Usuario] ADD UNIQUE NONCLUSTERED 
(
	[correo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ComprobanteEntrega] ADD  DEFAULT (getdate()) FOR [fecha_generacion]
GO
ALTER TABLE [dbo].[HistorialEstadoPedido] ADD  DEFAULT (getdate()) FOR [fecha_cambio]
GO
ALTER TABLE [dbo].[Pedido] ADD  CONSTRAINT [DF_Pedido_Codigo]  DEFAULT ('') FOR [codigo]
GO
ALTER TABLE [dbo].[Pedido] ADD  DEFAULT (getdate()) FOR [fecha_registro]
GO
ALTER TABLE [dbo].[Pedido] ADD  DEFAULT ((0)) FOR [es_entregado]
GO
ALTER TABLE [dbo].[ComprobanteEntrega]  WITH CHECK ADD FOREIGN KEY([pedido_id])
REFERENCES [dbo].[Pedido] ([id])
GO
ALTER TABLE [dbo].[ComprobanteEntrega]  WITH CHECK ADD FOREIGN KEY([usuario_id])
REFERENCES [dbo].[Usuario] ([id])
GO
ALTER TABLE [dbo].[HistorialEstadoPedido]  WITH CHECK ADD FOREIGN KEY([estado_anterior_id])
REFERENCES [dbo].[EstadoPedido] ([id])
GO
ALTER TABLE [dbo].[HistorialEstadoPedido]  WITH CHECK ADD FOREIGN KEY([estado_nuevo_id])
REFERENCES [dbo].[EstadoPedido] ([id])
GO
ALTER TABLE [dbo].[HistorialEstadoPedido]  WITH CHECK ADD FOREIGN KEY([pedido_id])
REFERENCES [dbo].[Pedido] ([id])
GO
ALTER TABLE [dbo].[HistorialEstadoPedido]  WITH CHECK ADD FOREIGN KEY([usuario_id])
REFERENCES [dbo].[Usuario] ([id])
GO
ALTER TABLE [dbo].[Pedido]  WITH CHECK ADD FOREIGN KEY([cliente_id])
REFERENCES [dbo].[Cliente] ([id])
GO
ALTER TABLE [dbo].[Pedido]  WITH CHECK ADD FOREIGN KEY([estado_id])
REFERENCES [dbo].[EstadoPedido] ([id])
GO
ALTER TABLE [dbo].[Pedido]  WITH CHECK ADD FOREIGN KEY([operario_asignado_id])
REFERENCES [dbo].[Usuario] ([id])
GO
ALTER TABLE [dbo].[Pedido]  WITH CHECK ADD FOREIGN KEY([usuario_creador_id])
REFERENCES [dbo].[Usuario] ([id])
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD FOREIGN KEY([rol_id])
REFERENCES [dbo].[Rol] ([id])
GO
ALTER TABLE [dbo].[Pedido]  WITH CHECK ADD  CONSTRAINT [chk_fecha_confirmada] CHECK  (([fecha_entrega_confirmada] IS NULL OR [fecha_entrega_confirmada]>=[fecha_solicitud]))
GO
ALTER TABLE [dbo].[Pedido] CHECK CONSTRAINT [chk_fecha_confirmada]
GO
ALTER TABLE [dbo].[Pedido]  WITH CHECK ADD  CONSTRAINT [chk_fecha_entrega_real] CHECK  (([fecha_entrega_real] IS NULL OR [fecha_entrega_real]>=[fecha_solicitud]))
GO
ALTER TABLE [dbo].[Pedido] CHECK CONSTRAINT [chk_fecha_entrega_real]
GO
USE [master]
GO
ALTER DATABASE [MecafabFinal] SET  READ_WRITE 
GO
