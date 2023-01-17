/* CRUD FUNCIONARIOS */

/*CREATE*/
delimiter $$
drop procedure if exists Empresa.create_relacao_projeto_funcionario$$
create procedure Empresa.create_relacao_projeto_funcionario(query JSON)
	BEGIN
		DECLARE value_projeto_id INT default null;
		DECLARE value_funcionario_id INT default null;
		DECLARE value_carga_horaria Float default null;
        
		set value_projeto_id = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Projeto_id'));
		set value_funcionario_id = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Funcionario_id'));
		set value_carga_horaria = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Carga_horaria'));
        
        if (value_projeto_id is not null) AND (value_funcionario_id is not null) AND 
        (value_carga_horaria is not null) then

            INSERT INTO Empresa.Relacoes_projetos_funcionarios (Projeto_id, Funcionario_id, Carga_horaria) 
            VALUES (value_projeto_id, value_funcionario_id, value_carga_horaria);
            
        end if;        
	END $$
delimiter ;


/*READ*/
delimiter $$
drop procedure if exists Empresa.read_relacao_projeto_funcionario$$
create procedure Empresa.read_relacao_projeto_funcionario(query JSON)
	BEGIN
		DECLARE value_relacao_id INT default null;
        
		set value_relacao_id = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Relacao_id'));
        
        if (value_relacao_id is not null) then

            SELECT * FROM Empresa.Relacoes_projetos_funcionarios
            WHERE Relacao_id = value_relacao_id;
            
        end if;        
	END $$
delimiter ;

/*UPDATE*/
delimiter $$
drop procedure if exists Empresa.update_relacao_projeto_funcionario$$
create procedure Empresa.update_relacao_projeto_funcionario(query JSON)
	BEGIN
		DECLARE value_relacao_id INT default null;
		DECLARE value_projeto_id varchar(255) default null;
		DECLARE value_funcionario_id varchar(255) default null;
		DECLARE value_carga_horaria varchar(255) default null;
        
		set value_relacao_id = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Relacao_id'));
		set value_projeto_id = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Projeto_id'));
		set value_funcionario_id = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Funcionario_id'));
		set value_carga_horaria = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Carga_horaria'));
        
        if (value_relacao_id is not null) then
        
			if(value_projeto_id is null) then
				SELECT Projeto_id INTO value_projeto_id FROM Empresa.Relacoes_projetos_funcionarios
				WHERE Relacao_id = value_relacao_id;
			end if;
			
			if(value_funcionario_id is null) then
				SELECT Funcionario_id INTO value_funcionario_id FROM Empresa.Relacoes_projetos_funcionarios
				WHERE Relacao_id = value_relacao_id;
			end if;

			if(value_carga_horaria is null) then
				SELECT Carga_horaria INTO value_carga_horaria FROM Empresa.Relacoes_projetos_funcionarios
				WHERE Relacao_id = value_relacao_id;
			end if;                
		
			UPDATE Empresa.Relacoes_projetos_funcionarios SET Projeto_id = value_projeto_id,
			Funcionario_id =value_funcionario_id, Carga_horaria = value_carga_horaria
			WHERE Relacao_id = value_relacao_id;
        end if;        
	END $$
delimiter ;

/*DELETE*/
delimiter $$
drop procedure if exists Empresa.delete_relacao_projeto_funcionario$$
create procedure Empresa.delete_relacao_projeto_funcionario(query JSON)
	BEGIN
		DECLARE value_relacao_id INT default null;
        
		set value_relacao_id = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Relacao_id'));
        
        if (value_relacao_id is not null) then

            DELETE FROM Empresa.Relacoes_projetos_funcionarios  
            WHERE Relacao_id = value_relacao_id;
            
        end if;        
	END $$
delimiter ;

call Empresa.create_relacao_projeto_funcionario('{"Projeto_id": 2, "Funcionario_id": 2, "Carga_horaria": 20.5}');
call Empresa.create_relacao_projeto_funcionario('{"Projeto_id": 1, "Funcionario_id": 2, "Carga_horaria": 5.5}');
call Empresa.create_relacao_projeto_funcionario('{"Projeto_id": 2, "Funcionario_id": 1, "Carga_horaria": 7.5}');
call Empresa.read_relacao_projeto_funcionario('{"Relacao_id": 2}');
call Empresa.update_relacao_projeto_funcionario('{"Relacao_id": 3, "Carga_horaria": 14.5}');
call Empresa.delete_relacao_projeto_funcionario('{"Relacao_id": 2}');
SELECT * FROM Empresa.Relacoes_projetos_funcionarios;
