-- ############################## Consultas multitabla (Composición externa) ###################################

-- 1. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pago.

-- LEFT JOIN
select c.client_name 
from customers c 
left join payments p on c.customer_id = p.customer_id 
where p.customer_id is null;

-- NATURAL LEFT JOIN
select client_name 
from customers 
natural left join payments 
where customer_id is null;

-- 2. Devuelve un listado que muestre solamente los clientes que no han realizado ningún pedido.

-- LEFT JOIN 
select client_name 
from customers 
natural left join payments 
where customer_id is null;

-- NATURAL LEFT JOIN
select client_name 
from customers 
natural left join orders 
where customer_id is null;


-- 3. Devuelve un listado que muestre los clientes que no han realizado ningún pago y los que no han realizado ningún pedido.

-- LEFT JOIN
select c.client_name 
from customers c 
left join payments p on c.customer_id = p.customer_id 
left join orders o on c.customer_id = o.customer_id 
where p.customer_id is null 
or o.customer_id is null;

-- NATURAL LEFT JOIN 
select client_name 
from customers 
natural left join payments 
natural left join orders 
where payments.customer_id is null or orders.customer_id is null;


-- 4. Devuelve un listado que muestre solamente los empleados que no tienen una oficina asociada.

-- LEFT JOIN
select e.first_name, e.last_name 
from employees e 
left join offices o on e.office_id = o.office_id 
where o.office_id is null;

-- NATURAL LEFT JOIN
select first_name, last_name 
from employees 
natural left join offices 
where office_id is null;


-- 5. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado.

-- LEFT JOIN 
select e.first_name, e.last_name 
from employees e 
left join customers c on e.employee_id = c.sales_rep_id 
where c.customer_id is null;

-- NATURAL LEFT JOIN 
select first_name, last_name 
from employees 
natural left join customers 
where customer_id is null;


-- 6. Devuelve un listado que muestre solamente los empleados que no tienen un cliente asociado junto con los datos 
-- de la oficina donde trabajan.

-- LEFT JOIN
select e.first_name, e.last_name, o.city, o.phone 
from employees e 
left join customers c on e.employee_id = c.sales_rep_id 
left join offices o on e.office_id = o.office_id 
where c.customer_id is null;


-- 7. Devuelve un listado que muestre los empleados que no tienen una oficina asociada y los que no tienen un cliente asociado.

-- LEFT JOIN 
select e.first_name, e.last_name 
from employees e 
left join customers c on e.employee_id = c.sales_rep_id 
left join offices o on e.office_id = o.office_id 
where o.office_id is null or c.customer_id is null;


-- 8. Devuelve un listado de los productos que nunca han aparecido en un pedido.

-- LEFT JOIN
select p.product_name 
from products p 
left join orderdetails od on p.product_id = od.product_id 
where od.product_id is null;


-- 9. Devuelve un listado de los productos que nunca han aparecido en un pedido. El resultado debe mostrar el nombre, 
-- la descripción y la imagen del producto.

-- LEFT JOIN
select p.product_name, p.description, r.imagen 
from products p 
left join orderdetails od on p.product_id = od.product_id 
left join range r on p.product_range = r.id_range 
where od.product_id is null;


-- 10. Devuelve las oficinas donde no trabajan ninguno de los empleados que hayan sido los representantes de 
-- ventas de algún cliente que haya realizado la compra de algún producto de la gama Frutales.

-- LEFT JOIN
select o.city, o.phone 
from offices o 
left join employees e on o.office_id = e.office_id 
left join customers c on e.employee_id = c.sales_rep_id 
left join orders od on c.customer_id = od.customer_id 
left join orderdetails odd on od.order_id = odd.order_id 
left join products p on odd.product_id = p.product_id 
left join range r on p.product_range = r.id_range 
where r.description_text = 'Frutales' 
and c.customer_id is null;


-- 11. Devuelve un listado con los clientes que han realizado algún pedido pero no han realizado ningún pago.
select c.client_name 
from customers c 
left join orders o on c.customer_id = o.customer_id 
left join payments p on c.customer_id = p.customer_id 
where o.customer_id is not null and p.customer_id is null;


-- 12. Devuelve un listado con los datos de los empleados que no tienen clientes asociados y el nombre de su jefe asociado.

-- LEFT JOIN
select e.first_name, e.last_name, m.first_name as manager_first_name, m.last_name as manager_last_name 
from employees e 
left join customers c on e.employee_id = c.sales_rep_id 
left join employees m on e.manager_id = m.employee_id 
where c.customer_id is null;

