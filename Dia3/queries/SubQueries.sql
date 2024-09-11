-- ################### Subconsultas ####################

-- 1. Devuelve el nombre del cliente con mayor límite de crédito.
SELECT client_name 
FROM Customers 
WHERE credit_line = (SELECT MAX(credit_line) FROM Customers);

-- 2. Devuelve el nombre del producto que tenga el precio de venta más caro.
SELECT product_name 
FROM Products 
WHERE buy_price = (SELECT MAX(buy_price) FROM Products);

-- 3. Devuelve el nombre del producto del que se han vendido más unidades.
SELECT product_name 
FROM Products 
WHERE product_id = (SELECT product_id 
                    FROM OrderDetails 
                    GROUP BY product_id 
                    ORDER BY SUM(quantity_ordered) DESC 
                    LIMIT 1);

                   

-- 4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado. (Sin utilizar INNER JOIN).
                   SELECT client_name 
FROM Customers 
WHERE credit_line > (SELECT SUM(amount) 
                     FROM Payments 
                     WHERE Payments.customer_id = Customers.customer_id);

-- 5. Devuelve el producto que más unidades tiene en stock.
                    SELECT product_name 
FROM Products 
WHERE quantity_in_stock = (SELECT MAX(quantity_in_stock) FROM Products);

-- 6. Devuelve el producto que menos unidades tiene en stock.
SELECT product_name 
FROM Products 
WHERE quantity_in_stock = (SELECT MIN(quantity_in_stock) FROM Products);

-- 7. Devuelve el nombre, los apellidos y el email de los empleados que están a cargo de Alberto Soria.
SELECT first_name, last_name, email 
FROM Employees 
WHERE manager_id = (SELECT employee_id 
                    FROM Employees 
                    WHERE first_name = 'Alberto' 
                    AND last_name = 'Soria');
