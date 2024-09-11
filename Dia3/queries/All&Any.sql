-- ################## Subconsultas con ALL y ANY #####################
-- 8. Devuelve el nombre del cliente con mayor límite de crédito.
SELECT client_name 
FROM Customers 
WHERE credit_line >= ALL (SELECT credit_line FROM Customers);

-- 9. Devuelve el nombre del producto que tenga el precio de venta más caro.
SELECT product_name 
FROM Products 
WHERE buy_price >= ALL (SELECT buy_price FROM Products);

-- 10. Devuelve el producto que menos unidades tiene en stock. Subconsultas con IN y NOT IN
SELECT product_name 
FROM Products 
WHERE quantity_in_stock <= ANY (SELECT quantity_in_stock FROM Products);

-- 11. Devuelve el nombre, apellido1 y cargo de los empleados que no representen a ningún cliente.
SELECT first_name, last_name, job_title 
FROM Employees 
WHERE employee_id NOT IN (SELECT sales_rep_id FROM Customers WHERE sales_rep_id IS NOT NULL);

-- 12. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
SELECT client_name 
FROM Customers 
WHERE customer_id NOT IN (SELECT customer_id FROM Payments);

-- 13. Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.
SELECT client_name 
FROM Customers 
WHERE customer_id IN (SELECT customer_id FROM Payments);

-- 14. Devuelve un listado de los productos que nunca han aparecido en un pedido.
SELECT product_name 
FROM Products 
WHERE product_id NOT IN (SELECT product_id FROM OrderDetails);

-- 15. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos empleados que no sean representante de ventas de ningún cliente.
SELECT E.first_name, E.last_name, E.job_title, O.phone 
FROM Employees E 
JOIN Offices O ON E.office_id = O.office_id 
WHERE E.employee_id NOT IN (SELECT sales_rep_id FROM Customers WHERE sales_rep_id IS NOT NULL);

-- 16. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de ventas de 
-- algún cliente que haya realizado la compra de algún producto de la gama Frutales.
SELECT office_id, city 
FROM Offices 
WHERE office_id NOT IN (SELECT E.office_id 
                        FROM Employees E 
                        JOIN Customers C ON E.employee_id = C.sales_rep_id 
                        JOIN Orders O ON C.customer_id = O.customer_id 
                        JOIN OrderDetails OD ON O.order_id = OD.order_id 
                        JOIN Products P ON OD.product_id = P.product_id 
                        WHERE P.product_range = (SELECT id_range FROM range WHERE description_text = 'Frutales'));

-- 17. Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.
SELECT client_name 
FROM Customers 
WHERE customer_id IN (SELECT customer_id FROM Orders) 
AND customer_id NOT IN (SELECT customer_id FROM Payments);
