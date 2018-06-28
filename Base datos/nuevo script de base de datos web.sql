/*TABLAS*/

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

/*SP*/

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

DELIMITER $$
CREATE procedure sp_insert(
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
    
    SELECT distinct tb_destinations.id, name, address, description, x, y, image, price, preference_place, destination_type, travel_time, road_type
    FROM tb_value_destinations, tb_destinations 
    WHERE (tb_value_destinations.id_destination = tb_destinations.id and tb_value_destinations.class=category_);

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
CREATE PROCEDURE sp_delete_destination(
    destination_id INTEGER
    )
    BEGIN
        DECLARE nc,m,n,id_,attribute_id_,total_n_,id_temp,repetition_,id_value INTEGER;
        DECLARE p decimal(19,7);
        DECLARE topCount,currCount INTEGER;
        DECLARE topCountValues,currCountValues INTEGER;
        DECLARE topCountCategory,currCountCategory INTEGER;
        DECLARE attribute_name_,attribute_value_,category_ VARCHAR(100);
        DECLARE temp_price, temp_preference_place, temp_destination_type, temp_travel_time, temp_road_type CHAR;
        DECLARE temp_class VARCHAR(100);

        /*BORRADO DE CUALQUIER REGISTRO DE LAS TABLAS QUE SE USARAN COMO TEMPORALES*/
        SET SQL_SAFE_UPDATES = 0;
        DELETE FROM TMPCategory;
        DELETE FROM TMPValues;
        DELETE FROM TMP;
        SET SQL_SAFE_UPDATES = 1;  
        
        /*seccion para eliminar los valores asociados al registro que se desea eliminar*/
        
        SET id_temp=(SELECT id FROM tb_value_destinations WHERE tb_value_destinations.id_destination= destination_id LIMIT 1);
        SET temp_price=(SELECT price FROM tb_value_destinations WHERE id=id_temp);
        SET temp_preference_place=(SELECT preference_place FROM tb_value_destinations WHERE id=id_temp);
        SET temp_destination_type=(SELECT destination_type FROM tb_value_destinations WHERE id=id_temp);
        SET temp_travel_time=(SELECT travel_time FROM tb_value_destinations WHERE id=id_temp);
        SET temp_road_type=(SELECT road_type FROM tb_value_destinations WHERE id=id_temp);
        SET temp_class=(SELECT class FROM tb_value_destinations WHERE id=id_temp);
       
       
        /*TABLA TEMPORAL PARA ALMACENAR LOS DATOS DE LA NUEVA INSERCION*/
        INSERT INTO TMP (id,attribute_name,attribute_value)
        VALUES (1,'price',temp_price),(2,'preference_place',temp_preference_place),
        (3,'destination_type',temp_destination_type),(4,'travel_time',temp_travel_time),(5,'road_type',temp_road_type);

        /*SETEO DE LOS CONTADORES PARA EL WHILE*/
        SET topCount= (SELECT COUNT(*) FROM TMP);
        SET currCount=0;

        /*SECCION PARA */
        WHILE currCount < topCount Do 
            /*SETEO DE VARIABLES GENERALES*/
            SET id_= (SELECT id FROM TMP WHERE active=1 LIMIT 1);
            SET attribute_name_= (SELECT attribute_name FROM TMP WHERE active=1 LIMIT 1);
            SET attribute_value_= (SELECT attribute_value FROM TMP WHERE active=1 LIMIT 1);
            
            IF NOT EXISTS (SELECT * FROM tb_destinations_probabilities WHERE attribute_value=attribute_value_ AND repetition > 1) THEN
                SET SQL_SAFE_UPDATES = 0; 
                UPDATE tb_destinations_values SET repetition=0 WHERE attribute_name=attribute_name_ ;
                DELETE FROM tb_destinations_differences WHERE attribute_value=attribute_value_;
                SET SQL_SAFE_UPDATES = 1;          
            END IF;                
            
            SET SQL_SAFE_UPDATES = 0; 
            UPDATE tb_destinations_probabilities SET repetition=repetition-1 
            WHERE attribute_name=attribute_name_ AND  attribute_value=attribute_value_ AND temp_class=category;
            SET SQL_SAFE_UPDATES = 1;  
            
            IF EXISTS (SELECT * FROM tb_destinations_probabilities WHERE attribute_name=attribute_name_ AND  attribute_value=attribute_value_ AND temp_class=category AND repetition=0) THEN
                SET SQL_SAFE_UPDATES = 0; 
                DELETE FROM tb_destinations_probabilities WHERE attribute_name=attribute_name_ AND  attribute_value=attribute_value_ AND repetition=0;
                SET SQL_SAFE_UPDATES = 1;          
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
        
        SET SQL_SAFE_UPDATES = 0; 
        UPDATE tb_destinations_values SET repetition=repetition-1 WHERE attribute_name=temp_class ;
        SET SQL_SAFE_UPDATES = 1; 
        
        IF EXISTS (SELECT * FROM tb_destinations_values WHERE attribute_name=temp_class AND repetition=0) THEN
            SET SQL_SAFE_UPDATES = 0; 
            DELETE FROM tb_destinations_values WHERE attribute_name=temp_class AND repetition=0;
            DELETE FROM tb_destinations_prior_probabilities WHERE category=temp_class;
            SET SQL_SAFE_UPDATES = 1;          
        END IF;  
        
        SET SQL_SAFE_UPDATES = 0; 
         DELETE FROM tb_value_destinations WHERE id=id_temp;
        SET SQL_SAFE_UPDATES = 1; 
        
        IF NOT EXISTS (SELECT * FROM tb_value_destinations WHERE id_destination=destination_id) THEN
            SET SQL_SAFE_UPDATES = 0; 
            DELETE FROM tb_destinations WHERE id=destination_id;
            SET SQL_SAFE_UPDATES = 1;          
        END IF; 
        
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

DELIMITER $$
CREATE procedure sp_delete(
    destination_id INTEGER
) 
BEGIN

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
    
    call sp_delete_destination(destination_id);
   
    SELECT '1' as result;
    COMMIT;
END $$
DELIMITER ;

DELIMITER $$
CREATE procedure sp_update(
    destination_id INTEGER,
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
    
    call sp_delete_destination(destination_id);
    call sp_insert(new_price, new_preference_place, new_destination_type, new_travel_time, new_road_type, new_class,new_name,new_address,new_description, new_x,new_y,new_image);
    
    SELECT '1' as result;
    COMMIT;
END $$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE sp_get_all_name_site()
BEGIN
  SELECT id,name FROM tb_destinations;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_get_destination(
    id_destination INTEGER
)
BEGIN
    SELECT tb_destinations.id, name, address, description, x, y, image, price, preference_place, destination_type, travel_time, road_type,class
    FROM tb_value_destinations, tb_destinations 
    where tb_value_destinations.id_destination = tb_destinations.id AND id_destination=tb_destinations.id;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_get_all_destinations()
BEGIN
  SELECT tb_destinations.id, name, address, description, x, y, image, price, preference_place, destination_type, travel_time, road_type
            FROM tb_value_destinations, tb_destinations where tb_value_destinations.id_destination = tb_destinations.id;
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

call sp_insert(
'c','u','b','a','v','hotel',
'Rancho San Rafael','Turrialba, Cartago','Paradero Turistico','9.903657','-83.670802','public/img/24.png'
);

insert into tb_destinations_values (id,attribute_name,repetition,discriminant)
values (1,'price',0,0), (2,'preference_place',0,0), (3,'destination_type',0,0), 
(4,'travel_time',0,0),(5,'road_type',0,0);

insert into tb_user values('admin','admin')

select * from tb_user

select * from tb_destinations
select * from tb_destinations_values
select * from tb_destinations_differences
select * from tb_destinations_probabilities
select * from tb_destinations_prior_probabilities
select * from tb_value_destinations

        SET SQL_SAFE_UPDATES = 0;
        delete from tb_destinations_values;
delete from tb_destinations_differences;
delete from tb_destinations_probabilities;
delete from tb_destinations_prior_probabilities;
delete from tb_value_destinations;
delete from tb_destinations;
        SET SQL_SAFE_UPDATES = 1;
        

call sp_insert('e','r','b','a','v','natural','Monumento nacional Guayabo','Santa Teresita Turrialba Cartago','El Monumento Nacional Guayabo es un area protegida de Costa Rica. En ella contiene uno de los sitios arqueologicos mas antiguos del pais.','9.971152','-83.690749','public/img/1.jpg');
call sp_insert('i','u','y','c','p','natural','Monumento nacional Guayabo','Santa Teresita Turrialba Cartago','El Monumento Nacional Guayabo es un area protegida de Costa Rica. En ella contiene uno de los sitios arqueologicos mas antiguos del pais.','9.971152','-83.690749','public/img/1.jpg');
call sp_insert('i','u','b','c','v','natural','Monumento nacional Guayabo','Santa Teresita Turrialba Cartago','El Monumento Nacional Guayabo es un area protegida de Costa Rica. En ella contiene uno de los sitios arqueologicos mas antiguos del pais.','9.971152','-83.690749','public/img/1.jpg');
call sp_insert('e','r','b','c','p','natural','Monumento nacional Guayabo','Santa Teresita Turrialba Cartago','El Monumento Nacional Guayabo es un area protegida de Costa Rica. En ella contiene uno de los sitios arqueologicos mas antiguos del pais.','9.971152','-83.690749','public/img/1.jpg');
call sp_insert('c','r','y','c','v','natural','Monumento nacional Guayabo','Santa Teresita Turrialba Cartago','El Monumento Nacional Guayabo es un area protegida de Costa Rica. En ella contiene uno de los sitios arqueologicos mas antiguos del pais.','9.971152','-83.690749','public/img/1.jpg');
call sp_insert('i','u','b','b','p','natural','Monumento nacional Guayabo','Santa Teresita Turrialba Cartago','El Monumento Nacional Guayabo es un area protegida de Costa Rica. En ella contiene uno de los sitios arqueologicos mas antiguos del pais.','9.971152','-83.690749','public/img/1.jpg');
call sp_insert('i','u','y','c','v','natural','Monumento nacional Guayabo','Santa Teresita Turrialba Cartago','El Monumento Nacional Guayabo es un area protegida de Costa Rica. En ella contiene uno de los sitios arqueologicos mas antiguos del pais.','9.971152','-83.690749','public/img/1.jpg');

call sp_insert('c','r','b','a','p','hotel','Hacienda Tayutic','Sitio de Mata, Turrialba, Cartago','En el Hotel Hacienda Tayutic la naturaleza y el arte forman parte esencial de la experiencia.' ,'9.881494','-83.627633','public/img/2.jpg');
call sp_insert('i','u','y','c','v','hotel','Hacienda Tayutic','Sitio de Mata, Turrialba, Cartago','En el Hotel Hacienda Tayutic la naturaleza y el arte forman parte esencial de la experiencia.' ,'9.881494','-83.627633','public/img/2.jpg');
call sp_insert('e','u','b','c','p','hotel','Hacienda Tayutic','Sitio de Mata, Turrialba, Cartago','En el Hotel Hacienda Tayutic la naturaleza y el arte forman parte esencial de la experiencia.' ,'9.881494','-83.627633','public/img/2.jpg');
call sp_insert('c','u','b','c','p','hotel','Hacienda Tayutic','Sitio de Mata, Turrialba, Cartago','En el Hotel Hacienda Tayutic la naturaleza y el arte forman parte esencial de la experiencia.' ,'9.881494','-83.627633','public/img/2.jpg');
call sp_insert('e','u','b','c','p','hotel','Hacienda Tayutic','Sitio de Mata, Turrialba, Cartago','En el Hotel Hacienda Tayutic la naturaleza y el arte forman parte esencial de la experiencia.' ,'9.881494','-83.627633','public/img/2.jpg');
call sp_insert('c','r','y','c','p','hotel','Hacienda Tayutic','Sitio de Mata, Turrialba, Cartago','En el Hotel Hacienda Tayutic la naturaleza y el arte forman parte esencial de la experiencia.' ,'9.881494','-83.627633','public/img/2.jpg');
call sp_insert('c','r','y','a','p','hotel','Hacienda Tayutic','Sitio de Mata, Turrialba, Cartago','En el Hotel Hacienda Tayutic la naturaleza y el arte forman parte esencial de la experiencia.' ,'9.881494','-83.627633','public/img/2.jpg');

call sp_insert('e','r','b','a','p','natural','Paque Nacional Volcan Turrialba','Turrialba, Cartago','Desde varios puntos de la cima y en un dia despejado, se puede tener una vista panoramica de las llanuras del Caribe.','10.017519','-83.764965','public/img/5.jpeg');
call sp_insert('c','r','y','b','v','natural','Paque Nacional Volcan Turrialba','Turrialba, Cartago','Desde varios puntos de la cima y en un dia despejado, se puede tener una vista panoramica de las llanuras del Caribe.','10.017519','-83.764965','public/img/5.jpeg');
call sp_insert('c','r','y','a','p','natural','Paque Nacional Volcan Turrialba','Turrialba, Cartago','Desde varios puntos de la cima y en un dia despejado, se puede tener una vista panoramica de las llanuras del Caribe.','10.017519','-83.764965','public/img/5.jpeg');
call sp_insert('c','r','y','b','v','natural','Paque Nacional Volcan Turrialba','Turrialba, Cartago','Desde varios puntos de la cima y en un dia despejado, se puede tener una vista panoramica de las llanuras del Caribe.','10.017519','-83.764965','public/img/5.jpeg');
call sp_insert('i','r','b','a','p','natural','Paque Nacional Volcan Turrialba','Turrialba, Cartago','Desde varios puntos de la cima y en un dia despejado, se puede tener una vista panoramica de las llanuras del Caribe.','10.017519','-83.764965','public/img/5.jpeg');
call sp_insert('e','u','b','a','p','natural','Paque Nacional Volcan Turrialba','Turrialba, Cartago','Desde varios puntos de la cima y en un dia despejado, se puede tener una vista panoramica de las llanuras del Caribe.','10.017519','-83.764965','public/img/5.jpeg');
call sp_insert('e','u','b','a','p','natural','Paque Nacional Volcan Turrialba','Turrialba, Cartago','Desde varios puntos de la cima y en un dia despejado, se puede tener una vista panoramica de las llanuras del Caribe.','10.017519','-83.764965','public/img/5.jpeg');

call sp_insert('e','u','b','a','v','paradero','Paradero Turistico San Buenaventura','Turrialba, Cartago','El Paradero Turistico San Buenaventura se encuentra alejado del ruido y rodeado de naturaleza.','9.873350','-83.645082','public/img/4.jpg');
call sp_insert('i','r','y','c','p','paradero','Paradero Turistico San Buenaventura','Turrialba, Cartago','El Paradero Turistico San Buenaventura se encuentra alejado del ruido y rodeado de naturaleza.','9.873350','-83.645082','public/img/4.jpg');
call sp_insert('c','u','b','a','v','paradero','Paradero Turistico San Buenaventura','Turrialba, Cartago','El Paradero Turistico San Buenaventura se encuentra alejado del ruido y rodeado de naturaleza.','9.873350','-83.645082','public/img/4.jpg');
call sp_insert('e','r','y','c','p','paradero','Paradero Turistico San Buenaventura','Turrialba, Cartago','El Paradero Turistico San Buenaventura se encuentra alejado del ruido y rodeado de naturaleza.','9.873350','-83.645082','public/img/4.jpg');
call sp_insert('e','u','y','a','p','paradero','Paradero Turistico San Buenaventura','Turrialba, Cartago','El Paradero Turistico San Buenaventura se encuentra alejado del ruido y rodeado de naturaleza.','9.873350','-83.645082','public/img/4.jpg');

call sp_insert('e','u','b','a','v','paradero','Jardin Botanico CATIE','Turrialba, Cartago','Un lugar especial para el descanso, rodeado del canto de las aves, el susurro del gigantesco arbol de Guanacaste.','9.896788','-83.657440','public/img/3.jpg');
call sp_insert('e','r','b','c','v','paradero','Jardin Botanico CATIE','Turrialba, Cartago','Un lugar especial para el descanso, rodeado del canto de las aves, el susurro del gigantesco arbol de Guanacaste.','9.896788','-83.657440','public/img/3.jpg');
call sp_insert('c','r','b','b','p','paradero','Jardin Botanico CATIE','Turrialba, Cartago','Un lugar especial para el descanso, rodeado del canto de las aves, el susurro del gigantesco arbol de Guanacaste.','9.896788','-83.657440','public/img/3.jpg');
call sp_insert('c','r','y','a','v','paradero','Jardin Botanico CATIE','Turrialba, Cartago','Un lugar especial para el descanso, rodeado del canto de las aves, el susurro del gigantesco arbol de Guanacaste.','9.896788','-83.657440','public/img/3.jpg');
call sp_insert('c','u','y','c','p','paradero','Jardin Botanico CATIE','Turrialba, Cartago','Un lugar especial para el descanso, rodeado del canto de las aves, el susurro del gigantesco arbol de Guanacaste.','9.896788','-83.657440','public/img/3.jpg');

call sp_insert('c','r','b','b','v','restaurante','Rancho El Sapito','Coliblanco de Alavarado, Cartago','El Restaurante es amplio y con una atmosfera muy agradable, ideal para disfrutar con familiares y amigos.','9.944200','-83.775514','public/img/6.jpg');
call sp_insert('c','u','b','c','p','restaurante','Rancho El Sapito','Coliblanco de Alavarado, Cartago','El Restaurante es amplio y con una atmosfera muy agradable, ideal para disfrutar con familiares y amigos.','9.944200','-83.775514','public/img/6.jpg');
call sp_insert('c','r','b','b','v','restaurante','Rancho El Sapito','Coliblanco de Alavarado, Cartago','El Restaurante es amplio y con una atmosfera muy agradable, ideal para disfrutar con familiares y amigos.','9.944200','-83.775514','public/img/6.jpg');
call sp_insert('c','u','y','c','p','restaurante','Rancho El Sapito','Coliblanco de Alavarado, Cartago','El Restaurante es amplio y con una atmosfera muy agradable, ideal para disfrutar con familiares y amigos.','9.944200','-83.775514','public/img/6.jpg');
call sp_insert('i','u','b','b','p','restaurante','Rancho El Sapito','Coliblanco de Alavarado, Cartago','El Restaurante es amplio y con una atmosfera muy agradable, ideal para disfrutar con familiares y amigos.','9.944200','-83.775514','public/img/6.jpg');
call sp_insert('e','r','y','c','v','restaurante','Rancho El Sapito','Coliblanco de Alavarado, Cartago','El Restaurante es amplio y con una atmosfera muy agradable, ideal para disfrutar con familiares y amigos.','9.944200','-83.775514','public/img/6.jpg');

call sp_insert('e','r','b','a','p','paradero','Centro Turistico Don Ismael','La Suiza, Turrialba, Cartago','Aqui encontrara lo que necesita para el disfrute personal o familiar. Rodeado de un clima simplemente sabroso.','9.858720','-83.612436','public/img/7.jpg');
call sp_insert('i','r','y','b','v','paradero','Centro Turistico Don Ismael','La Suiza, Turrialba, Cartago','Aqui encontrara lo que necesita para el disfrute personal o familiar. Rodeado de un clima simplemente sabroso.','9.858720','-83.612436','public/img/7.jpg');
call sp_insert('i','r','y','c','v','paradero','Centro Turistico Don Ismael','La Suiza, Turrialba, Cartago','Aqui encontrara lo que necesita para el disfrute personal o familiar. Rodeado de un clima simplemente sabroso.','9.858720','-83.612436','public/img/7.jpg');
call sp_insert('c','u','b','c','p','paradero','Centro Turistico Don Ismael','La Suiza, Turrialba, Cartago','Aqui encontrara lo que necesita para el disfrute personal o familiar. Rodeado de un clima simplemente sabroso.','9.858720','-83.612436','public/img/7.jpg');
call sp_insert('e','u','y','a','v','paradero','Centro Turistico Don Ismael','La Suiza, Turrialba, Cartago','Aqui encontrara lo que necesita para el disfrute personal o familiar. Rodeado de un clima simplemente sabroso.','9.858720','-83.612436','public/img/7.jpg');
call sp_insert('c','r','y','a','v','paradero','Centro Turistico Don Ismael','La Suiza, Turrialba, Cartago','Aqui encontrara lo que necesita para el disfrute personal o familiar. Rodeado de un clima simplemente sabroso.','9.858720','-83.612436','public/img/7.jpg');

call sp_insert('c','r','b','b','p','hotel','Casa Turire','Atirro, Turrialba, Cartago','Este hermoso lugar esta envuelto por el Lago Angostura presenta un panorama fuera de serie.','9.862575','-83.645109','public/img/8.jpg');
call sp_insert('e','u','b','a','v','hotel','Casa Turire','Atirro, Turrialba, Cartago','Este hermoso lugar esta envuelto por el Lago Angostura presenta un panorama fuera de serie.','9.862575','-83.645109','public/img/8.jpg');
call sp_insert('c','u','y','a','p','hotel','Casa Turire','Atirro, Turrialba, Cartago','Este hermoso lugar esta envuelto por el Lago Angostura presenta un panorama fuera de serie.','9.862575','-83.645109','public/img/8.jpg');
call sp_insert('c','r','b','b','p','hotel','Casa Turire','Atirro, Turrialba, Cartago','Este hermoso lugar esta envuelto por el Lago Angostura presenta un panorama fuera de serie.','9.862575','-83.645109','public/img/8.jpg');
call sp_insert('e','u','b','a','p','hotel','Casa Turire','Atirro, Turrialba, Cartago','Este hermoso lugar esta envuelto por el Lago Angostura presenta un panorama fuera de serie.','9.862575','-83.645109','public/img/8.jpg');
call sp_insert('e','r','y','b','p','hotel','Casa Turire','Atirro, Turrialba, Cartago','Este hermoso lugar esta envuelto por el Lago Angostura presenta un panorama fuera de serie.','9.862575','-83.645109','public/img/8.jpg');

call sp_insert('c','r','b','a','p','hotel','Hotel Villa Florencia','Susanita, Turrialba, Cartago','Hotel Villa Florencia le ofrece el lugar ideal para descansar en uno de los lugares mas pintorescos del Valle de Turrialba.','9.873942','-83.659198','public/img/9.jpg');
call sp_insert('i','u','y','a','p','hotel','Hotel Villa Florencia','Susanita, Turrialba, Cartago','Hotel Villa Florencia le ofrece el lugar ideal para descansar en uno de los lugares mas pintorescos del Valle de Turrialba.','9.873942','-83.659198','public/img/9.jpg');
call sp_insert('e','u','b','a','v','hotel','Hotel Villa Florencia','Susanita, Turrialba, Cartago','Hotel Villa Florencia le ofrece el lugar ideal para descansar en uno de los lugares mas pintorescos del Valle de Turrialba.','9.873942','-83.659198','public/img/9.jpg');
call sp_insert('i','u','b','c','v','hotel','Hotel Villa Florencia','Susanita, Turrialba, Cartago','Hotel Villa Florencia le ofrece el lugar ideal para descansar en uno de los lugares mas pintorescos del Valle de Turrialba.','9.873942','-83.659198','public/img/9.jpg');
call sp_insert('c','u','y','a','p','hotel','Hotel Villa Florencia','Susanita, Turrialba, Cartago','Hotel Villa Florencia le ofrece el lugar ideal para descansar en uno de los lugares mas pintorescos del Valle de Turrialba.','9.873942','-83.659198','public/img/9.jpg');
call sp_insert('c','u','b','a','v','hotel','Hotel Villa Florencia','Susanita, Turrialba, Cartago','Hotel Villa Florencia le ofrece el lugar ideal para descansar en uno de los lugares mas pintorescos del Valle de Turrialba.','9.873942','-83.659198','public/img/9.jpg');

call sp_insert('e','r','b','a','p','restaurante','Restaurante Mirador Sitios Angostura','Sitio de Mata, Turrialba, Cartago','Desde alli hay una excelente vista de la represa Angostura. Mientras usted come uno que otro colibri se acerca a comer tambien.','9.889716','-83.630128','public/img/10.jpg');
call sp_insert('e','u','b','b','v','restaurante','Restaurante Mirador Sitios Angostura','Sitio de Mata, Turrialba, Cartago','Desde alli hay una excelente vista de la represa Angostura. Mientras usted come uno que otro colibri se acerca a comer tambien.','9.889716','-83.630128','public/img/10.jpg');
call sp_insert('c','r','y','c','p','restaurante','Restaurante Mirador Sitios Angostura','Sitio de Mata, Turrialba, Cartago','Desde alli hay una excelente vista de la represa Angostura. Mientras usted come uno que otro colibri se acerca a comer tambien.','9.889716','-83.630128','public/img/10.jpg');
call sp_insert('e','r','y','b','p','restaurante','Restaurante Mirador Sitios Angostura','Sitio de Mata, Turrialba, Cartago','Desde alli hay una excelente vista de la represa Angostura. Mientras usted come uno que otro colibri se acerca a comer tambien.','9.889716','-83.630128','public/img/10.jpg');
call sp_insert('e','u','b','a','p','restaurante','Restaurante Mirador Sitios Angostura','Sitio de Mata, Turrialba, Cartago','Desde alli hay una excelente vista de la represa Angostura. Mientras usted come uno que otro colibri se acerca a comer tambien.','9.889716','-83.630128','public/img/10.jpg');
call sp_insert('e','r','b','c','v','restaurante','Restaurante Mirador Sitios Angostura','Sitio de Mata, Turrialba, Cartago','Desde alli hay una excelente vista de la represa Angostura. Mientras usted come uno que otro colibri se acerca a comer tambien.','9.889716','-83.630128','public/img/10.jpg');

call sp_insert('c','r','b','a','v','restaurante','Turrialtico Lodge','Pavones, Turrialba, Cartago','Turrialtico Lodge esta construido con hermosa madera rustica. El balcon del hotel ofrece las mejores vistas panoramicas del valle de Turrialba.','9.895085','-83.637209','public/img/11.jpg');
call sp_insert('i','r','b','b','v','restaurante','Turrialtico Lodge','Pavones, Turrialba, Cartago','Turrialtico Lodge esta construido con hermosa madera rustica. El balcon del hotel ofrece las mejores vistas panoramicas del valle de Turrialba.','9.895085','-83.637209','public/img/11.jpg');
call sp_insert('c','u','y','c','v','restaurante','Turrialtico Lodge','Pavones, Turrialba, Cartago','Turrialtico Lodge esta construido con hermosa madera rustica. El balcon del hotel ofrece las mejores vistas panoramicas del valle de Turrialba.','9.895085','-83.637209','public/img/11.jpg');
call sp_insert('e','r','b','a','p','restaurante','Turrialtico Lodge','Pavones, Turrialba, Cartago','Turrialtico Lodge esta construido con hermosa madera rustica. El balcon del hotel ofrece las mejores vistas panoramicas del valle de Turrialba.','9.895085','-83.637209','public/img/11.jpg');
call sp_insert('i','u','b','c','p','restaurante','Turrialtico Lodge','Pavones, Turrialba, Cartago','Turrialtico Lodge esta construido con hermosa madera rustica. El balcon del hotel ofrece las mejores vistas panoramicas del valle de Turrialba.','9.895085','-83.637209','public/img/11.jpg');
call sp_insert('c','u','b','b','p','restaurante','Turrialtico Lodge','Pavones, Turrialba, Cartago','Turrialtico Lodge esta construido con hermosa madera rustica. El balcon del hotel ofrece las mejores vistas panoramicas del valle de Turrialba.','9.895085','-83.637209','public/img/11.jpg');

call sp_insert('c','r','b','b','p','hotel','Rancho Naturalista','Tuis, Turrialba, Cartago','El principal hotel de observacion de aves en Costa Rica, Rancho Naturalista es uno de los mejores lodges de observacion de aves en America Central.','9.833345','-83.563900','public/img/12.jpg');
call sp_insert('c','r','b','b','v','hotel','Rancho Naturalista','Tuis, Turrialba, Cartago','El principal hotel de observacion de aves en Costa Rica, Rancho Naturalista es uno de los mejores lodges de observacion de aves en America Central.','9.833345','-83.563900','public/img/12.jpg');
call sp_insert('e','r','b','b','p','hotel','Rancho Naturalista','Tuis, Turrialba, Cartago','El principal hotel de observacion de aves en Costa Rica, Rancho Naturalista es uno de los mejores lodges de observacion de aves en America Central.','9.833345','-83.563900','public/img/12.jpg');
call sp_insert('c','u','y','a','v','hotel','Rancho Naturalista','Tuis, Turrialba, Cartago','El principal hotel de observacion de aves en Costa Rica, Rancho Naturalista es uno de los mejores lodges de observacion de aves en America Central.','9.833345','-83.563900','public/img/12.jpg');
call sp_insert('e','u','y','c','p','hotel','Rancho Naturalista','Tuis, Turrialba, Cartago','El principal hotel de observacion de aves en Costa Rica, Rancho Naturalista es uno de los mejores lodges de observacion de aves en America Central.','9.833345','-83.563900','public/img/12.jpg');
call sp_insert('e','u','b','b','p','hotel','Rancho Naturalista','Tuis, Turrialba, Cartago','El principal hotel de observacion de aves en Costa Rica, Rancho Naturalista es uno de los mejores lodges de observacion de aves en America Central.','9.833345','-83.563900','public/img/12.jpg');

call sp_insert('e','r','b','a','v','paradero','Piojos Pool','La Suiza, Turrialba, Cartago','Paradero Turistico','9.853222','-83.611430','public/img/13.jpg');
call sp_insert('c','r','y','c','v','paradero','Piojos Pool','La Suiza, Turrialba, Cartago','Paradero Turistico','9.853222','-83.611430','public/img/13.jpg');
call sp_insert('c','u','b','b','p','paradero','Piojos Pool','La Suiza, Turrialba, Cartago','Paradero Turistico','9.853222','-83.611430','public/img/13.jpg');
call sp_insert('e','u','b','a','v','paradero','Piojos Pool','La Suiza, Turrialba, Cartago','Paradero Turistico','9.853222','-83.611430','public/img/13.jpg');
call sp_insert('e','r','y','b','v','paradero','Piojos Pool','La Suiza, Turrialba, Cartago','Paradero Turistico','9.853222','-83.611430','public/img/13.jpg');
call sp_insert('e','r','y','a','p','paradero','Piojos Pool','La Suiza, Turrialba, Cartago','Paradero Turistico','9.853222','-83.611430','public/img/13.jpg');

call sp_insert('c','u','b','a','v','restaurante','Adrianos Restaurant','Canada, Turrialba, Cartago', 'Restaurante','9.860241','-83.622591','public/img/14.jpg');
call sp_insert('e','u','b','c','v','restaurante','Adrianos Restaurant','Canada, Turrialba, Cartago', 'Restaurante','9.860241','-83.622591','public/img/14.jpg');
call sp_insert('e','u','y','b','p','restaurante','Adrianos Restaurant','Canada, Turrialba, Cartago', 'Restaurante','9.860241','-83.622591','public/img/14.jpg');
call sp_insert('i','u','b','a','p','restaurante','Adrianos Restaurant','Canada, Turrialba, Cartago', 'Restaurante','9.860241','-83.622591','public/img/14.jpg');
call sp_insert('i','u','y','c','v','restaurante','Adrianos Restaurant','Canada, Turrialba, Cartago', 'Restaurante','9.860241','-83.622591','public/img/14.jpg');
call sp_insert('c','u','y','b','v','restaurante','Adrianos Restaurant','Canada, Turrialba, Cartago', 'Restaurante','9.860241','-83.622591','public/img/14.jpg');

call sp_insert('i','u','b','a','v','paradero','Complejo Deportivo el Varon','Turrialba, Cartago','Un lugar completamente distinto a cualquier otro complejo, pues cuenta con una vista panoramica del valle de Turrialba.','9.934150','-83.693036','public/img/15.jpg');
call sp_insert('c','r','b','b','p','paradero','Complejo Deportivo el Varon','Turrialba, Cartago','Un lugar completamente distinto a cualquier otro complejo, pues cuenta con una vista panoramica del valle de Turrialba.','9.934150','-83.693036','public/img/15.jpg');
call sp_insert('i','r','b','c','p','paradero','Complejo Deportivo el Varon','Turrialba, Cartago','Un lugar completamente distinto a cualquier otro complejo, pues cuenta con una vista panoramica del valle de Turrialba.','9.934150','-83.693036','public/img/15.jpg');
call sp_insert('i','r','y','b','v','paradero','Complejo Deportivo el Varon','Turrialba, Cartago','Un lugar completamente distinto a cualquier otro complejo, pues cuenta con una vista panoramica del valle de Turrialba.','9.934150','-83.693036','public/img/15.jpg');
call sp_insert('i','r','y','c','v','paradero','Complejo Deportivo el Varon','Turrialba, Cartago','Un lugar completamente distinto a cualquier otro complejo, pues cuenta con una vista panoramica del valle de Turrialba.','9.934150','-83.693036','public/img/15.jpg');
call sp_insert('c','r','y','b','p','paradero','Complejo Deportivo el Varon','Turrialba, Cartago','Un lugar completamente distinto a cualquier otro complejo, pues cuenta con una vista panoramica del valle de Turrialba.','9.934150','-83.693036','public/img/15.jpg');

call sp_insert('e','r','b','b','p','natural','Rio Pejibaye' ,'Pejibaye, Jimenez, Cartago','Apto para la practica de rafting, posee rapidos que personas de cualquier edad pueden disfrutar plenamente.','9.793242','-83.690331','public/img/16.jpeg');
call sp_insert('i','u','y','b','p','natural','Rio Pejibaye' ,'Pejibaye, Jimenez, Cartago','Apto para la practica de rafting, posee rapidos que personas de cualquier edad pueden disfrutar plenamente.','9.793242','-83.690331','public/img/16.jpeg');
call sp_insert('i','r','b','c','v','natural','Rio Pejibaye' ,'Pejibaye, Jimenez, Cartago','Apto para la practica de rafting, posee rapidos que personas de cualquier edad pueden disfrutar plenamente.','9.793242','-83.690331','public/img/16.jpeg');
call sp_insert('e','r','b','c','v','natural','Rio Pejibaye' ,'Pejibaye, Jimenez, Cartago','Apto para la practica de rafting, posee rapidos que personas de cualquier edad pueden disfrutar plenamente.','9.793242','-83.690331','public/img/16.jpeg');
call sp_insert('c','u','y','a','v','natural','Rio Pejibaye' ,'Pejibaye, Jimenez, Cartago','Apto para la practica de rafting, posee rapidos que personas de cualquier edad pueden disfrutar plenamente.','9.793242','-83.690331','public/img/16.jpeg');
call sp_insert('i','u','b','a','v','natural','Rio Pejibaye' ,'Pejibaye, Jimenez, Cartago','Apto para la practica de rafting, posee rapidos que personas de cualquier edad pueden disfrutar plenamente.','9.793242','-83.690331','public/img/16.jpeg');

call sp_insert('c','r','b','b','v','paradero','Parapente Turrialba','Santa Cruz, Turrialba, Cartago','En Santa Cruz de Turrialba encontramos una zona de vuelo privilegiada. Con una buenisima superficie para el despegue y una excelente vista.','9.960460','-83.749607','public/img/17.jpg');
call sp_insert('c','r','b','b','p','paradero','Parapente Turrialba','Santa Cruz, Turrialba, Cartago','En Santa Cruz de Turrialba encontramos una zona de vuelo privilegiada. Con una buenisima superficie para el despegue y una excelente vista.','9.960460','-83.749607','public/img/17.jpg');
call sp_insert('i','r','b','a','p','paradero','Parapente Turrialba','Santa Cruz, Turrialba, Cartago','En Santa Cruz de Turrialba encontramos una zona de vuelo privilegiada. Con una buenisima superficie para el despegue y una excelente vista.','9.960460','-83.749607','public/img/17.jpg');
call sp_insert('e','r','y','b','v','paradero','Parapente Turrialba','Santa Cruz, Turrialba, Cartago','En Santa Cruz de Turrialba encontramos una zona de vuelo privilegiada. Con una buenisima superficie para el despegue y una excelente vista.','9.960460','-83.749607','public/img/17.jpg');
call sp_insert('c','u','y','c','p','paradero','Parapente Turrialba','Santa Cruz, Turrialba, Cartago','En Santa Cruz de Turrialba encontramos una zona de vuelo privilegiada. Con una buenisima superficie para el despegue y una excelente vista.','9.960460','-83.749607','public/img/17.jpg');
call sp_insert('e','r','b','c','p','paradero','Parapente Turrialba','Santa Cruz, Turrialba, Cartago','En Santa Cruz de Turrialba encontramos una zona de vuelo privilegiada. Con una buenisima superficie para el despegue y una excelente vista.','9.960460','-83.749607','public/img/17.jpg');

call sp_insert('i','r','b','b','p','paradero','Finca Vialig','Pacayitas, Turrialba, Cartago','El Centro Operacional de Finca ViaLig se encuentra ubicado en una hermosa comunidad, donde las personas son amables y con la esperanza de ser cada dia mejor.','9.882631','-83.582302','public/img/18.jpg');
call sp_insert('c','u','b','a','p','paradero','Finca Vialig','Pacayitas, Turrialba, Cartago','El Centro Operacional de Finca ViaLig se encuentra ubicado en una hermosa comunidad, donde las personas son amables y con la esperanza de ser cada dia mejor.','9.882631','-83.582302','public/img/18.jpg');
call sp_insert('i','u','y','a','v','paradero','Finca Vialig','Pacayitas, Turrialba, Cartago','El Centro Operacional de Finca ViaLig se encuentra ubicado en una hermosa comunidad, donde las personas son amables y con la esperanza de ser cada dia mejor.','9.882631','-83.582302','public/img/18.jpg');
call sp_insert('i','u','b','a','v','paradero','Finca Vialig','Pacayitas, Turrialba, Cartago','El Centro Operacional de Finca ViaLig se encuentra ubicado en una hermosa comunidad, donde las personas son amables y con la esperanza de ser cada dia mejor.','9.882631','-83.582302','public/img/18.jpg');
call sp_insert('i','r','y','a','v','paradero','Finca Vialig','Pacayitas, Turrialba, Cartago','El Centro Operacional de Finca ViaLig se encuentra ubicado en una hermosa comunidad, donde las personas son amables y con la esperanza de ser cada dia mejor.','9.882631','-83.582302','public/img/18.jpg');

call sp_insert('e','r','b','b','p','natural','Aquiares Waterfall','Aquiares, Turrialba, Cartago','Belleza pura. Todas las grandes cosas en una. Desde increibles vistas, hasta las hermosas cascadas y las piscinas naturales de los rios.','9.941796','-83.720544','public/img/19.jpg');
call sp_insert('e','r','b','c','v','natural','Aquiares Waterfall','Aquiares, Turrialba, Cartago','Belleza pura. Todas las grandes cosas en una. Desde increibles vistas, hasta las hermosas cascadas y las piscinas naturales de los rios.','9.941796','-83.720544','public/img/19.jpg');
call sp_insert('c','r','y','c','v','natural','Aquiares Waterfall','Aquiares, Turrialba, Cartago','Belleza pura. Todas las grandes cosas en una. Desde increibles vistas, hasta las hermosas cascadas y las piscinas naturales de los rios.','9.941796','-83.720544','public/img/19.jpg');
call sp_insert('c','u','y','b','p','natural','Aquiares Waterfall','Aquiares, Turrialba, Cartago','Belleza pura. Todas las grandes cosas en una. Desde increibles vistas, hasta las hermosas cascadas y las piscinas naturales de los rios.','9.941796','-83.720544','public/img/19.jpg');
call sp_insert('i','r','b','b','p','natural','Aquiares Waterfall','Aquiares, Turrialba, Cartago','Belleza pura. Todas las grandes cosas en una. Desde increibles vistas, hasta las hermosas cascadas y las piscinas naturales de los rios.','9.941796','-83.720544','public/img/19.jpg');

call sp_insert('c','r','b','a','v','hotel','Siloe Lodge','La Suiza, Turrialba, Cartago','Un lugar lleno de Paz y tranquilidad,muy seguro, rodeado de areas verdes. Habitaciones limpias y frescas muy aseadas y confortables.','9.868452','-83.633771','public/img/20.jpg');
call sp_insert('i','u','b','c','p','hotel','Siloe Lodge','La Suiza, Turrialba, Cartago','Un lugar lleno de Paz y tranquilidad,muy seguro, rodeado de areas verdes. Habitaciones limpias y frescas muy aseadas y confortables.','9.868452','-83.633771','public/img/20.jpg');
call sp_insert('c','u','y','c','v','hotel','Siloe Lodge','La Suiza, Turrialba, Cartago','Un lugar lleno de Paz y tranquilidad,muy seguro, rodeado de areas verdes. Habitaciones limpias y frescas muy aseadas y confortables.','9.868452','-83.633771','public/img/20.jpg');
call sp_insert('e','u','y','a','v','hotel','Siloe Lodge','La Suiza, Turrialba, Cartago','Un lugar lleno de Paz y tranquilidad,muy seguro, rodeado de areas verdes. Habitaciones limpias y frescas muy aseadas y confortables.','9.868452','-83.633771','public/img/20.jpg');

call sp_insert('c','u','y','c','v','hotel','Hotel Maribu Caribe','Puerto Limon, Limon','Es un hotel de primera clase, ubicado en una exuberante zona tropical de Costa Rica donde se pueden apreciar maravillosos y relajantes paisajes.','10.013473','-83.049977','public/img/21.jpg');
call sp_insert('c','r','b','b','p','hotel','Hotel Maribu Caribe','Puerto Limon, Limon','Es un hotel de primera clase, ubicado en una exuberante zona tropical de Costa Rica donde se pueden apreciar maravillosos y relajantes paisajes.','10.013473','-83.049977','public/img/21.jpg');
call sp_insert('c','u','y','c','v','hotel','Hotel Maribu Caribe','Puerto Limon, Limon','Es un hotel de primera clase, ubicado en una exuberante zona tropical de Costa Rica donde se pueden apreciar maravillosos y relajantes paisajes.','10.013473','-83.049977','public/img/21.jpg');
call sp_insert('i','u','y','b','v','hotel','Hotel Maribu Caribe','Puerto Limon, Limon','Es un hotel de primera clase, ubicado en una exuberante zona tropical de Costa Rica donde se pueden apreciar maravillosos y relajantes paisajes.','10.013473','-83.049977','public/img/21.jpg');
call sp_insert('c','u','b','a','v','hotel','Hotel Maribu Caribe','Puerto Limon, Limon','Es un hotel de primera clase, ubicado en una exuberante zona tropical de Costa Rica donde se pueden apreciar maravillosos y relajantes paisajes.','10.013473','-83.049977','public/img/21.jpg');

call sp_insert('c','u','y','c','v','hotel','Hotel Playa Bonita','Playa Bonita, Limon','El Hotel esta estrategicamente ubicado, donde usted puede visitar lugares con gran valor historico.','10.009726','-83.062047','public/img/22.jpg');
call sp_insert('e','u','y','a','v','hotel','Hotel Playa Bonita','Playa Bonita, Limon','El Hotel esta estrategicamente ubicado, donde usted puede visitar lugares con gran valor historico.','10.009726','-83.062047','public/img/22.jpg');
call sp_insert('c','r','b','c','v','hotel','Hotel Playa Bonita','Playa Bonita, Limon','El Hotel esta estrategicamente ubicado, donde usted puede visitar lugares con gran valor historico.','10.009726','-83.062047','public/img/22.jpg');
call sp_insert('c','r','b','b','v','hotel','Hotel Playa Bonita','Playa Bonita, Limon','El Hotel esta estrategicamente ubicado, donde usted puede visitar lugares con gran valor historico.','10.009726','-83.062047','public/img/22.jpg');
call sp_insert('c','r','b','c','v','hotel','Hotel Playa Bonita','Playa Bonita, Limon','El Hotel esta estrategicamente ubicado, donde usted puede visitar lugares con gran valor historico.','10.009726','-83.062047','public/img/22.jpg');

call sp_insert('c','u','y','c','v','hotel','Hotel Oasys del Caribe','Puerto Limon, Limon','Nuestro hotel esta ubicado a pocos minutos del centro de la ciudad de Limon y cerca de la playa.','10.009298','-83.048853','public/img/23.jpg');
call sp_insert('e','r','b','a','v','hotel','Hotel Oasys del Caribe','Puerto Limon, Limon','Nuestro hotel esta ubicado a pocos minutos del centro de la ciudad de Limon y cerca de la playa.','10.009298','-83.048853','public/img/23.jpg');
call sp_insert('c','u','y','b','v','hotel','Hotel Oasys del Caribe','Puerto Limon, Limon','Nuestro hotel esta ubicado a pocos minutos del centro de la ciudad de Limon y cerca de la playa.','10.009298','-83.048853','public/img/23.jpg');
call sp_insert('e','u','b','b','p','hotel','Hotel Oasys del Caribe','Puerto Limon, Limon','Nuestro hotel esta ubicado a pocos minutos del centro de la ciudad de Limon y cerca de la playa.','10.009298','-83.048853','public/img/23.jpg');
call sp_insert('c','r','b','a','v','hotel','Hotel Oasys del Caribe','Puerto Limon, Limon','Nuestro hotel esta ubicado a pocos minutos del centro de la ciudad de Limon y cerca de la playa.','10.009298','-83.048853','public/img/23.jpg');

call sp_insert('c','u','b','a','v','hotel','Hotel Wagelia','Turrialba, Cartago','Hermoso Hotel en el centro de Turrialba.','9.903657','-83.670802','public/img/24.png');
call sp_insert('i','r','y','c','p','hotel','Hotel Wagelia','Turrialba, Cartago','Hermoso Hotel en el centro de Turrialba.','9.903657','-83.670802','public/img/24.png');
call sp_insert('e','r','b','c','p','hotel','Hotel Wagelia','Turrialba, Cartago','Hermoso Hotel en el centro de Turrialba.','9.903657','-83.670802','public/img/24.png');
call sp_insert('e','u','y','b','p','hotel','Hotel Wagelia','Turrialba, Cartago','Hermoso Hotel en el centro de Turrialba.','9.903657','-83.670802','public/img/24.png');
call sp_insert('c','u','y','p','p','hotel','Hotel Wagelia','Turrialba, Cartago','Hermoso Hotel en el centro de Turrialba.','9.903657','-83.670802','public/img/24.png');

call sp_insert('i','u','b','b','v','restaurante','Restaurante La Flor','Turrialba, Cartago','Restaurante con deliciosa comida casera','9.903657','-83.67802','public/img/24.png');
call sp_insert('c','r','b','c','v','restaurante','Restaurante La Flor','Turrialba, Cartago','Restaurante con deliciosa comida casera','9.903657','-83.67802','public/img/24.png');
call sp_insert('e','u','b','b','v','restaurante','Restaurante La Flor','Turrialba, Cartago','Restaurante con deliciosa comida casera','9.903657','-83.67802','public/img/24.png');
call sp_insert('e','r','y','c','p','restaurante','Restaurante La Flor','Turrialba, Cartago','Restaurante con deliciosa comida casera','9.903657','-83.67802','public/img/24.png');
call sp_insert('e','u','b','c','v','restaurante','Restaurante La Flor','Turrialba, Cartago','Restaurante con deliciosa comida casera','9.903657','-83.67802','public/img/24.png');

call sp_insert('e','r','b','c','p','paradero','Atreus','Turrialba, Cartago','Mariposario','9.903657','-83.670802','public/img/24.png');
call sp_insert('e','r','b','a','v','paradero','Atreus','Turrialba, Cartago','Mariposario','9.903657','-83.670802','public/img/24.png');
call sp_insert('e','r','b','a','v','paradero','Atreus','Turrialba, Cartago','Mariposario','9.903657','-83.670802','public/img/24.png');
call sp_insert('i','u','b','c','v','paradero','Atreus','Turrialba, Cartago','Mariposario','9.903657','-83.670802','public/img/24.png');
call sp_insert('i','r','y','a','v','paradero','Atreus','Turrialba, Cartago','Mariposario','9.903657','-83.670802','public/img/24.png');

call sp_insert('i','r','b','a','p','paradero','Rancho San Rafael','Turrialba, Cartago','Paradero Turistico','9.903657','-83.670802','public/img/24.png');
call sp_insert('i','r','y','a','v','paradero','Rancho San Rafael','Turrialba, Cartago','Paradero Turistico','9.903657','-83.670802','public/img/24.png');
call sp_insert('c','u','b','a','v','paradero','Rancho San Rafael','Turrialba, Cartago','Paradero Turistico','9.903657','-83.670802','public/img/24.png');
call sp_insert('e','u','y','a','p','paradero','Rancho San Rafael','Turrialba, Cartago','Paradero Turistico','9.903657','-83.670802','public/img/24.png');
call sp_insert('i','u','b','c','v','paradero','Rancho San Rafael','Turrialba, Cartago','Paradero Turistico','9.903657','-83.670802','public/img/24.png');

call sp_insert('e','u','b','b','v','paradero','La Esperanza','Turrialba, Cartago','Paradero Turistico','9.903657','-83.670802','public/img/24.png');
call sp_insert('e','u','y','a','p','paradero','La Esperanza','Turrialba, Cartago','Paradero Turistico','9.903657','-83.670802','public/img/24.png');
call sp_insert('i','u','b','a','v','paradero','La Esperanza','Turrialba, Cartago','Paradero Turistico','9.903657','-83.670802','public/img/24.png');
call sp_insert('i','r','y','b','v','paradero','La Esperanza','Turrialba, Cartago','Paradero Turistico','9.903657','-83.670802','public/img/24.png');
call sp_insert('c','r','b','b','v','paradero','La Esperanza','Turrialba, Cartago','Paradero Turistico','9.903657','-83.670802','public/img/24.png');

call sp_insert('c','r','b','c','v','paradero','Rancho el Sol','Turrialba, Cartago','Paradero Turistico','9.903657','-83.670802','public/img/24.png');
call sp_insert('i','r','b','b','p','paradero','Rancho el Sol','Turrialba, Cartago','Paradero Turistico','9.903657','-83.670802','public/img/24.png');
call sp_insert('i','r','y','c','p','paradero','Rancho el Sol','Turrialba, Cartago','Paradero Turistico','9.903657','-83.670802','public/img/24.png');
call sp_insert('i','u','b','a','v','paradero','Rancho el Sol','Turrialba, Cartago','Paradero Turistico','9.903657','-83.670802','public/img/24.png');
call sp_insert('c','u','y','a','p','paradero','Rancho el Sol','Turrialba, Cartago','Paradero Turistico','9.903657','-83.670802','public/img/24.png');

call sp_insert('e','u','b','c','v','hotel','Rancho Monteverde','Turrialba, Cartago','Restaurante','9.903657','-83.670802','public/img/24.png');
call sp_insert('i','u','y','a','v','hotel','Rancho Monteverde','Turrialba, Cartago','Restaurante','9.903657','-83.670802','public/img/24.png');
call sp_insert('i','r','y','c','v','hotel','Rancho Monteverde','Turrialba, Cartago','Restaurante','9.903657','-83.670802','public/img/24.png');
call sp_insert('c','u','y','b','v','hotel','Rancho Monteverde','Turrialba, Cartago','Restaurante','9.903657','-83.670802','public/img/24.png');
call sp_insert('i','u','b','b','v','hotel','Rancho Monteverde','Turrialba, Cartago','Restaurante','9.903657','-83.670802','public/img/24.png');

call sp_insert('i','u','b','a','p','hotel','Rancho el Veroliz','Turrialba, Cartago','Paradero Turistico','9.903657','-83.670802','public/img/24.png');
call sp_insert('e','r','y','b','p','hotel','Rancho el Veroliz','Turrialba, Cartago','Paradero Turistico','9.903657','-83.670802','public/img/24.png');
call sp_insert('c','u','b','b','p','hotel','Rancho el Veroliz','Turrialba, Cartago','Paradero Turistico','9.903657','-83.670802','public/img/24.png');
call sp_insert('i','r','b','c','p','hotel','Rancho el Veroliz','Turrialba, Cartago','Paradero Turistico','9.903657','-83.670802','public/img/24.png');
call sp_insert('e','u','y','c','p','hotel','Rancho el Veroliz','Turrialba, Cartago','Paradero Turistico','9.903657','-83.670802','public/img/24.png');

call sp_insert('i','u','b','b','v','restaurante','El manantial','Turrialba, Cartago','Restaurante','9.903657','-83.670802','public/img/24.png');
call sp_insert('e','u','y','b','p','restaurante','El manantial','Turrialba, Cartago','Restaurante','9.903657','-83.670802','public/img/24.png');
call sp_insert('e','u','y','c','p','restaurante','El manantial','Turrialba, Cartago','Restaurante','9.903657','-83.670802','public/img/24.png');
call sp_insert('c','u','y','a','v','restaurante','El manantial','Turrialba, Cartago','Restaurante','9.903657','-83.670802','public/img/24.png');
call sp_insert('i','r','y','c','p','restaurante','El manantial','Turrialba, Cartago','Restaurante','9.903657','-83.670802','public/img/24.png');

call sp_insert('c','r','b','a','p','hotel','Mountain Hotel','Turrialba, Cartago','Hotel / Restaurante','9.903657','-83.670802','public/img/24.png');
call sp_insert('e','r','y','c','p','hotel','Mountain Hotel','Turrialba, Cartago','Hotel / Restaurante','9.903657','-83.670802','public/img/24.png');
call sp_insert('c','r','b','a','p','hotel','Mountain Hotel','Turrialba, Cartago','Hotel / Restaurante','9.903657','-83.670802','public/img/24.png');
call sp_insert('e','r','b','b','p','hotel','Mountain Hotel','Turrialba, Cartago','Hotel / Restaurante','9.903657','-83.670802','public/img/24.png');
call sp_insert('i','u','y','b','v','hotel','Mountain Hotel','Turrialba, Cartago','Hotel / Restaurante','9.903657','-83.670802','public/img/24.png');

call sp_insert('e','u','b','a','p','hotel','Hotel Patito','Turrialba, Cartago','Hotel','9.903.657','-83.670802','public/img/24.png');
call sp_insert('c','r','y','a','v','hotel','Hotel Patito','Turrialba, Cartago','Hotel','9.903.657','-83.670802','public/img/24.png');
call sp_insert('i','r','y','b','p','hotel','Hotel Patito','Turrialba, Cartago','Hotel','9.903.657','-83.670802','public/img/24.png');
call sp_insert('i','r','y','c','v','hotel','Hotel Patito','Turrialba, Cartago','Hotel','9.903.657','-83.670802','public/img/24.png');
call sp_insert('c','r','b','a','v','hotel','Hotel Patito','Turrialba, Cartago','Hotel','9.903.657','-83.670802','public/img/24.png');

call sp_insert('c','r','b','b','v','restaurante','La Pastora','Turrialba, Cartago','Restaurante','9.903657','-83.670802','public/img/24.png');
call sp_insert('e','u','b','b','v','restaurante','La Pastora','Turrialba, Cartago','Restaurante','9.903657','-83.670802','public/img/24.png');
call sp_insert('i','u','b','c','v','restaurante','La Pastora','Turrialba, Cartago','Restaurante','9.903657','-83.670802','public/img/24.png');
call sp_insert('c','u','y','c','v','restaurante','La Pastora','Turrialba, Cartago','Restaurante','9.903657','-83.670802','public/img/24.png');
call sp_insert('i','r','b','c','p','restaurante','La Pastora','Turrialba, Cartago','Restaurante','9.903657','-83.670802','public/img/24.png');
