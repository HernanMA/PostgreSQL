-- ################### Consultas variadas ####################

-- 1. Devuelve el listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado. Tenga en 
-- cuenta que pueden existir clientes que no han realizado ningún pedido.
SELECT C.client_name, COUNT(O.order_id) AS total_pedidos
FROM Customers C
LEFT JOIN Orders O ON C.customer_id = O.customer_id
GROUP BY C.client_name;

-- 2. Devuelve un listado con los nombres de los clientes y el total pagado por cada uno de ellos. Tenga en cuenta 
-- que pueden existir clientes que no han realizado ningún pago.
SELECT C.client_name, IFNULL(SUM(P.amount), 0) AS total_pagado
FROM Customers C
LEFT JOIN Payments P ON C.customer_id = P.customer_id
GROUP BY C.client_name;

-- 3. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 ordenados alfabéticamente de menor a mayor.
SELECT DISTINCT C.client_name
FROM Customers C
JOIN Orders O ON C.customer_id = O.customer_id
WHERE YEAR(O.order_date) = 2008
ORDER BY C.client_name ASC;

-- 4. Devuelve el nombre del cliente, el nombre y primer apellido de su representante de ventas y el número de teléfono de la oficina del
-- representante de ventas, de aquellos clientes que no hayan realizado ningún pago.
SELECT C.client_name, E.first_name, E.last_name, O.phone
FROM Customers C
JOIN Employees E ON C.sales_rep_id = E.employee_id
JOIN Offices O ON E.office_id = O.office_id
WHERE C.customer_id NOT IN (SELECT P.customer_id FROM Payments P);

-- 5. Devuelve el listado de clientes donde aparezca el nombre del cliente, el nombre y primer apellido de su 
-- representante de ventas y la ciudad donde está su oficina.
SELECT C.client_name, E.first_name, E.last_name, O.city
FROM Customers C
JOIN Employees E ON C.sales_rep_id = E.employee_id
JOIN Offices O ON E.office_id = O.office_id;

-- 6. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.
SELECT E.first_name, E.last_name, E.job_title, O.phone
FROM Employees E
JOIN Offices O ON E.office_id = O.office_id
WHERE E.employee_id NOT IN (SELECT sales_rep_id FROM Customers WHERE sales_rep_id IS NOT NULL);

-- 7. Devuelve un listado indicando todas las ciudades donde hay oficinas y el número de empleados que tiene.
SELECT O.city, COUNT(E.employee_id) AS total_empleados
FROM Offices O
LEFT JOIN Employees E ON O.office_id = E.office_id
GROUP BY O.city;
