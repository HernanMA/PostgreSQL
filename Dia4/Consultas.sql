-- 1. Listar Vehículos Disponibles: Obtener una lista de todos los vehículos disponibles para la venta, incluyendo detalles como marca, modelo, y precio.
SELECT marca, modelo, año, precio 
FROM vehiculos
WHERE id_vehiculo NOT IN (SELECT id_vehiculo FROM ventas);

-- 2. Clientes con Compras Recientes: Mostrar los clientes que han realizado compras recientemente, junto con la información de los vehículos adquiridos.
SELECT c.nombre AS cliente, v.marca, v.modelo, ve.fecha_venta, ve.precio_final
FROM ventas ve
JOIN clientes c ON ve.id_cliente = c.id_cliente
JOIN vehiculos v ON ve.id_vehiculo = v.id_vehiculo
WHERE ve.fecha_venta >= CURRENT_DATE - INTERVAL '1 days';

-- 3. Historial de Servicios por Vehículo: Obtener el historial completo de servicios realizados para un vehículo específico, incluyendo detalles sobre los empleados involucrados y las fechas de servicio.
SELECT s.fecha_servicio, s.descripcion, s.costo, e.nombre AS empleado
FROM servicios s
JOIN empleados e ON s.id_empleado = e.id_empleado
WHERE s.id_vehiculo = '1'
ORDER BY s.fecha_servicio DESC;

-- 4. Proveedores de Piezas Utilizados: Listar los proveedores de piezas que han suministrado componentes utilizados en los servicios de mantenimiento.
SELECT DISTINCT p.nombre_proveedor
FROM vehiculos v
JOIN proveedores_piezas p ON v.id_proveedor_pieza = p.id_proveedor_pieza
JOIN servicios s ON v.id_vehiculo = s.id_vehiculo;

-- 5. Rendimiento del Personal de Ventas: Calcular las comisiones generadas por cada empleado del departamento de ventas en un período específico.
SELECT e.nombre AS empleado, SUM(c.monto_comision) AS total_comision
FROM comisiones c
JOIN empleados e ON c.id_empleado = e.id_empleado
WHERE e.id_departamento = (SELECT id_departamento FROM departamentos WHERE nombre = 'Ventas')
AND c.id_venta IN (
    SELECT id_venta FROM ventas WHERE fecha_venta BETWEEN '2024-01-01' AND '2024-12-31'
)
GROUP BY e.nombre
ORDER BY total_comision DESC;

-- 6. Servicios Realizados por un Empleado: Identificar todos los servicios de mantenimiento realizados por un empleado específico, incluyendo detalles sobre los vehículos atendidos.
SELECT s.fecha_servicio, s.descripcion, v.marca, v.modelo, v.año
FROM servicios s
JOIN vehiculos v ON s.id_vehiculo = v.id_vehiculo
WHERE s.id_empleado = '2'
ORDER BY s.fecha_servicio DESC;

-- 7. Clientes Potenciales y Vehículos de Interés: Mostrar información sobre los clientes potenciales y los vehículos de su interés, proporcionando pistas valiosas para estrategias de marketing.
SELECT c.nombre, c.telefono, c.email, v.marca, v.modelo, v.precio
FROM clientes c
JOIN vehiculos v ON v.id_vehiculo = (SELECT id_vehiculo FROM ventas WHERE id_cliente = c.id_cliente LIMIT 1)
WHERE c.es_potencial = TRUE;

-- 8. Empleados del Departamento de Servicio: Listar todos los empleados que pertenecen al departamento de servicio, junto con sus horarios de trabajo.
SELECT e.nombre, e.fecha_contratacion
FROM empleados e
WHERE e.id_departamento = (SELECT id_departamento FROM departamentos WHERE nombre = 'Servicio');

-- 9. Vehículos Vendidos en un Rango de Precios: Encontrar los vehículos vendidos en un rango de precios específico, proporcionando datos útiles para análisis de ventas.
SELECT v.marca, v.modelo, v.precio, ve.fecha_venta, c.nombre AS cliente
FROM ventas ve
JOIN vehiculos v ON ve.id_vehiculo = v.id_vehiculo
JOIN clientes c ON ve.id_cliente = c.id_cliente
WHERE ve.precio_final BETWEEN 20000 AND 30000;

-- 10. Clientes con Múltiples Compras: Identificar a aquellos clientes que han realizado más de una compra en el concesionario, destacando la lealtad del cliente.
SELECT c.nombre, COUNT(ve.id_venta) AS num_compras
FROM ventas ve
JOIN clientes c ON ve.id_cliente = c.id_cliente
GROUP BY c.nombre
HAVING COUNT(ve.id_venta) > 1;
