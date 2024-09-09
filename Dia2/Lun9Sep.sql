CREATE TABLE regiones (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100)
);

CREATE TABLE departamentos (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    region_id INT,
    FOREIGN KEY (region_id) REFERENCES regiones(id)
);

CREATE TABLE municipios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    departamento_id INT,
    personas_viven INT DEFAULT 0,
    personas_trabajan INT DEFAULT 0,
    FOREIGN KEY (departamento_id) REFERENCES departamentos(id)
);

CREATE TABLE personas (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    municipio_nacimiento_id INT,
    municipio_domicilio_id INT,
    FOREIGN KEY (municipio_nacimiento_id) REFERENCES municipios(id),
    FOREIGN KEY (municipio_domicilio_id) REFERENCES municipios(id)
);

CREATE TABLE personas_temporal (
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    municipio_nacimiento VARCHAR(200),
    municipio_domicilio VARCHAR(200)
);

CREATE TABLE datos_temporales_municipios (
    region VARCHAR(200),
    departamento VARCHAR(200),
    codigo_departamento VARCHAR(100),
    municipio VARCHAR(200),
    codigo_municipio VARCHAR(100)
);

INSERT INTO regiones (nombre)
SELECT DISTINCT region
FROM datos_temporales_municipios
WHERE region NOT IN (SELECT nombre FROM regiones);

INSERT INTO departamentos (nombre, region_id)
SELECT DISTINCT dtm.departamento, r.id
FROM datos_temporales_municipios dtm
JOIN regiones r ON r.nombre = dtm.region
WHERE dtm.departamento NOT IN (SELECT nombre FROM departamentos);

INSERT INTO municipios (nombre, departamento_id)
SELECT DISTINCT dtm.municipio, d.id
FROM datos_temporales_municipios dtm
JOIN departamentos d ON d.nombre = dtm.departamento
WHERE dtm.municipio NOT IN (SELECT nombre FROM municipios);

INSERT INTO personas (nombre, apellido, municipio_nacimiento_id, municipio_domicilio_id)
SELECT pt.nombre, pt.apellido,
       (SELECT id 
        FROM municipios m 
        WHERE m.nombre = split_part(pt.municipio_nacimiento, ', ', 1)
        LIMIT 1), 
       (SELECT id 
        FROM municipios m 
        WHERE m.nombre = split_part(pt.municipio_domicilio, ', ', 1)
        LIMIT 1)
FROM personas_temporal pt;

select * from regiones;
select * from departamentos;
select * from municipios;
select * from personas;


create view regiones_departamentos as
select
    r.nombre as region,
    d.nombre as departamento,
    count(m.id) as cantidad_municipios
from
    regiones r
join
    departamentos d on r.id = d.region_id
left join
    municipios m on d.id = m.departamento_id
group by
    r.nombre,
    d.nombre;
select * from regiones_departamentos;

   
create or replace view departamentos_municipios as
select
    d.nombre as departamento,
    m.nombre as municipio,
    m.personas_viven,
    m.personas_trabajan
from
    departamentos d
join
    municipios m on d.id = m.departamento_id;
select * from departamentos_municipios;



create or replace function actualizar_conteos_municipio() 
returns trigger as $$
begin
    update municipios 
    set personas_viven = (select count(*) from personas where municipio_domicilio_id = new.municipio_domicilio_id)
    where id = new.municipio_domicilio_id;

    update municipios 
    set personas_trabajan = (select count(*) from personas where municipio_domicilio_id = new.municipio_domicilio_id)
    where id = new.municipio_domicilio_id;

    return new;
end;
$$ language plpgsql;

