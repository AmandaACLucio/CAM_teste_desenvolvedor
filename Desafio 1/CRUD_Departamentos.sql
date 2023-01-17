/* CRUD DEPARTAMENTOS */

/*CREATE*/
delimiter $$
drop procedure if exists Empresa.create_departamento$$
create procedure Empresa.create_departamento(query JSON)
	BEGIN
		DECLARE value_nome varchar(255) default null;
		set value_nome = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Nome'));
        
        if (value_nome is not null) then

            INSERT INTO Empresa.Departamentos (Nome) VALUES (value_nome);
            
        end if;        
	END $$
delimiter ;

/*READ*/
delimiter $$
drop procedure if exists Empresa.read_departamento$$
create procedure Empresa.read_departamento(query JSON)
	BEGIN
		DECLARE value_departamento_id INT default null;
        
		set value_departamento_id = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Departamento_id'));
        
        if (value_departamento_id is not null) then

            SELECT * FROM Empresa.Departamentos 
            WHERE Departamento_id = value_departamento_id;
            
        end if;        
	END $$
delimiter ;

/*UPDATE*/
delimiter $$
drop procedure if exists Empresa.update_departamento$$
create procedure Empresa.update_departamento(query JSON)
	BEGIN
		DECLARE value_departamento_id INT default null;
		DECLARE value_nome varchar(255) default null;
        
		set value_departamento_id = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Departamento_id'));
		set value_nome = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Nome'));
        
        if (value_nome is not null) AND (value_departamento_id is not null) then

            UPDATE Empresa.Departamentos SET Nome = value_nome 
            WHERE Departamento_id = value_departamento_id;
            
        end if;        
	END $$
delimiter ;

/*DELETE*/
delimiter $$
drop procedure if exists Empresa.delete_departamento$$
create procedure Empresa.delete_departamento(query JSON)
	BEGIN
		DECLARE value_departamento_id INT default null;
        
		set value_departamento_id = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Departamento_id'));
        
        if (value_departamento_id is not null) then

            DELETE FROM Empresa.Departamentos  
            WHERE Departamento_id = value_departamento_id;
            
        end if;        
	END $$
delimiter ;


call Empresa.create_departamento('{"Nome": "Estratégia"}');
call Empresa.create_departamento('{"Nome": "Gestão"}');
call Empresa.create_departamento('{"Nome": "Finanças"}');
call Empresa.create_departamento('{"Nome": "Recursos Humanos"}');
call Empresa.read_departamento('{"Departamento_id": 1}');
call Empresa.update_departamento('{"Departamento_id": 1, "Nome": "Estratégia e Gestão"}');
call Empresa.delete_departamento('{"Departamento_id": 2}');
SELECT * FROM Empresa.Departamentos;
