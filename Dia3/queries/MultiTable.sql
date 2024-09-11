-- ##################### Consultas multitabla (Composición interna) #################

-- 1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
select c.client_name, e.first_name, e.last_name 
from customers c, employees e 
where c.sales_rep_id = e.employee_id;

-- INNER JOIN
select c.client_name, e.first_name, e.last_name 
from customers c 
inner join employees e on c.sales_rep_id = e.employee_id;

-- NATURAL JOIN 
select client_name, first_name, last_name 
from customers 
natural join employees;

-- 2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.
select c.client_name, e.first_name, e.last_name 
from customers c, employees e, payments p 
where c.sales_rep_id = e.employee_id 
and c.customer_id = p.customer_id;

-- INNER JOIN
select c.client_name, e.first_name, e.last_name 
from customers c 
inner join employees e on c.sales_rep_id = e.employee_id 
inner join payments p on c.customer_id = p.customer_id;


-- 3. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.
select c.client_name, e.first_name, e.last_name 
from customers c, employees e 
where c.sales_rep_id = e.employee_id 
and c.customer_id not in (select customer_id from payments);

-- INNER JOIN
select c.client_name, e.first_name, e.last_name 
from customers c 
inner join employees e on c.sales_rep_id = e.employee_id 
left join payments p on c.customer_id = p.customer_id 
where p.customer_id is null;


-- 4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la 
-- ciudad de la oficina a la que pertenece el representante.
select c.client_name, e.first_name, e.last_name, o.city 
from customers c, employees e, offices o, payments p 
where c.sales_rep_id = e.employee_id 
and e.office_id = o.office_id 
and c.customer_id = p.customer_id;

-- INNER JOIN 
select c.client_name, e.first_name, e.last_name, o.city 
from customers c 
inner join employees e on c.sales_rep_id = e.employee_id 
inner join offices o on e.office_id = o.office_id 
inner join payments p on c.customer_id = p.customer_id;


-- 5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la 
-- ciudad de la oficina a la que pertenece el representante.
select c.client_name, e.first_name, e.last_name, o.city 
from customers c, employees e, offices o 
where c.sales_rep_id = e.employee_id 
and e.office_id = o.office_id 
and c.customer_id not in (select customer_id from payments);

-- INNER JOIN 
select c.client_name, e.first_name, e.last_name, o.city 
from customers c 
inner join employees e on c.sales_rep_id = e.employee_id 
inner join offices o on e.office_id = o.office_id 
left join payments p on c.customer_id = p.customer_id 
where p.customer_id is null;


-- 6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
select o.addres1, o.addres2 
from offices o, customers c 
where o.office_id = c.sales_rep_id 
and c.city = 'Fuenlabrada';

-- INNER JOIN
select o.addres1, o.addres2 
from offices o 
inner join employees e on o.office_id = e.office_id 
inner join customers c on e.employee_id = c.sales_rep_id 
where c.city = 'Fuenlabrada';


-- 7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que 
-- pertenece el representante.
select c.client_name, e.first_name, e.last_name, o.city 
from customers c, employees e, offices o 
where c.sales_rep_id = e.employee_id 
and e.office_id = o.office_id;

-- INNER JOIN
select c.client_name, e.first_name, e.last_name, o.city 
from customers c 
inner join employees e on c.sales_rep_id = e.employee_id 
inner join offices o on e.office_id = o.office_id;


-- 8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
select e1.first_name as employee_name, e2.first_name as manager_name 
from employees e1, employees e2 
where e1.manager_id = e2.employee_id;

-- INNER JOIN
select e1.first_name as employee_name, e2.first_name as manager_name 
from employees e1 
inner join employees e2 on e1.manager_id = e2.employee_id;


-- 9. Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe.
select e1.first_name as employee_name, e2.first_name as manager_name, e3.first_name as manager_of_manager 
from employees e1, employees e2, employees e3 
where e1.manager_id = e2.employee_id 
and e2.manager_id = e3.employee_id;

-- INNER JOIN 
select e1.first_name as employee_name, e2.first_name as manager_name, e3.first_name as manager_of_manager 
from employees e1 
inner join employees e2 on e1.manager_id = e2.employee_id 
inner join employees e3 on e2.manager_id = e3.employee_id;


-- 10. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
select c.client_name 
from customers c, orders o 
where c.customer_id = o.customer_id 
and o.shipped_date > o.required_date;

-- INNER JOIN
select c.client_name 
from customers c 
inner join orders o on c.customer_id = o.customer_id 
where o.shipped_date > o.required_date;


-- 11. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
select distinct c.client_name, r.description_text 
from customers c, orders o, orderdetails od, products p, range r 
where c.customer_id = o.customer_id 
and o.order_id = od.order_id 
and od.product_id = p.product_id 
and p.product_range = r.id_range;

-- INNER JOIN
select distinct c.client_name, r.description_text 
from customers c 
inner join orders o on c.customer_id = o.customer_id 
inner join orderdetails od on o.order_id = od.order_id 
inner join products p on od.product_id = p.product_id 
inner join range r on p.product_range = r.id_range;

