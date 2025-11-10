 
CREATE TABLE regiones (
  id SMALLINT NOT NULL,
  region varchar(64) NOT NULL,
  abreviatura varchar(4) NOT NULL,
  capital varchar(64) NOT NULL)


GO
INSERT INTO regiones (id,region,abreviatura,capital)
VALUES
	(1,'Arica y Parinacota','AP','Arica'),
	(2,'Tarapacá','TA','Iquique'),
	(3,'Antofagasta','AN','Antofagasta'),
	(4,'Atacama','AT','Copiapó'),
	(5,'Coquimbo','CO','La Serena'),
	(6,'Valparaiso','VA','valparaíso'),
	(7,'Metropolitana de Santiago','RM','Santiago'),
	(8,'Libertador General Bernardo O''Higgins','OH','Rancagua'),
	(9,'Maule','MA','Talca'),
	(10,'Ñuble','NB','Chillán'),
	(11,'Biobío','BI','Concepción'),
	(12,'La Araucanía','IAR','Temuco'),
	(13,'Los Ríos','LR','Valdivia'),
	(14,'Los Lagos','LL','Puerto Montt'),
	(15,'Aysén del General Carlos Ibáñez del Campo','AI','Coyhaique'),
	(16,'Magallanes y de la Antártica Chilena','MG','Punta Arenas');
