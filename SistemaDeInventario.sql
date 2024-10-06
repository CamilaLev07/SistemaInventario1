CREATE DATABASE SistemaStockMonarcaMarket2;
USE SistemaStockMonarcaMarket2;

-- Creación de tablas

CREATE TABLE Rol (
    ID_rol INT PRIMARY KEY,
    nombre VARCHAR(90),
    descripcion VARCHAR(90)
);

CREATE TABLE Categoria (
    ID_categoria INT PRIMARY KEY,
    nombre VARCHAR(90),
    descripcion TEXT
);

CREATE TABLE Producto (
    ID_producto INT PRIMARY KEY,
    nombre VARCHAR(90),
    descripcion VARCHAR(255),
    precio DECIMAL(10, 2),
    stock INT,
    ID_categoria INT,
    FOREIGN KEY (ID_categoria) REFERENCES Categoria(ID_categoria)
);

CREATE TABLE Inventario (
    ID_inventario INT PRIMARY KEY,
    ID_producto INT,
    FOREIGN KEY (ID_producto) REFERENCES Producto(ID_producto)
);

CREATE TABLE Orden_de_Compra (
    ID_porden INT PRIMARY KEY,
    fecha DATE,
    total INT,
    ID_producto INT,
    FOREIGN KEY (ID_producto) REFERENCES Producto(ID_producto)
);

CREATE TABLE Venta (
    ID_venta INT PRIMARY KEY,
    fecha DATE,
    detalle_Venta VARCHAR(90),
    total INT,
    ID_producto INT,
    FOREIGN KEY (ID_producto) REFERENCES Producto(ID_producto)
);

CREATE TABLE Cliente (
    DNI INT PRIMARY KEY,
    nombre VARCHAR(90),
    contacto VARCHAR(90)
);

CREATE TABLE Devolucion (
    ID_devolucion INT PRIMARY KEY,
    fecha DATE,
    motivo VARCHAR(255),
    ID_producto INT,
    ID_cliente INT,
    FOREIGN KEY (ID_producto) REFERENCES Producto(ID_producto),
    FOREIGN KEY (ID_cliente) REFERENCES Cliente(DNI)
);

CREATE TABLE Proveedor (
    ID_proveedor INT PRIMARY KEY,
    nombre VARCHAR(90),
    contacto VARCHAR(90),
    ID_producto INT,
    FOREIGN KEY (ID_producto) REFERENCES Producto(ID_producto)
);

CREATE TABLE Usuario (
    ID_usuario INT PRIMARY KEY,
    nombre VARCHAR(90),
    apellido VARCHAR(90),
    email VARCHAR(90),
    contraseña VARCHAR(90),
    ID_rol INT,
    FOREIGN KEY (ID_rol) REFERENCES Rol(ID_rol)
);

CREATE TABLE Historial (
    ID_historial INT PRIMARY KEY,
    usuario INT,
    ID_producto INT,
    cantidad INT,
    fecha DATE,
    FOREIGN KEY (usuario) REFERENCES Usuario(ID_usuario),
    FOREIGN KEY (ID_producto) REFERENCES Producto(ID_producto)
);

-- Inserción de datos

-- Insertar datos en Rol
INSERT INTO Rol (ID_rol, nombre, descripcion) VALUES (1, 'Administrador', 'Rol de administrador en el sistema');

-- Insertar datos en Categoria
INSERT INTO Categoria (ID_categoria, nombre, descripcion) VALUES (1, 'Alimentos', 'Productos alimenticios');

-- Insertar datos en Producto
INSERT INTO Producto (ID_producto, nombre, descripcion, precio, stock, ID_categoria) 
VALUES (1, 'Yogur', 'Frutilla', 50.50, 100, 1);

-- Insertar datos en Inventario
INSERT INTO Inventario (ID_inventario, ID_producto) VALUES (1, 1);

-- Insertar datos en Orden_de_Compra
INSERT INTO Orden_de_Compra (ID_porden, fecha, total, ID_producto) 
VALUES (1, '2024-10-03', 500, 1);

-- Insertar datos en Venta
INSERT INTO Venta (ID_venta, fecha, detalle_Venta, total, ID_producto) 
VALUES (1, '2024-10-03', 'Compra de yogur', 150, 1);

-- Insertar datos en Cliente
INSERT INTO Cliente (DNI, nombre, contacto) VALUES (1, 'Cliente 1', 'camila@gmail.com');

-- Insertar datos en Devolucion
INSERT INTO Devolucion (ID_devolucion, fecha, motivo, ID_producto, ID_cliente) 
VALUES (1, '2024-10-05', 'Producto dañado', 1, 1);

-- Insertar datos en Proveedor
INSERT INTO Proveedor (ID_proveedor, nombre, contacto, ID_producto) 
VALUES (1, 'Proveedor 1', 'jorge@gmail.com', 1);

-- Insertar datos en Usuario
INSERT INTO Usuario (ID_usuario, nombre, apellido, email, contraseña, ID_rol) 
VALUES (1, 'Admin', 'Admin', 'admin@gmail.com', '554321', 1);

-- Insertar datos en Historial
INSERT INTO Historial (ID_historial, usuario, ID_producto, cantidad, fecha) 
VALUES (1, 1, 1, 10, '2024-10-04');

-- Consultas de datos

-- Consultar productos
SELECT * FROM Producto;

-- Consultar ventas y productos vendidos
SELECT Venta.ID_venta, Producto.nombre, Venta.total 
FROM Venta 
JOIN Producto ON Venta.ID_producto = Producto.ID_producto;

-- Consultar el historial de un usuario
SELECT Usuario.nombre, Historial.cantidad, Producto.nombre AS Producto, Historial.fecha 
FROM Historial 
JOIN Usuario ON Historial.usuario = Usuario.ID_usuario 
JOIN Producto ON Historial.ID_producto = Producto.ID_producto 
WHERE Usuario.ID_usuario = 1;

-- Borrado de registros

-- Eliminar registros de devoluciones que dependen del producto
DELETE FROM Devolucion WHERE ID_producto = 1;

-- Eliminar registros de órdenes de compra que dependen del producto
DELETE FROM Orden_de_Compra WHERE ID_producto = 1;

-- Eliminar registros de ventas que dependen del producto
DELETE FROM Venta WHERE ID_producto = 1;

-- Eliminar registros de historial que dependen del producto
DELETE FROM Historial WHERE ID_producto = 1;

-- Eliminar registros de inventario que dependen del producto
DELETE FROM Inventario WHERE ID_producto = 1;

-- Eliminar registros de proveedor que dependen del producto
DELETE FROM Proveedor WHERE ID_producto = 1;

-- Eliminar el producto
DELETE FROM Producto WHERE ID_producto = 1;
