create table Offices (
    office_id serial primary key,
    city varchar(100),
    phone varchar(20),
    country varchar(100),
    addres1 varchar(50),
    addres2 varchar(50),
    region varchar(50),
    postal_num varchar(10)
);

create table Employees (
    employee_id serial primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(100),
    job_title varchar(50),
    office_id int,
    manager_id int,
    extension varchar(10),
    foreign key (office_id) references Offices(office_id),
    foreign key (manager_id) references Employees(employee_id)
);

create table Customers (
    customer_id serial primary key,
    client_name varchar(50),
    contact_name varchar(50),
    last_name_client varchar(30),
    fax varchar(15),
    addres_line1 varchar(50),
    addres_line2 varchar(50),
    city varchar(100),
    country varchar(100),
    region varchar(50),
    phone varchar(20),
    sales_rep_id int,
    credit_line decimal(15,2),
    foreign key (sales_rep_id) references Employees(employee_id)
);

create table Orders (
    order_id serial primary key,
    customer_id int,
    order_date DATE,
    required_date DATE,
    shipped_date DATE,
    status varchar(50),
    comments TEXT,
    foreign key (customer_id) references Customers(customer_id)
);

create table Payments (
    payment_id serial primary key,
    customer_id int,
    payment_date DATE,
    amount decimal(10, 2),
    payment_method varchar(50),
    foreign key (customer_id) references Customers(customer_id)
);

create table range (
	id_range serial primary key,
	description_text text,
	description_html text,
	imagen varchar(256)
);

create table Products (
    product_id serial primary key,
    product_name varchar(100),
    dimension varchar(100),
    description text,
    supplier varchar(100),
    quantity_in_stock int,
    buy_price decimal(10, 2),
    manager_ decimal(10, 2),
    supplier_price decimal(15,2),
    product_range int,
    foreign key (product_range) references range(id_range)
);

create table OrderDetails (
    order_id int,
    product_id int,
    quantity_ordered int,
    price_each decimal(10, 2),
    primary key (order_id, product_id),
    foreign key (order_id) references Orders(order_id),
    foreign key (product_id) references Products(product_id)
);

select * from products p ;