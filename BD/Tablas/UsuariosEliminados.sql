 
CREATE TABLE usuarios_eliminados(
consecutivo BIGINT,
nombre VARCHAR(100) NOT NULL,
apellido VARCHAR(100) NOT NULL,
run varchar(15) NOT NULL UNIQUE,
id_genero	tinyint NOT NULL,
fecha_nacimiento DATETIME NOT NULL,
telefono varchar(15),
email varchar(100) NOT NULL,
direccion varchar(100) NOT NULL,
direccion_detalle varchar(100),
id_comuna SMALLINT NOT NULL,
oficio varchar(50),
medio_enterar SMALLINT,
password varchar(100),
usuario_creacion varchar(50),
fecha_creacion DATETIME,
usuario_modificacion varchar(50),
fecha_modificacion DATETIME
);
