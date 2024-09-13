create table departamentos (
    id_departamento SERIAL PRIMARY KEY,
    nombre varchar(50) NOT NULL
);

create table empleados (
    id_empleado SERIAL PRIMARY KEY,
    nombre varchar(100) NOT NULL,
    fecha_contratacion DATE NOT NULL,
    rol varchar(50) NOT NULL,
    id_departamento int,
    foreign key (id_departamento) references departamentos(id_departamento)
);

create table proveedores_piezas (
    id_proveedor_pieza SERIAL PRIMARY KEY,
    nombre_proveedor varchar(100) NOT NULL,
    telefono_proveedor varchar(15),
    email_proveedor varchar(100)
);

create table vehiculos (
    id_vehiculo SERIAL PRIMARY KEY,
    marca varchar(50) NOT NULL,
    modelo varchar(50) NOT NULL,
    año int NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    estado varchar(10) NOT NULL CHECK (estado IN ('Nuevo', 'Usado')),
    id_proveedor_pieza int,
    foreign key (id_proveedor_pieza) references proveedores_piezas(id_proveedor_pieza)
);

create table clientes (
    id_cliente SERIAL PRIMARY KEY,
    nombre varchar(100) NOT NULL,
    telefono varchar(15),
    email varchar(100),
    direccion varchar(150),
    es_potencial boolean DEFAULT FALSE
);

create table ventas (
    id_venta SERIAL PRIMARY KEY,
    id_vehiculo int,
    id_cliente int,
    fecha_venta DATE NOT NULL,
    precio_final DECIMAL(10, 2) NOT NULL,
    id_empleado int,
    foreign key (id_vehiculo) references vehiculos(id_vehiculo),
    foreign key (id_cliente) references clientes(id_cliente),
    foreign key (id_empleado) references empleados(id_empleado)
);

create table servicios (
    id_servicio SERIAL PRIMARY KEY,
    id_vehiculo int,
    id_empleado int,
    fecha_servicio DATE NOT NULL,
    descripcion TEXT NOT NULL,
    costo DECIMAL(10, 2),
    foreign key (id_vehiculo) references vehiculos(id_vehiculo),
    foreign key (id_empleado) references empleados(id_empleado)
);

create table comisiones (
    id_comision SERIAL PRIMARY KEY,
    id_empleado int,
    id_venta int,
    monto_comision DECIMAL(10, 2) NOT NULL,
    foreign key (id_empleado) references empleados(id_empleado),
    foreign key (id_venta) references ventas(id_venta)
);
select * from ventas s ;	
