-- ################# Consultas sobre una tabla ##################
-- 1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
select office_id, city 
from offices;


-- 2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
select city, phone 
from offices 
where country = 'Spain';


-- 3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo
-- jefe tiene un código de jefe igual a 7.
select first_name, last_name, email 
from employees 
where manager_id = 7;


-- 4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
select job_title, first_name, last_name, email 
from employees 
where manager_id is null;


-- 5. Devuelve un listado con el nombre, apellidos y puesto de aquellos
-- empleados que no sean representantes de ventas.
select first_name, last_name, job_title 
from employees 
where job_title != 'Sales Representative';


-- 6. Devuelve un listado con el nombre de los todos los clientes españoles.
select client_name 
from customers 
where country = 'Spain';


-- 7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.
select distinct status 
from orders;


-- 8. Devuelve un listado con el código de cliente de aquellos clientes que
-- realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar
-- aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:
-- • Utilizando la función YEAR de MySQL.

-- • Utilizando la función DATE_FORMAT de MySQL.

-- • Sin utilizar ninguna de las funciones anteriores.
select distinct customer_id 
from payments 
where extract(year from payment_date) = 2008;


-- 9. Devuelve un listado con el código de pedido, código de cliente, fecha
-- esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.
select order_id, customer_id, required_date, shipped_date 
from orders 
where shipped_date > required_date;


-- 10. Devuelve un listado con el código de pedido, código de cliente, fecha  de los 
-- pedidos cuya fecha de entrega ha sido al menos dos días antes de la fecha esperada.
-- • Utilizando la función ADDDATE de MySQL.

-- • Utilizando la función DATEDIFF de MySQL.
select order_id, customer_id, required_date, shipped_date 
from orders 
where age(required_date, shipped_date) >= interval '2 days';

-- • ¿Sería posible resolver esta consulta utilizando el operador de suma + o resta -?


-- 11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
select order_id, customer_id, status 
from orders 
where status = 'Rejected' 
and extract(year from order_date) = 2009;


-- 12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.
select order_id, customer_id, shipped_date 
from orders 
where extract(month from shipped_date) = 1;


-- 13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal.
-- Ordene el resultado de mayor a menor.
select payment_id, customer_id, payment_date, amount 
from payments 
where extract(year from payment_date) = 2008 
and payment_method = 'Paypal'
order by amount desc;


-- 14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en 
-- cuenta que no deben aparecer formas de pago repetidas.
select distinct payment_method 
from payments;


-- 15. Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales 
-- y que tienen más de 100 unidades en stock. El listado deberá estar ordenado por su 
-- precio de venta, mostrando en primer lugar los de mayor precio.
select product_name, quantity_in_stock, buy_price 
from products p 
join range r on p.product_range = r.id_range 
where r.description_text = 'Ornamentales' 
and p.quantity_in_stock > 100 
order by buy_price desc;


-- 16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo 
-- representante de ventas tenga el código de empleado 11 o 30.
select client_name 
from customers 
where city = 'Madrid' 
and sales_rep_id in (11, 30);
