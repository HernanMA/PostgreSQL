-- ################### Subconsultas con EXISTS y NOT EXISTS ################

-- 18. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.
SELECT client_name 
FROM Customers C 
WHERE NOT EXISTS (SELECT 1 
                  FROM Payments P 
                  WHERE P.customer_id = C.customer_id);

-- 19. Devuelve un listado que muestre solamente los clientes que sí han realizado algún pago.
                 SELECT client_name 
FROM Customers C 
WHERE EXISTS (SELECT 1 
              FROM Payments P 
              WHERE P.customer_id = C.customer_id);

-- 20. Devuelve un listado de los productos que nunca han aparecido en un pedido.
             SELECT product_name 
FROM Products P 
WHERE NOT EXISTS (SELECT 1 
                  FROM OrderDetails OD 
                  WHERE OD.product_id = P.product_id);

-- 21. Devuelve un listado de los productos que han aparecido en un pedido alguna vez.
                 SELECT product_name 
FROM Products P 
WHERE EXISTS (SELECT 1 
              FROM OrderDetails OD 
              WHERE OD.product_id = P.product_id);
