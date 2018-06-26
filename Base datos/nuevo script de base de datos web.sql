create table tb_destinations(
	id int auto_increment primary key,
  name varchar(200) not null,
  address varchar(500)not null,
  description varchar(800), 
  x varchar(50),
  y varchar(50),
  image varchar(500)
);

create table tb_value_destinations(
	id int auto_increment primary key,
	class varchar(100) not null,
  price char not null default 'z',
  preference_place char not null default 'z',
  destination_type char not null default 'z',
  travel_time char not null default 'z',
  road_type char not null default 'z',
  id_destination int not null,
  constraint foreign key (id_destination) references tb_destinations(id)
)ENGINE=INNODB;

create table tb_user(
  user_name varchar(50) primary key,
  password varchar(50) not null
);

CREATE TABLE tb_destinations_values (
    id INTEGER AUTO_INCREMENT,
    attribute_name VARCHAR(100),
    repetition INTEGER,
    discriminant INTEGER,
    constraint PK primary key(id)
);

CREATE TABLE tb_destinations_differences (
    id INTEGER AUTO_INCREMENT,
    attribute_id INTEGER,
    attribute_value VARCHAR(100),
    constraint PK primary key(id)
);

CREATE TABLE tb_destinations_probabilities (
    id INTEGER AUTO_INCREMENT,
    attribute_name VARCHAR(100),
    attribute_value VARCHAR(100),
    repetition INTEGER,
    probability decimal(19,7),
    category VARCHAR(100),
    constraint PK primary key(id)
);

CREATE TABLE tb_destinations_prior_probabilities (
    id INTEGER AUTO_INCREMENT,
    category VARCHAR(100),
    probability DECIMAL(19,7),
    constraint PK primary key(id)
);

CREATE TABLE TMPCategory (
category VARCHAR(100) PRIMARY KEY,
probability DECIMAL(19,7) DEFAULT 0, 
active BIT DEFAULT 1
);

CREATE TABLE TMPValues (
attribute_name VARCHAR(100) PRIMARY KEY, 
attribute_value VARCHAR(100) default 'z', 
active BIT DEFAULT 1
);

CREATE TABLE TMP (id INTEGER NOT NULL PRIMARY KEY , 
attribute_name VARCHAR(100),
attribute_value VARCHAR(100) default 'z',
repetition INTEGER,
active BIT DEFAULT 1
);

insert into tb_destinations_values (id,attribute_name,repetition,discriminant)
values (1,'price',0,0), (2,'preference_place',0,0), (3,'destination_type',0,0), 
(4,'travel_time',0,0),(5,'road_type',0,0);

DELIMITER $$
CREATE PROCEDURE sp_update_probabilities_destinations(
    new_price VARCHAR(100),
    new_preference_place VARCHAR(100),
    new_destination_type VARCHAR(100),
    new_travel_time VARCHAR(100),
    new_road_type VARCHAR(100),
    new_class VARCHAR(100)
    )
    BEGIN
        DECLARE nc,m,n,id_,attribute_id_,total_n_ INTEGER;
        DECLARE p decimal(19,7);
        DECLARE topCount,currCount INTEGER;
        DECLARE topCountValues,currCountValues INTEGER;
        DECLARE topCountCategory,currCountCategory INTEGER;
        DECLARE attribute_name_,attribute_value_,category_ VARCHAR(100);

        /*BORRADO DE CUALQUIER REGISTRO DE LAS TABLAS QUE SE USARAN COMO TEMPORALES*/
        SET SQL_SAFE_UPDATES = 0;
        DELETE FROM TMPCategory;
        DELETE FROM TMPValues;
        DELETE FROM TMP;
        SET SQL_SAFE_UPDATES = 1;  

        /*AGREGAR NUEVA CATEGORIA SI NO EXISTE*/
        IF NOT EXISTS (SELECT * FROM tb_destinations_probabilities WHERE category=new_class) THEN
            INSERT INTO tb_destinations_values (attribute_name, repetition, discriminant)
            VALUES (new_class,0,1);
        END IF;

        /*AUMENTA EL CONTADOR DEL NUMERO DE INSTANCIAS EN CADA CATEGORIA*/
        SET SQL_SAFE_UPDATES = 0;
        UPDATE tb_destinations_values SET repetition=repetition+1
        WHERE attribute_name=new_class;
        SET SQL_SAFE_UPDATES = 1;
        
        /*TABLA TEMPORAL PARA ALMACENAR LOS DATOS DE LA NUEVA INSERCION*/
        INSERT INTO TMP (id,attribute_name,attribute_value)
        VALUES (1,'price',new_price),(2,'preference_place',new_preference_place),
        (3,'destination_type',new_destination_type),(4,'travel_time',new_travel_time),(5,'road_type',new_road_type);

        /*SETEO DE LOS CONTADORES PARA EL WHILE*/
        SET topCount= (SELECT COUNT(*) FROM TMP);
        SET currCount=0;
            
        /*SECCION PARA */
        WHILE currCount < topCount Do 
            /*SETEO DE VARIABLES GENERALES*/
            SET id_= (SELECT id FROM TMP WHERE active=1 LIMIT 1);
            SET attribute_name_= (SELECT attribute_name FROM TMP WHERE active=1 LIMIT 1);
            SET attribute_value_= (SELECT attribute_value FROM TMP WHERE active=1 LIMIT 1);

            IF EXISTS (SELECT * FROM tb_destinations_probabilities WHERE attribute_name=attribute_name_ AND attribute_value=attribute_value_ AND category=new_class) THEN
                /*AUMENTO DEL CONTADOR DEL NUMEROS DE REPITENCIA PARA UN ATRIBUTO POR CATEGORIA*/
                SET SQL_SAFE_UPDATES = 0;
                UPDATE tb_destinations_probabilities
                SET repetition= repetition+1
                WHERE attribute_name=attribute_name_ AND attribute_value=attribute_value_ AND category=new_class;
                SET SQL_SAFE_UPDATES = 1;
            ELSE 
                IF NOT EXISTS (SELECT * FROM tb_destinations_probabilities WHERE attribute_name=attribute_name_ AND attribute_value=attribute_value_) THEN
                   /*AUMENTO DEL CONTADOR DEL NUMEROS DE VALORES DIFERENTES QUE PUEDE TOMAR UN ATRIBUTO*/
                   SET SQL_SAFE_UPDATES = 0;
                   UPDATE tb_destinations_values
                   SET repetition=repetition+1
                   WHERE attribute_name=attribute_name_;
                   SET SQL_SAFE_UPDATES = 1;

                   /*INSERCION DEL NUEVO VALOR DIFERENTE QUE PUEDE TOMAR UN ATRIBUTO*/
                    SET attribute_id_=(SELECT id FROM tb_destinations_values WHERE attribute_name=attribute_name_);
                    INSERT INTO tb_destinations_differences(attribute_id,attribute_value)
                    VALUES (attribute_id_,attribute_value_);
                END IF;
                /*INSERCION DE LA NUEVA TUPLA CON ATRIBUTO Y CATEGORIA*/    
                INSERT INTO tb_destinations_probabilities (attribute_name,attribute_value,repetition,probability,category)
                VALUES (attribute_name_,attribute_value_,1,0,new_class);
            END IF;
            /*ACTUALIZACION DE CONTADORES PARA SEGUIR AVANZANDO EN EL WHILE*/   
            SET SQL_SAFE_UPDATES = 0; 
            UPDATE TMP SET active=0 WHERE id=id_;
            SET SQL_SAFE_UPDATES = 1;
            SET currCount = currCount + 1;
        END WHILE;
        /*BORRADO DE CUALQUIER REGISTRO DE LAS TABLAS QUE SE USARAN COMO TEMPORALES*/
        SET SQL_SAFE_UPDATES = 0;
        DELETE FROM TMP;
        SET SQL_SAFE_UPDATES = 1;   
        
                /*SECCION PARA AGREGAR NUEVAS COMBINACIONES ENTRE ATRIBUTOS Y CATEGORIAS NUEVAS INGRESADAS*/
        
        /*TABLA TEMPORAL PARA ALMACENAR LOS ATRIBUTOS QUE TIENE LA TABLA*/
        INSERT INTO TMP (id,attribute_name)
        (SELECT id,attribute_name FROM tb_destinations_values WHERE discriminant=0);
         
        /*SETEO DE CONTADORES PARA RECORRER LOS ATRIBUTOS DE LA TABLA*/
        SET topCount= (SELECT COUNT(*) FROM TMP);
        SET currCount=0;
            
        WHILE currCount < topCount Do 
            /*SETEO DE VARIABLES GENERALES*/
            SET attribute_id_= (SELECT id FROM TMP WHERE active=1 LIMIT 1);
            SET attribute_name_= (SELECT attribute_name FROM TMP WHERE active=1 LIMIT 1);

            /*TABLA TEMPORAL PARA ALMACENAR LOS DIFERENTES VALORES QUE PUEDE TOMAR UN ATRIBUTO*/
            INSERT INTO TMPValues (attribute_name)
            (SELECT attribute_value FROM tb_destinations_differences WHERE attribute_id=attribute_id_);

            /*SETEO DE VALORES PARA WHILE QUE RECORRE CADA VALOR QUE TOMA UN ATRIBUTO*/
            SET topCountValues= (SELECT COUNT(*) FROM TMPValues);
            SET currCountValues=0;

            WHILE currCountValues < topCountValues Do 
                /*SETEO DE VARIABLE GENERAL*/
                SET attribute_value_= (SELECT attribute_name FROM TMPValues WHERE active=1 LIMIT 1);


                INSERT INTO TMPCategory (category)
                (SELECT attribute_name FROM tb_destinations_values WHERE discriminant=1);

                /*SETEO DE VARIABLES PARA RECORRER TODAS LAS CATEGORIAS DISPONIBLES*/
                SET topCountCategory= (SELECT COUNT(*) FROM TMPCategory);
                SET currCountCategory=0;

                WHILE currCountCategory < topCountCategory Do 
                    /*SETEO DE VARIABLE GENERAL*/
                    SET category_=(SELECT category FROM TMPCategory WHERE activE=1 LIMIT 1);

                    IF NOT EXISTS (SELECT * FROM tb_destinations_probabilities WHERE attribute_name=attribute_name_ AND attribute_value=attribute_value_ AND category=category_) THEN
                        /*INSERCION DE COMBINACION ATRIBUTO-CATEGORIA SI AUN NO ESTA INGRESADO*/
                        INSERT INTO tb_destinations_probabilities (attribute_name,attribute_value,repetition,probability,category)
                        VALUES (attribute_name_,attribute_value_,0,0,category_);
                    END IF;
                    
                    /*ACTUALIZACION DE CONTADORES PARA SEGUIR AVANZANDO EN EL WHILE*/  
                    SET SQL_SAFE_UPDATES = 0;
                    UPDATE TMPCategory SET active=0 WHERE category_=category;
                    SET currCountCategory = currCountCategory + 1;
                    SET SQL_SAFE_UPDATES = 1;
                END WHILE;

                /*BORRADO DE CUALQUIER REGISTRO DE LAS TABLAS QUE SE USARAN COMO TEMPORALES*/
                SET SQL_SAFE_UPDATES = 0;
                DELETE FROM TMPCategory;
                SET SQL_SAFE_UPDATES = 1;  
    
                /*ACTUALIZACION DE CONTADORES PARA SEGUIR AVANZANDO EN EL WHILE*/  
                SET SQL_SAFE_UPDATES = 0;
                UPDATE TMPValues SET active=0 WHERE attribute_value_=attribute_name;
                SET SQL_SAFE_UPDATES = 1;
                SET currCountValues = currCountValues + 1;
            END WHILE;

             /*BORRADO DE CUALQUIER REGISTRO DE LAS TABLAS QUE SE USARAN COMO TEMPORALES*/
            SET SQL_SAFE_UPDATES = 0;
            DELETE FROM TMPValues;
            SET SQL_SAFE_UPDATES = 1;  
            
            /*ACTUALIZACION DE CONTADORES PARA SEGUIR AVANZANDO EN EL WHILE*/ 
            SET SQL_SAFE_UPDATES = 0;
            UPDATE TMP SET active=0 WHERE attribute_id_=id;
            SET SQL_SAFE_UPDATES = 1;
            SET currCount = currCount + 1;
        END WHILE;   
        
        /*BORRADO DE CUALQUIER REGISTRO DE LAS TABLAS QUE SE USARAN COMO TEMPORALES*/
        SET SQL_SAFE_UPDATES = 0;
        DELETE FROM TMP;
        SET SQL_SAFE_UPDATES = 1;  
        
        /*SECCION PARA ACTUALIZAR CADA PROBABILIDAD DE LOS ATRIBUTOS EN CADA CATEGORIA*/
            
        /*TABLA TEMPORAL PARA ALMACENAR TODAS LAS CATEGORIAS DISPONIBLES*/
        INSERT INTO TMPCategory (category)
        (SELECT attribute_name FROM tb_destinations_values WHERE discriminant=1);
    
        /*SETEO DE CONTADORES PARA EL WHILE*/
        SET topCountCategory= (SELECT COUNT(*) FROM TMPCategory);
        SET currCountCategory=0;

        WHILE currCountCategory < topCountCategory Do 
            /*SETEO DE VARIABLE GENERAL*/
            SET category_=(SELECT category FROM TMPCategory WHERE active=1 LIMIT 1);
            
            /*TALBA TEMPORAL PARA ALMACENAR LAS COMBINACIONES DE ATRIBUTO-CATEGORIA QUE SE LE VA A ACTUALIZAR LA PROBABILIDAD*/
            INSERT INTO TMP (id,attribute_name,attribute_value,repetition)
            (SELECT id, attribute_name, attribute_value ,repetition FROM tb_destinations_probabilities WHERE category=category_);
            
            /*SETEO DE VARIABLES PARA EL WHILE Y LA FORMULA PARA BAYES*/
            SET topCount= (SELECT COUNT(*) FROM TMP);
            SET currCount=0;
            SET m=(SELECT COUNT(*) FROM tb_destinations_values WHERE discriminant=0);
            SET n=(SELECT repetition FROM tb_destinations_values WHERE attribute_name=category_);
                
            WHILE currCount < topCount Do 
                /*SETEO DE VARIBLES PARA APLICAR BAYES*/
                SET id_= (SELECT id FROM TMP WHERE active=1 LIMIT 1);
                SET attribute_name_= (SELECT attribute_name FROM TMP WHERE active=1 LIMIT 1);
                SET attribute_value_= (SELECT attribute_value FROM TMP WHERE active=1 LIMIT 1);
                SET nc= (SELECT repetition FROM TMP WHERE active=1 LIMIT 1);
                SET p=(SELECT repetition FROM tb_destinations_values WHERE attribute_name=attribute_name_);
                SET p=1/p;

                /*ACTUALIZACION DE LAS PROBABILIDADES EN BAYES*/
                SET SQL_SAFE_UPDATES = 0;
                UPDATE tb_destinations_probabilities SET probability=(nc+m*p)/(n+m)
                WHERE attribute_name=attribute_name_ AND attribute_value=attribute_value_ AND category=category_;
                SET SQL_SAFE_UPDATES = 1;

                /*ACTUALIZACION DE CONTADORES PARA SEGUIR AVANZANDO EN EL WHILE*/ 
                SET SQL_SAFE_UPDATES = 0;
                UPDATE TMP SET active=0 WHERE id=id_;
                SET currCount = currCount + 1;
                SET SQL_SAFE_UPDATES = 1;
            END WHILE;
            /*BORRADO DE CUALQUIER REGISTRO DE LAS TABLAS QUE SE USARAN COMO TEMPORALES*/
            SET SQL_SAFE_UPDATES = 0;
            DELETE FROM TMP;
            SET SQL_SAFE_UPDATES = 1;  
            
            /*ACTUALIZA LAS PROBABILIDADES QUE TIENE CADA CATEGORIA DE APARECER EN EL TOTAL DE LOS REGISTROS*/
            SET n=(SELECT repetition FROM tb_destinations_values WHERE attribute_name=category_ AND discriminant=1);
            SET total_n_=(SELECT SUM(repetition) FROM tb_destinations_values WHERE discriminant=1);
            IF EXISTS (SELECT * FROM tb_destinations_prior_probabilities WHERE category=category_) THEN
                SET SQL_SAFE_UPDATES = 0;
                UPDATE tb_destinations_prior_probabilities SET probability=(n/total_n_)
                WHERE category=category_;
                SET SQL_SAFE_UPDATES = 1;
            ELSE
                INSERT INTO tb_destinations_prior_probabilities (category,probability)
                VALUES (category_,(n/total_n_));
            END IF;
        
            /*ACTUALIZACION DE CONTADORES PARA SEGUIR AVANZANDO EN EL WHILE*/ 
            SET SQL_SAFE_UPDATES = 0;
            UPDATE TMPCategory SET active=0 WHERE category_=category;
            SET SQL_SAFE_UPDATES = 1;
            SET currCountCategory = currCountCategory + 1;
        END WHILE;  
        /*BORRADO DE CUALQUIER REGISTRO DE LAS TABLAS QUE SE USARAN COMO TEMPORALES*/
        SET SQL_SAFE_UPDATES = 0;
        DELETE FROM TMPCategory;
        SET SQL_SAFE_UPDATES = 1;    
    END$$
DELIMITER ;

drop procedure insert_new_destination;

DELIMITER $$
CREATE procedure insert_new_destination(
    new_price VARCHAR(100),
    new_preference_place VARCHAR(100),
    new_destination_type VARCHAR(100),
    new_travel_time VARCHAR(100),
    new_road_type VARCHAR(100),
    new_class VARCHAR(100),
    new_name varchar(200),
    new_address varchar(500),
    new_description varchar(800), 
    new_x varchar(50),
    new_y varchar(50),
    new_image varchar(500)
) 
BEGIN

    DECLARE last_id INTEGER;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN
        SELECT '0' as result, 'SQLEXCEPTION' as err;
        ROLLBACK;
    END;

    DECLARE EXIT HANDLER FOR NOT FOUND 
    BEGIN
        SELECT '0' as result, 'NOT FOUND' as err;
        ROLLBACK;
    END;

    DECLARE EXIT HANDLER FOR SQLWARNING 
    BEGIN
        SELECT '0' as result, 'SQLWARNING' as err;
        ROLLBACK;
    END;
    
    START TRANSACTION;
    
    IF EXISTS (select name, x, y from tb_destinations WHERE name = new_name and x = new_x and y = new_y) THEN
        SET last_id = (SELECT id FROM tb_destinations where (name = new_name and x = new_x and y = new_y)); 
    ELSE
        INSERT INTO tb_destinations (name,address,description,x,y,image)
            VALUES(new_name, new_address, new_description, new_x, new_y, new_image);
    
        SET last_id=(SELECT id from tb_destinations ORDER BY id desc LIMIT 1);
    END IF;
    
    INSERT INTO tb_value_destinations (class, price, preference_place, destination_type, travel_time, road_type, id_destination)
    VALUES(new_class, new_price, new_preference_place, new_destination_type, new_travel_time, new_road_type, last_id);
    
    call sp_update_probabilities_destinations (new_price, new_preference_place, new_destination_type, new_travel_time, new_road_type, new_class);
    
    SELECT '1' as result;
    COMMIT;
END $$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE sp_recommend_destination(
    new_price VARCHAR(100),
    new_preference_place VARCHAR(100),
    new_destination_type VARCHAR(100),
    new_travel_time VARCHAR(100),
    new_road_type VARCHAR(100)
    )
BEGIN

    DECLARE topCountCategory,currCountCategory INTEGER;
    DECLARE topCountValues,currCountValues INTEGER;
    DECLARE attribute_name_,attribute_value_,category_ VARCHAR(100);
    DECLARE probability_,probability_temp_ DECIMAL(19,7);
    
    
    START TRANSACTION;
    
     /*BORRADO DE CUALQUIER REGISTRO DE LAS TABLAS QUE SE USARAN COMO TEMPORALES*/
    SET SQL_SAFE_UPDATES = 0;
    DELETE FROM TMPCategory;
    DELETE FROM TMPValues;
    DELETE FROM TMP;
    SET SQL_SAFE_UPDATES = 1;  

    /*ONTENCION DE TODAS LAS CATEGORIAS*/
    INSERT INTO TMPCategory (category)
    (SELECT attribute_name FROM tb_destinations_values WHERE discriminant=1);
    
    /*SETEO DE VARIABLES PARA RECORRER TODAS LAS CATEGORIAS DISPONIBLES*/
    SET topCountCategory= (SELECT COUNT(*) FROM TMPCategory);
    SET currCountCategory=0;

    WHILE currCountCategory < topCountCategory Do 
        /*SETEO DE VARIABLE GENERAL*/
        SET category_=(SELECT category FROM TMPCategory WHERE active=1 LIMIT 1);
        
        INSERT INTO TMPValues (attribute_name,attribute_value)
        VALUES ('price',new_price),('preference_place',new_preference_place),
        ('destination_type',new_destination_type),('travel_time',new_travel_time),
        ('road_type',new_road_type);
        
        /*SETEO DE VALORES PARA WHILE QUE RECORRE CADA VALOR QUE TOMA UN ATRIBUTO*/
        SET topCountValues= (SELECT COUNT(*) FROM TMPValues);
        SET currCountValues=0;
        SET probability_=1;

        WHILE currCountValues < topCountValues Do 
            /*SETEO DE VARIABLE GENERAL*/
            SET attribute_value_= (SELECT attribute_value FROM TMPValues WHERE active=1 LIMIT 1);
            SET attribute_name_= (SELECT attribute_name FROM TMPValues WHERE active=1 LIMIT 1);
            SET probability_temp_=(SELECT probability FROM tb_destinations_probabilities WHERE attribute_name=attribute_name_ AND attribute_value=attribute_value_ AND category=category_);
            SET probability_=probability_*probability_temp_;
            
            /*ACTUALIZACION DE CONTADORES PARA SEGUIR AVANZANDO EN EL WHILE*/  
            UPDATE TMPValues SET active=0 WHERE attribute_name_=attribute_name;
            SET currCountValues = currCountValues + 1;
        END WHILE;
        SET SQL_SAFE_UPDATES = 0;
        DELETE FROM TMPValues;
        SET SQL_SAFE_UPDATES = 1;
       
        SET probability_temp_=(SELECT probability FROM tb_destinations_prior_probabilities WHERE category=category_);
        SET SQL_SAFE_UPDATES = 0;
        UPDATE TMPCategory SET probability=probability_*probability_temp_
        WHERE category=category_;
        SET SQL_SAFE_UPDATES = 1;
        /*ACTUALIZACION DE CONTADORES PARA SEGUIR AVANZANDO EN EL WHILE*/  
        UPDATE TMPCategory SET active=0 WHERE category_=category;
        SET currCountCategory = currCountCategory + 1;
    END WHILE;
    SET probability_=(select MAX(probability) from TMPCategory LIMIT 1);
    SET category_=(select category from TMPCategory WHERE probability=probability_ LIMIT 1);
    SET SQL_SAFE_UPDATES = 0;
    DELETE FROM TMPCategory;
    SET SQL_SAFE_UPDATES = 1;
    
    SELECT tb_destinations.id, name, address, description, x, y, image, price, preference_place, destination_type, travel_time, road_type
    FROM tb_value_destinations, tb_destinations 
    WHERE tb_value_destinations.id = tb_destinations.id and tb_value_destinations.class=category_;

    COMMIT;
END $$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE sp_validate_session(user varchar(50), pass varchar(50))
BEGIN
select user_name from tb_user where user=user_name and pass=password;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_get_all_destinations()
BEGIN
  SELECT tb_destinations.id, name, address, description, x, y, image, price, preference_place, destination_type, travel_time, road_type
            FROM tb_value_destinations, tb_destinations where tb_value_destinations.id = tb_destinations.id;
END $$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE sp_get_single_destination(id_ int)
BEGIN
  SELECT id name, address, description, x, y, image FROM tb_destinations where tb_destinations.id = id_;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_get_data_site_information(name_ varchar(200))
BEGIN
  SELECT id, name, address, description, x, y, image FROM tb_destinations where tb_destinations.name = name_;
END $$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE sp_get_all_name_site()
BEGIN
  SELECT name FROM tb_destinations;
END $$
DELIMITER ;




/**********************************************INSERCIONES DE DATOS DE SITIOS TURISTICOS*****************************************/

call insert_new_destination('e','r','b','a','v','natural','Monumento nacional Guayabo','Santa Teresita Turrialba Cartago','El Monumento Nacional Guayabo es un area protegida de Costa Rica. En ella contiene uno de los sitios arqueologicos mas antiguos del pais.','9.971152','-83.690749','public/img/1.jpg');
call insert_new_destination('i','u','y','c','p','natural','Monumento nacional Guayabo','Santa Teresita Turrialba Cartago','El Monumento Nacional Guayabo es un area protegida de Costa Rica. En ella contiene uno de los sitios arqueologicos mas antiguos del pais.','9.971152','-83.690749','public/img/1.jpg');
call insert_new_destination('i','u','b','c','v','natural','Monumento nacional Guayabo','Santa Teresita Turrialba Cartago','El Monumento Nacional Guayabo es un area protegida de Costa Rica. En ella contiene uno de los sitios arqueologicos mas antiguos del pais.','9.971152','-83.690749','public/img/1.jpg');
call insert_new_destination('e','r','b','c','p','natural','Monumento nacional Guayabo','Santa Teresita Turrialba Cartago','El Monumento Nacional Guayabo es un area protegida de Costa Rica. En ella contiene uno de los sitios arqueologicos mas antiguos del pais.','9.971152','-83.690749','public/img/1.jpg');
call insert_new_destination('c','r','y','c','v','natural','Monumento nacional Guayabo','Santa Teresita Turrialba Cartago','El Monumento Nacional Guayabo es un area protegida de Costa Rica. En ella contiene uno de los sitios arqueologicos mas antiguos del pais.','9.971152','-83.690749','public/img/1.jpg');
call insert_new_destination('i','u','b','b','p','natural','Monumento nacional Guayabo','Santa Teresita Turrialba Cartago','El Monumento Nacional Guayabo es un area protegida de Costa Rica. En ella contiene uno de los sitios arqueologicos mas antiguos del pais.','9.971152','-83.690749','public/img/1.jpg');

call insert_new_destination('c','r','b','a','p','hotel','Hacienda Tayutic','Sitio de Mata, Turrialba, Cartago','En el Hotel Hacienda Tayutic la naturaleza y el arte forman parte esencial de la experiencia.' ,'9.881494','-83.627633','public/img/2.jpg');
call insert_new_destination('i','u','y','c','v','hotel','Hacienda Tayutic','Sitio de Mata, Turrialba, Cartago','En el Hotel Hacienda Tayutic la naturaleza y el arte forman parte esencial de la experiencia.' ,'9.881494','-83.627633','public/img/2.jpg');
call insert_new_destination('e','u','b','c','p','hotel','Hacienda Tayutic','Sitio de Mata, Turrialba, Cartago','En el Hotel Hacienda Tayutic la naturaleza y el arte forman parte esencial de la experiencia.' ,'9.881494','-83.627633','public/img/2.jpg');
call insert_new_destination('c','u','b','c','p','hotel','Hacienda Tayutic','Sitio de Mata, Turrialba, Cartago','En el Hotel Hacienda Tayutic la naturaleza y el arte forman parte esencial de la experiencia.' ,'9.881494','-83.627633','public/img/2.jpg');
call insert_new_destination('e','u','b','c','p','hotel','Hacienda Tayutic','Sitio de Mata, Turrialba, Cartago','En el Hotel Hacienda Tayutic la naturaleza y el arte forman parte esencial de la experiencia.' ,'9.881494','-83.627633','public/img/2.jpg');
call insert_new_destination('c','r','y','c','p','hotel','Hacienda Tayutic','Sitio de Mata, Turrialba, Cartago','En el Hotel Hacienda Tayutic la naturaleza y el arte forman parte esencial de la experiencia.' ,'9.881494','-83.627633','public/img/2.jpg');

call insert_new_destination('e','r','b','a','p','natural','Paque Nacional Volcan Turrialba','Turrialba, Cartago','Desde varios puntos de la cima y en un dia despejado, se puede tener una vista panoramica de las llanuras del Caribe.','10.017519','-83.764965','public/img/5.jpeg');
call insert_new_destination('c','r','y','b','v','natural','Paque Nacional Volcan Turrialba','Turrialba, Cartago','Desde varios puntos de la cima y en un dia despejado, se puede tener una vista panoramica de las llanuras del Caribe.','10.017519','-83.764965','public/img/5.jpeg');
call insert_new_destination('c','r','y','a','p','natural','Paque Nacional Volcan Turrialba','Turrialba, Cartago','Desde varios puntos de la cima y en un dia despejado, se puede tener una vista panoramica de las llanuras del Caribe.','10.017519','-83.764965','public/img/5.jpeg');
call insert_new_destination('c','r','y','b','v','natural','Paque Nacional Volcan Turrialba','Turrialba, Cartago','Desde varios puntos de la cima y en un dia despejado, se puede tener una vista panoramica de las llanuras del Caribe.','10.017519','-83.764965','public/img/5.jpeg');
call insert_new_destination('i','r','b','a','p','natural','Paque Nacional Volcan Turrialba','Turrialba, Cartago','Desde varios puntos de la cima y en un dia despejado, se puede tener una vista panoramica de las llanuras del Caribe.','10.017519','-83.764965','public/img/5.jpeg');
call insert_new_destination('e','u','b','a','p','natural','Paque Nacional Volcan Turrialba','Turrialba, Cartago','Desde varios puntos de la cima y en un dia despejado, se puede tener una vista panoramica de las llanuras del Caribe.','10.017519','-83.764965','public/img/5.jpeg');
call insert_new_destination('e','u','b','a','p','natural','Paque Nacional Volcan Turrialba','Turrialba, Cartago','Desde varios puntos de la cima y en un dia despejado, se puede tener una vista panoramica de las llanuras del Caribe.','10.017519','-83.764965','public/img/5.jpeg');

call insert_new_destination('e','u','b','a','v','paradero','Paradero Turistico San Buenaventura','Turrialba, Cartago','El Paradero Turistico San Buenaventura se encuentra alejado del ruido y rodeado de naturaleza.','9.873350','-83.645082','public/img/4.jpg');
call insert_new_destination('i','r','y','c','p','paradero','Paradero Turistico San Buenaventura','Turrialba, Cartago','El Paradero Turistico San Buenaventura se encuentra alejado del ruido y rodeado de naturaleza.','9.873350','-83.645082','public/img/4.jpg');
call insert_new_destination('c','u','b','a','v','paradero','Paradero Turistico San Buenaventura','Turrialba, Cartago','El Paradero Turistico San Buenaventura se encuentra alejado del ruido y rodeado de naturaleza.','9.873350','-83.645082','public/img/4.jpg');
call insert_new_destination('e','r','y','c','p','paradero','Paradero Turistico San Buenaventura','Turrialba, Cartago','El Paradero Turistico San Buenaventura se encuentra alejado del ruido y rodeado de naturaleza.','9.873350','-83.645082','public/img/4.jpg');
call insert_new_destination('e','u','y','a','p','paradero','Paradero Turistico San Buenaventura','Turrialba, Cartago','El Paradero Turistico San Buenaventura se encuentra alejado del ruido y rodeado de naturaleza.','9.873350','-83.645082','public/img/4.jpg');

call insert_new_destination('e','u','b','a','v','paradero','Jardin Botanico CATIE','Turrialba, Cartago','Un lugar especial para el descanso, rodeado del canto de las aves, el susurro del gigantesco arbol de Guanacaste.','9.896788','-83.657440','public/img/3.jpg');
call insert_new_destination('e','r','b','c','v','paradero','Jardin Botanico CATIE','Turrialba, Cartago','Un lugar especial para el descanso, rodeado del canto de las aves, el susurro del gigantesco arbol de Guanacaste.','9.896788','-83.657440','public/img/3.jpg');
call insert_new_destination('c','r','b','b','p','paradero','Jardin Botanico CATIE','Turrialba, Cartago','Un lugar especial para el descanso, rodeado del canto de las aves, el susurro del gigantesco arbol de Guanacaste.','9.896788','-83.657440','public/img/3.jpg');
call insert_new_destination('c','r','y','a','v','paradero','Jardin Botanico CATIE','Turrialba, Cartago','Un lugar especial para el descanso, rodeado del canto de las aves, el susurro del gigantesco arbol de Guanacaste.','9.896788','-83.657440','public/img/3.jpg');
call insert_new_destination('c','u','y','c','p','paradero','Jardin Botanico CATIE','Turrialba, Cartago','Un lugar especial para el descanso, rodeado del canto de las aves, el susurro del gigantesco arbol de Guanacaste.','9.896788','-83.657440','public/img/3.jpg');

call insert_new_destination('c','r','b','b','v','restaurante','Rancho El Sapito','Coliblanco de Alavarado, Cartago','El Restaurante es amplio y con una atmosfera muy agradable, ideal para disfrutar con familiares y amigos.','9.944200','-83.775514','public/img/6.jpg');
call insert_new_destination('c','u','b','c','p','restaurante','Rancho El Sapito','Coliblanco de Alavarado, Cartago','El Restaurante es amplio y con una atmosfera muy agradable, ideal para disfrutar con familiares y amigos.','9.944200','-83.775514','public/img/6.jpg');
call insert_new_destination('c','r','b','b','v','restaurante','Rancho El Sapito','Coliblanco de Alavarado, Cartago','El Restaurante es amplio y con una atmosfera muy agradable, ideal para disfrutar con familiares y amigos.','9.944200','-83.775514','public/img/6.jpg');
call insert_new_destination('c','u','y','c','p','restaurante','Rancho El Sapito','Coliblanco de Alavarado, Cartago','El Restaurante es amplio y con una atmosfera muy agradable, ideal para disfrutar con familiares y amigos.','9.944200','-83.775514','public/img/6.jpg');
call insert_new_destination('i','u','b','b','p','restaurante','Rancho El Sapito','Coliblanco de Alavarado, Cartago','El Restaurante es amplio y con una atmosfera muy agradable, ideal para disfrutar con familiares y amigos.','9.944200','-83.775514','public/img/6.jpg');
call insert_new_destination('e','r','y','c','v','restaurante','Rancho El Sapito','Coliblanco de Alavarado, Cartago','El Restaurante es amplio y con una atmosfera muy agradable, ideal para disfrutar con familiares y amigos.','9.944200','-83.775514','public/img/6.jpg');

call insert_new_destination('e','r','b','a','p','paradero','Centro Turstico Don Ismael','La Suiza, Turrialba, Cartago','Aqui encontrara lo que necesita para el disfrute personal o familiar. Rodeado de un clima simplemente sabroso.','9.858720','-83.612436','public/img/7.jpg');
call insert_new_destination('i','r','y','b','v','paradero','Centro Turstico Don Ismael','La Suiza, Turrialba, Cartago','Aqui encontrara lo que necesita para el disfrute personal o familiar. Rodeado de un clima simplemente sabroso.','9.858720','-83.612436','public/img/7.jpg');
call insert_new_destination('i','r','y','c','v','paradero','Centro Turstico Don Ismael','La Suiza, Turrialba, Cartago','Aqui encontrara lo que necesita para el disfrute personal o familiar. Rodeado de un clima simplemente sabroso.','9.858720','-83.612436','public/img/7.jpg');
call insert_new_destination('c','u','b','c','p','paradero','Centro Turstico Don Ismael','La Suiza, Turrialba, Cartago','Aqui encontrara lo que necesita para el disfrute personal o familiar. Rodeado de un clima simplemente sabroso.','9.858720','-83.612436','public/img/7.jpg');
call insert_new_destination('e','u','y','a','v','paradero','Centro Turstico Don Ismael','La Suiza, Turrialba, Cartago','Aqui encontrara lo que necesita para el disfrute personal o familiar. Rodeado de un clima simplemente sabroso.','9.858720','-83.612436','public/img/7.jpg');
call insert_new_destination('c','r','y','a','v','paradero','Centro Turstico Don Ismael','La Suiza, Turrialba, Cartago','Aqui encontrara lo que necesita para el disfrute personal o familiar. Rodeado de un clima simplemente sabroso.','9.858720','-83.612436','public/img/7.jpg');

call insert_new_destination('c','r','b','b','p','hotel','Casa Turire','Atirro, Turrialba, Cartago','Este hermoso lugar esta envuelto por el Lago Angostura presenta un panorama fuera de serie.','9.862575','-83.645109','public/img/8.jpg');
call insert_new_destination('e','u','b','a','v','hotel','Casa Turire','Atirro, Turrialba, Cartago','Este hermoso lugar esta envuelto por el Lago Angostura presenta un panorama fuera de serie.','9.862575','-83.645109','public/img/8.jpg');
call insert_new_destination('c','u','y','a','p','hotel','Casa Turire','Atirro, Turrialba, Cartago','Este hermoso lugar esta envuelto por el Lago Angostura presenta un panorama fuera de serie.','9.862575','-83.645109','public/img/8.jpg');
call insert_new_destination('c','r','b','b','p','hotel','Casa Turire','Atirro, Turrialba, Cartago','Este hermoso lugar esta envuelto por el Lago Angostura presenta un panorama fuera de serie.','9.862575','-83.645109','public/img/8.jpg');
call insert_new_destination('e','u','b','a','p','hotel','Casa Turire','Atirro, Turrialba, Cartago','Este hermoso lugar esta envuelto por el Lago Angostura presenta un panorama fuera de serie.','9.862575','-83.645109','public/img/8.jpg');
call insert_new_destination('e','r','y','b','p','hotel','Casa Turire','Atirro, Turrialba, Cartago','Este hermoso lugar esta envuelto por el Lago Angostura presenta un panorama fuera de serie.','9.862575','-83.645109','public/img/8.jpg');

call insert_new_destination('c','r','b','a','p','hotel','Hotel Villa Florencia','Susanita, Turrialba, Cartago','Hotel Villa Florencia le ofrece el lugar ideal para descansar en uno de los lugares mas pintorescos del Valle de Turrialba.','9.873942','-83.659198','public/img/9.jpg');
call insert_new_destination('i','u','y','a','p','hotel','Hotel Villa Florencia','Susanita, Turrialba, Cartago','Hotel Villa Florencia le ofrece el lugar ideal para descansar en uno de los lugares mas pintorescos del Valle de Turrialba.','9.873942','-83.659198','public/img/9.jpg');
call insert_new_destination('e','u','b','a','v','hotel','Hotel Villa Florencia','Susanita, Turrialba, Cartago','Hotel Villa Florencia le ofrece el lugar ideal para descansar en uno de los lugares mas pintorescos del Valle de Turrialba.','9.873942','-83.659198','public/img/9.jpg');
call insert_new_destination('i','u','b','c','v','hotel','Hotel Villa Florencia','Susanita, Turrialba, Cartago','Hotel Villa Florencia le ofrece el lugar ideal para descansar en uno de los lugares mas pintorescos del Valle de Turrialba.','9.873942','-83.659198','public/img/9.jpg');
call insert_new_destination('c','u','y','a','p','hotel','Hotel Villa Florencia','Susanita, Turrialba, Cartago','Hotel Villa Florencia le ofrece el lugar ideal para descansar en uno de los lugares mas pintorescos del Valle de Turrialba.','9.873942','-83.659198','public/img/9.jpg');
call insert_new_destination('c','u','b','a','v','hotel','Hotel Villa Florencia','Susanita, Turrialba, Cartago','Hotel Villa Florencia le ofrece el lugar ideal para descansar en uno de los lugares mas pintorescos del Valle de Turrialba.','9.873942','-83.659198','public/img/9.jpg');

call insert_new_destination('e','r','b','a','p','restaurante','Restaurante Mirador Sitios Angostura','Sitio de Mata, Turrialba, Cartago','Desde alli hay una excelente vista de la represa Angostura. Mientras usted come uno que otro colibri se acerca a comer tambien.','9.889716','-83.630128','public/img/10.jpg');
call insert_new_destination('e','u','b','b','v','restaurante','Restaurante Mirador Sitios Angostura','Sitio de Mata, Turrialba, Cartago','Desde alli hay una excelente vista de la represa Angostura. Mientras usted come uno que otro colibri se acerca a comer tambien.','9.889716','-83.630128','public/img/10.jpg');
call insert_new_destination('c','r','y','c','p','restaurante','Restaurante Mirador Sitios Angostura','Sitio de Mata, Turrialba, Cartago','Desde alli hay una excelente vista de la represa Angostura. Mientras usted come uno que otro colibri se acerca a comer tambien.','9.889716','-83.630128','public/img/10.jpg');
call insert_new_destination('e','r','y','b','p','restaurante','Restaurante Mirador Sitios Angostura','Sitio de Mata, Turrialba, Cartago','Desde alli hay una excelente vista de la represa Angostura. Mientras usted come uno que otro colibri se acerca a comer tambien.','9.889716','-83.630128','public/img/10.jpg');
call insert_new_destination('e','u','b','a','p','restaurante','Restaurante Mirador Sitios Angostura','Sitio de Mata, Turrialba, Cartago','Desde alli hay una excelente vista de la represa Angostura. Mientras usted come uno que otro colibri se acerca a comer tambien.','9.889716','-83.630128','public/img/10.jpg');
call insert_new_destination('e','r','b','c','v','restaurante','Restaurante Mirador Sitios Angostura','Sitio de Mata, Turrialba, Cartago','Desde alli hay una excelente vista de la represa Angostura. Mientras usted come uno que otro colibri se acerca a comer tambien.','9.889716','-83.630128','public/img/10.jpg');
