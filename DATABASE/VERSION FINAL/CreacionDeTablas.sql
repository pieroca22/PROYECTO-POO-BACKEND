USE [master]
GO
/****** Object:  Database [MecafabFinal]    Script Date: 13/06/2025 01:55:56 ******/
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
/****** Object:  Table [dbo].[Cliente]    Script Date: 13/06/2025 01:55:56 ******/
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
/****** Object:  Table [dbo].[ComprobanteEntrega]    Script Date: 13/06/2025 01:55:56 ******/
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
/****** Object:  Table [dbo].[EstadoPedido]    Script Date: 13/06/2025 01:55:56 ******/
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
/****** Object:  Table [dbo].[HistorialEstadoPedido]    Script Date: 13/06/2025 01:55:56 ******/
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
/****** Object:  Table [dbo].[Pedido]    Script Date: 13/06/2025 01:55:56 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rol]    Script Date: 13/06/2025 01:55:56 ******/
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
/****** Object:  Table [dbo].[Usuario]    Script Date: 13/06/2025 01:55:56 ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[correo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
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
