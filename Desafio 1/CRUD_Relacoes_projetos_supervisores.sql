/* CRUD relacoes_projetos_supervisores */

/*CREATE*/
delimiter $$
drop procedure if exists Empresa.create_relacao_projeto_supervisor$$
create procedure Empresa.create_relacao_projeto_supervisor(query JSON)
	BEGIN
		DECLARE value_projeto_id INT default null;
		DECLARE value_supervisor_id INT default null;
		DECLARE value_carga_horaria Float default null;
		DECLARE value_carga_horaria_exercida float default null;
		DECLARE value_carga_horaria_maxima float default null;
        
		set value_projeto_id = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Projeto_id'));
		set value_supervisor_id = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Supervisor_id'));
		set value_carga_horaria = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Carga_horaria'));

        if (value_projeto_id is not null) AND (value_supervisor_id is not null) AND 
        (value_carga_horaria is not null) then

			SELECT Carga_horaria_exercida, Carga_horaria INTO value_carga_horaria_exercida, value_carga_horaria_maxima FROM Empresa.Funcionarios
			WHERE Funcionario_id = value_supervisor_id;

			if(value_carga_horaria_maxima >= value_carga_horaria_exercida+value_carga_horaria) then

				INSERT INTO Empresa.Relacoes_projetos_supervisores (Projeto_id, Supervisor_id, Carga_horaria) 
				VALUES (value_projeto_id, value_supervisor_id, value_carga_horaria);

				UPDATE Empresa.Funcionarios SET Carga_horaria_exercida = Carga_horaria_exercida+value_carga_horaria
				WHERE Funcionario_id = value_supervisor_id;				

			else

				SIGNAL SQLSTATE '45000'
					SET MESSAGE_TEXT = 'Carga horária do funcionário excedida!';
			end if;
        end if;        
	END $$
delimiter ;

/*READ*/
delimiter $$
drop procedure if exists Empresa.read_relacao_projeto_supervisor$$
create procedure Empresa.read_relacao_projeto_supervisor(query JSON)
	BEGIN
		DECLARE value_relacao_id INT default null;
        
		set value_relacao_id = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Relacao_id'));
        
        if (value_relacao_id is not null) then

            SELECT * FROM Empresa.Relacoes_projetos_supervisores
            WHERE Relacao_id = value_relacao_id;
            
        end if;        
	END $$
delimiter ;

/*UPDATE*/
delimiter $$
drop procedure if exists Empresa.update_relacao_projeto_supervisor$$
create procedure Empresa.update_relacao_projeto_supervisor(query JSON)
	BEGIN
		DECLARE value_relacao_id INT default null;
		DECLARE value_projeto_id varchar(255) default null;
		DECLARE value_supervisor_id varchar(255) default null;
		DECLARE value_carga_horaria float default null;
        DECLARE value_carga_horaria_exercida float default null;
		DECLARE value_carga_horaria_maxima float default null;
        DECLARE value_carga_horaria_antes_update float default null;
        
		set value_relacao_id = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Relacao_id'));
		set value_projeto_id = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Projeto_id'));
		set value_supervisor_id = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Supervisor_id'));
		set value_carga_horaria = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Carga_horaria'));
                
        if (value_relacao_id is not null) then
        
			if(value_projeto_id is null) then
				SELECT Projeto_id INTO value_projeto_id FROM Empresa.Relacoes_projetos_supervisores
				WHERE Relacao_id = value_relacao_id;
			end if;
			
			if(value_supervisor_id is null) then
				SELECT Supervisor_id INTO value_supervisor_id FROM Empresa.Relacoes_projetos_supervisores
				WHERE Relacao_id = value_relacao_id;
			end if;

			if(value_carga_horaria is null) then
				SELECT Carga_horaria INTO value_carga_horaria FROM Empresa.Relacoes_projetos_supervisores
				WHERE Relacao_id = value_relacao_id;
			end if;              
            
			SELECT Carga_horaria INTO value_carga_horaria_antes_update FROM Empresa.Relacoes_projetos_supervisores
				WHERE Relacao_id = value_relacao_id;
		
			SELECT Carga_horaria_exercida, Carga_horaria INTO value_carga_horaria_exercida, value_carga_horaria_maxima FROM Empresa.Funcionarios
			WHERE Funcionario_id = value_supervisor_id;

			if(value_carga_horaria_maxima >= (value_carga_horaria_exercida+value_carga_horaria-value_carga_horaria_antes_update)) then

				UPDATE Empresa.Relacoes_projetos_supervisores SET Projeto_id = value_projeto_id,
				Supervisor_id =value_supervisor_id, Carga_horaria = value_carga_horaria
				WHERE Relacao_id = value_relacao_id;
				
				UPDATE Empresa.Funcionarios SET Carga_horaria_exercida = Carga_horaria_exercida+value_carga_horaria-value_carga_horaria_antes_update
				WHERE Funcionario_id = value_supervisor_id;

			else
				SIGNAL SQLSTATE '45000'
					SET MESSAGE_TEXT = 'Carga horária do funcionário excedida!';
			end if;
        end if;        
	END $$
delimiter ;

/*DELETE*/
delimiter $$
drop procedure if exists Empresa.delete_relacao_projeto_supervisor$$
create procedure Empresa.delete_relacao_projeto_supervisor(query JSON)
	BEGIN
		DECLARE value_relacao_id INT default null;
        
		set value_relacao_id = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Relacao_id'));
        
        if (value_relacao_id is not null) then

            DELETE FROM Empresa.Relacoes_projetos_supervisores  
            WHERE Relacao_id = value_relacao_id;
            
        end if;        
	END $$
delimiter ;

/*call Empresa.create_relacao_projeto_supervisor('{"Projeto_id": 2, "Supervisor_id": 4, "Carga_horaria": 20.5}');
call Empresa.create_relacao_projeto_supervisor('{"Projeto_id": 1, "Supervisor_id": 1, "Carga_horaria": 5.5}');*/
call Empresa.read_relacao_projeto_supervisor('{"Relacao_id": 2}');
call Empresa.update_relacao_projeto_supervisor('{"Relacao_id": 1, "Carga_horaria": 14.5}');
call Empresa.delete_relacao_projeto_supervisor('{"Relacao_id": 2}');
SELECT * FROM Empresa.Relacoes_projetos_supervisores;
