-- Inserts para la tabla departamentos
INSERT INTO departamentos (nombre) VALUES
('Ventas'),
('Recursos Humanos'),
('Tecnología'),
('Finanzas'),
('Marketing'),
('Logística'),
('Compras'),
('Producción'),
('Servicio al Cliente'),
('Calidad');

-- Inserts para la tabla empleados
INSERT INTO empleados (nombre, fecha_contratacion, rol, id_departamento) VALUES
('Ana Pérez', '2023-01-15', 'Gerente de Ventas', 1),
('Carlos Gómez', '2022-11-23', 'Analista de Recursos Humanos', 2),
('Luis Fernández', '2024-02-05', 'Desarrollador de Software', 3),
('María Rodríguez', '2021-06-10', 'Contador', 4),
('Laura Martínez', '2024-03-20', 'Especialista en Marketing', 5),
('Javier López', '2022-08-01', 'Coordinador de Logística', 6),
('Sofía Vargas', '2023-07-12', 'Comprador Senior', 7),
('Gabriel Morales', '2024-05-25', 'Supervisor de Producción', 8),
('Paola Martínez', '2021-11-15', 'Asistente de Servicio al Cliente', 9),
('Daniela Ruiz', '2022-10-10', 'Inspector de Calidad', 10);

-- Inserts para la tabla proveedores_piezas
INSERT INTO proveedores_piezas (nombre_proveedor, telefono_proveedor, email_proveedor) VALUES
('Proveedores S.A.', '123456789', 'contacto@proveedoressa.com'),
('Piezas y Más', '987654321', 'info@piezasymas.com'),
('AutoRepuestos', '555123456', 'ventas@autorepuestos.com'),
('Recambios del Automóvil', '555987654', 'recambios@automovil.com'),
('Parts4Cars', '555246810', 'support@parts4cars.com'),
('Autoservicio Express', '555789123', 'servicio@autoservicioexpress.com'),
('Repuestos Globales', '555456789', 'contacto@repuestosglobales.com'),
('Vehículos y Accesorios', '555321654', 'info@vehiculosyaccesorios.com'),
('Recambios y Repuestos', '555654987', 'ventas@recambiosyrepuestos.com'),
('Proveedor Automotriz', '555852963', 'contacto@proveedora.com');

-- Inserts para la tabla vehiculos
INSERT INTO vehiculos (marca, modelo, año, precio, estado, id_proveedor_pieza) VALUES
('Toyota', 'Corolla', 2023, 20000.00, 'Nuevo', 1),
('Honda', 'Civic', 2022, 22000.00, 'Nuevo', 2),
('Ford', 'Focus', 2021, 18000.00, 'Usado', 3),
('Chevrolet', 'Cruze', 2020, 17000.00, 'Usado', 4),
('Hyundai', 'Elantra', 2024, 21000.00, 'Nuevo', 5),
('Nissan', 'Altima', 2021, 19000.00, 'Usado', 6),
('Mazda', '3', 2022, 20000.00, 'Nuevo', 7),
('Kia', 'Forte', 2023, 20500.00, 'Nuevo', 8),
('Subaru', 'Impreza', 2021, 18500.00, 'Usado', 9),
('Volkswagen', 'Jetta', 2022, 21500.00, 'Nuevo', 10);

-- Inserts para la tabla clientes
INSERT INTO clientes (nombre, telefono, email, direccion, es_potencial) VALUES
('Juan Pérez', '3001234567', 'juan.perez@email.com', 'Calle 123, Bogotá', FALSE),
('María López', '3002345678', 'maria.lopez@email.com', 'Avenida 456, Medellín', TRUE),
('Pedro Rodríguez', '3003456789', 'pedro.rodriguez@email.com', 'Carrera 789, Cali', FALSE),
('Ana Gómez', '3004567890', 'ana.gomez@email.com', 'Transversal 101, Barranquilla', TRUE),
('Carlos Martínez', '3005678901', 'carlos.martinez@email.com', 'Diagonal 202, Cartagena', FALSE),
('Laura Sánchez', '3006789012', 'laura.sanchez@email.com', 'Avenida 303, Bucaramanga', TRUE),
('Andrés Díaz', '3007890123', 'andres.diaz@email.com', 'Calle 404, Pereira', FALSE),
('Isabel Torres', '3008901234', 'isabel.torres@email.com', 'Calle 505, Manizales', TRUE),
('Ricardo Castro', '3009012345', 'ricardo.castro@email.com', 'Calle 606, Cúcuta', FALSE),
('Valeria Silva', '3000123456', 'valeria.silva@email.com', 'Carrera 707, Pasto', TRUE);

-- Inserts para la tabla ventas
INSERT INTO ventas (id_vehiculo, id_cliente, fecha_venta, precio_final, id_empleado) VALUES
(1, 1, '2024-01-15', 20000.00, 1),
(2, 2, '2024-02-20', 18000.00, 2),
(3, 3, '2024-03-10', 25000.00, 3),
(4, 4, '2024-04-05', 22000.00, 4),
(5, 5, '2024-05-15', 24000.00, 5),
(6, 6, '2024-06-25', 21000.00, 6),
(7, 7, '2024-07-30', 19000.00, 7),
(8, 8, '2024-08-12', 23000.00, 8),
(9, 9, '2024-09-05', 26000.00, 9),
(10, 10, '2024-10-15', 25000.00, 10);

-- Inserts para la tabla servicios
INSERT INTO servicios (id_vehiculo, id_empleado, fecha_servicio, descripcion, costo) VALUES
(1, 1, '2024-02-01', 'Cambio de aceite y filtros', 150.00),
(2, 2, '2024-03-15', 'Revisión de frenos', 200.00),
(3, 3, '2024-04-20', 'Alineación y balanceo', 180.00),
(4, 4, '2024-05-10', 'Cambio de neumáticos', 400.00),
(5, 5, '2024-06-05', 'Revisión de motor', 300.00),
(6, 6, '2024-07-25', 'Cambio de batería', 120.00),
(7, 7, '2024-08-15', 'Revisión de transmisión', 250.00),
(8, 8, '2024-09-10', 'Reemplazo de escape', 160.00),
(9, 9, '2024-10-01', 'Revisión completa', 350.00),
(10, 10, '2024-11-15', 'Cambio de aceite y revisión', 170.00);

-- Inserts para la tabla comisiones
INSERT INTO comisiones (id_empleado, id_venta, monto_comision) VALUES
(1, 1, 1000.00),
(2, 2, 900.00),
(3, 3, 1250.00),
(4, 4, 1100.00),
(5, 5, 1200.00),
(6, 6, 1050.00),
(7, 7, 950.00),
(8, 8, 1150.00),
(9, 9, 1300.00),
(10, 10, 1250.00);

