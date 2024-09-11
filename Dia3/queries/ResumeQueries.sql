-- ############################ Consultas resumen ############################

-- 1. ¿Cuántos empleados hay en la compañía?
SELECT COUNT(*) AS total_empleados FROM Employees;

-- 2. ¿Cuántos clientes tiene cada país?
SELECT country, COUNT(*) AS total_clientes 
FROM Customers 
GROUP BY country;

-- 3. ¿Cuál fue el pago medio en 2009?
SELECT AVG(amount) AS pago_medio_2009 
FROM Payments 
WHERE YEAR(payment_date) = 2009;

-- 4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma descendente por el número de pedidos.
SELECT status, COUNT(*) AS total_pedidos 
FROM Orders 
GROUP BY status 
ORDER BY total_pedidos DESC;

-- 5. Calcula el precio de venta del producto más caro y más barato en una misma consulta.
SELECT MAX(buy_price) AS producto_mas_caro, MIN(buy_price) AS producto_mas_barato 
FROM Products;

-- 6. Calcula el número de clientes que tiene la empresa.
SELECT COUNT(*) AS total_clientes FROM Customers;

-- 7. ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?
SELECT COUNT(*) AS clientes_madrid 
FROM Customers 
WHERE city = 'Madrid';

-- 8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?
SELECT city, COUNT(*) AS total_clientes 
FROM Customers 
WHERE city LIKE 'M%' 
GROUP BY city;

-- 9. Devuelve el nombre de los representantes de ventas y el número de clientes al que atiende cada uno.
SELECT E.first_name, E.last_name, COUNT(C.customer_id) AS total_clientes 
FROM Employees E 
JOIN Customers C ON E.employee_id = C.sales_rep_id 
GROUP BY E.first_name, E.last_name;

-- 10. Calcula el número de clientes que no tiene asignado representante de ventas.
SELECT COUNT(*) AS clientes_sin_representante 
FROM Customers 
WHERE sales_rep_id IS NULL;

-- 11. Calcula la fecha del primer y último pago realizado por cada uno de los clientes. El listado deberá mostrar 
-- el nombre y los apellidos de cada cliente.
SELECT C.client_name, 
       C.last_name_client, 
       MIN(P.payment_date) AS primer_pago, 
       MAX(P.payment_date) AS ultimo_pago 
FROM Customers C 
JOIN Payments P ON C.customer_id = P.customer_id 
GROUP BY C.client_name, C.last_name_client;

-- 12. Calcula el número de productos diferentes que hay en cada uno de los pedidos.
SELECT O.order_id, COUNT(DISTINCT OD.product_id) AS productos_diferentes 
FROM Orders O 
JOIN OrderDetails OD ON O.order_id = OD.order_id 
GROUP BY O.order_id;
	
-- 13. Calcula la suma de la cantidad total de todos los productos que aparecen en cada uno de los pedidos.
SELECT O.order_id, SUM(OD.quantity_ordered) AS total_cantidad 
FROM Orders O 
JOIN OrderDetails OD ON O.order_id = OD.order_id 
GROUP BY O.order_id;

-- 14. Devuelve un listado de los 20 productos más vendidos y el número total de unidades que se han vendido de cada uno. 
-- El listado deberá estar ordenado por el número total de unidades vendidas.
SELECT P.product_name, SUM(OD.quantity_ordered) AS total_vendido 
FROM Products P 
JOIN OrderDetails OD ON P.product_id = OD.product_id 
GROUP BY P.product_name 
ORDER BY total_vendido DESC 
LIMIT 20;

-- 15. La facturación que ha tenido la empresa en toda la historia, indicando la base imponible, el IVA y el total 
-- facturado. La base imponible se calcula sumando el coste del producto por el número de unidades vendidas de la
-- tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la suma de los dos campos anteriores.
SELECT SUM(OD.quantity_ordered * OD.price_each) AS base_imponible, 
       SUM(OD.quantity_ordered * OD.price_each) * 0.21 AS IVA, 
       SUM(OD.quantity_ordered * OD.price_each) * 1.21 AS total_facturado 
FROM OrderDetails OD;

-- 16. La misma información que en la pregunta anterior, pero agrupada por código de producto.
SELECT OD.product_id, 
       SUM(OD.quantity_ordered * OD.price_each) AS base_imponible, 
       SUM(OD.quantity_ordered * OD.price_each) * 0.21 AS IVA, 
       SUM(OD.quantity_ordered * OD.price_each) * 1.21 AS total_facturado 
FROM OrderDetails OD 
GROUP BY OD.product_id;

-- 17. La misma información que en la pregunta anterior, pero agrupada por código de producto filtrada por los códigos 
-- que empiecen por OR.
SELECT OD.product_id, 
       SUM(OD.quantity_ordered * OD.price_each) AS base_imponible, 
       SUM(OD.quantity_ordered * OD.price_each) * 0.21 AS IVA, 
       SUM(OD.quantity_ordered * OD.price_each) * 1.21 AS total_facturado 
FROM OrderDetails OD 
JOIN Products P ON OD.product_id = P.product_id 
WHERE P.product_name LIKE 'OR%' 
GROUP BY OD.product_id;

-- 18. Lista las ventas totales de los productos que hayan facturado más de 3000 euros. Se mostrará el nombre, 
-- unidades vendidas, total facturado y total facturado con impuestos (21% IVA).
SELECT P.product_name, 
       SUM(OD.quantity_ordered) AS unidades_vendidas, 
       SUM(OD.quantity_ordered * OD.price_each) AS total_facturado, 
       SUM(OD.quantity_ordered * OD.price_each) * 1.21 AS total_con_impuestos 
FROM Products P 
JOIN OrderDetails OD ON P.product_id = OD.product_id 
GROUP BY P.product_name 
HAVING SUM(OD.quantity_ordered * OD.price_each) > 3000;

-- 19. Muestre la suma total de todos los pagos que se realizaron para cada uno de los años que aparecen en la tabla pagos.
SELECT YEAR(payment_date) AS anio, 
       SUM(amount) AS total_pago 
FROM Payments 
GROUP BY YEAR(payment_date);
