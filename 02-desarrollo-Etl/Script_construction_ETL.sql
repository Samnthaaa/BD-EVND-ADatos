--
	create database stage_northwind;
--
	create database datamart_northwind;

	--Implementar la base de datos stage
	use  stage_northwind;
	--Nvarchar:No tan seguro /Varchar: Seguro
	create table categorias(
	categoria int not null,
	nombrecategoria varchar(15)
	);

	create table clientes(
	clienteid char(5) not null,
	compania varchar (40) not null,
	ciudad varchar(15) null,
	region varchar (15) null,
	codigopostal char (10),
	pais varchar(15)
	);

	create table empleado(
	empleadoid int not null,
	nombre varchar (10) not null,
	apellido varchar (20) not null,
	fecha_contratacion date null,
	);

	create table producto(
	productoid int not null,
	nombre_producto varchar (50)not null,
	precio_unitario decimal(15,2)not null,
	);

	create table provedor(
	provedorid int not null,
	provedor_nombre varchar (40)not null,
	ciudad varchar(15),
	region varchar(15),
	pais varchar(15)
	);

	create table ventas(
	clienteid char(5)not null,
	empleadocodigo int not null,
	productocodigo int not null,
	ventasorden datetime not null,
	ventasmonto decimal (15,2)not null,
	ventasunidades int not null,
	ventaspreciounitario decimal (15,2)not null,
	ventasdescuento decimal (15,2) not null,
	);
	-----------------------------------------------------------------------------

use datamart_northwind;

	--crear el datamartnortwind
create table dim_cliente(
cliente_Skey int not null identity(1,1),
cliente_codigoBkey char(5) not null,
cliente_compania varchar (40) not null,
cliente_direccion varchar (15) not null,
cliente_region varchar(25)not null,
cliente_pais varchar(15)not null,
constraint pk_dimcliente
primary key(cliente_Skey)
);

create table dim_empleado(
empleado_Skey int not null identity (1,1),
empleado_codigoBKey int not null,
empleado_NombreCompleto varchar (100)not null,
constraint pk_dimempleado
primary key (empleado_Skey)
);
--bussienes key
create table dim_producto(
producto_Skey int not null identity (1,1),
producto_codigoBKey int not null,
producto_nombre varchar (80) not null,
producto_categroia varchar(15)not null,
constraint pk_dimproducto
primary key (producto_Skey)
);

create table dim_tiempo(
tiempo_SKey int not null identity(1,1),
tiempo_FechaActual datetime not null,
tiempo_anio int not null,
tiempo_trimestre int not null,
tiempo_mes int not null,
tiempo_semana int not null,
tiempo_diadeanio int not null,
tiempo_diademes  int not null,
tiempo_diasemana int not null
constraint pk_dimtiempo
primary key (tiempo_SKey)
);
 create table Fact_ventas(
 cliente_SKey int not null,
 empleado_SKey int not null,
 producto_SKey int not null,
 tiempo_SKey int not null,
 ventas_Norden int not null,
 ventas_monto decimal (15,2) not null,
 ventas_unidades int not null,
 ventas_punitario decimal (15,2) not null,
 ventas_descuento decimal (15,2) not null
  constraint pk_facVentas
  primary key (cliente_Skey,empleado_SKey, producto_SKey, tiempo_SKey)

  constraint pk_facVentas_dimcliente
  foreign key(cliente_SKey)
  references dim_cliente (cliente_SKey),

  constraint fk_facVentas_dimempleado
  foreign key (empleado_SKey)
  references dim_empleado(empleado_Skey),

  constraint fk_facVentas_dimproducto
  foreign key (producto_SKey)
  references dim_producto(producto_Skey),

  constraint fk_facVentas_dimtiempo
  foreign key (tiempo_SKey)
  references dim_tiempo(tiempo_Skey)
 );