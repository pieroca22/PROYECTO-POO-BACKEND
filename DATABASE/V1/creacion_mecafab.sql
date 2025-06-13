CREATE DATABASE MecafabFinal;
USE MecafabFinal;

CREATE TABLE Rol (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE Usuario (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    clave VARCHAR(255) NOT NULL,
    rol_id INT NOT NULL,
    estado BIT NOT NULL,
    FOREIGN KEY (rol_id) REFERENCES Rol(id)
);

CREATE TABLE Cliente (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre_razon_social VARCHAR(150) NOT NULL,
    documento VARCHAR(20) NOT NULL,
    telefono VARCHAR(20),
    correo VARCHAR(100),
    direccion VARCHAR(255)
);

CREATE TABLE EstadoPedido (
    id INT PRIMARY KEY IDENTITY(1,1),
    nombre VARCHAR(50) NOT NULL,
    orden_logico INT NOT NULL,
    es_final BIT NOT NULL
);

CREATE TABLE Pedido (
    id INT PRIMARY KEY IDENTITY(1,1),
    codigo VARCHAR(50) UNIQUE NOT NULL,
    descripcion_producto TEXT NOT NULL,
    tipo_trabajo VARCHAR(100) NOT NULL,
    fecha_solicitud DATE NOT NULL,
    fecha_entrega_comprometida DATE NOT NULL,
    fecha_entrega_real DATE,
    estado_id INT NOT NULL,
    cliente_id INT NOT NULL,
    operario_asignado_id INT,
    usuario_creador_id INT NOT NULL,
    fecha_registro DATETIME DEFAULT GETDATE(),
    es_entregado BIT NOT NULL DEFAULT 0,
    fecha_entrega_confirmada DATE,
	fecha_modificacion DATETIME,
    FOREIGN KEY (estado_id) REFERENCES EstadoPedido(id),
    FOREIGN KEY (cliente_id) REFERENCES Cliente(id),
    FOREIGN KEY (operario_asignado_id) REFERENCES Usuario(id),
    FOREIGN KEY (usuario_creador_id) REFERENCES Usuario(id)
);

CREATE TABLE HistorialEstadoPedido (
    id INT PRIMARY KEY IDENTITY(1,1),
    pedido_id INT NOT NULL,
    estado_anterior_id INT NOT NULL,
    estado_nuevo_id INT NOT NULL,
    fecha_cambio DATETIME NOT NULL DEFAULT GETDATE(),
    usuario_id INT NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES Pedido(id),
    FOREIGN KEY (estado_anterior_id) REFERENCES EstadoPedido(id),
    FOREIGN KEY (estado_nuevo_id) REFERENCES EstadoPedido(id),
    FOREIGN KEY (usuario_id) REFERENCES Usuario(id)
);

CREATE TABLE ComprobanteEntrega (
    id INT PRIMARY KEY IDENTITY(1,1),
    pedido_id INT NOT NULL,
    fecha_generacion DATETIME NOT NULL DEFAULT GETDATE(),
    contenido TEXT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    usuario_id INT NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES Pedido(id),
    FOREIGN KEY (usuario_id) REFERENCES Usuario(id)
);

-- Validaciones CHECK para fechas lógicas
ALTER TABLE Pedido
ADD CONSTRAINT chk_fecha_entrega_real CHECK (
    fecha_entrega_real IS NULL OR fecha_entrega_real >= fecha_solicitud
);

ALTER TABLE Pedido
ADD CONSTRAINT chk_fecha_confirmada CHECK (
    fecha_entrega_confirmada IS NULL OR fecha_entrega_confirmada >= fecha_solicitud
);