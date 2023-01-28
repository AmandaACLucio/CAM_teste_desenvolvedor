/* CRUD Relacoes_projetos_funcionarios */

/*CREATE*/
delimiter $$
drop procedure if exists Empresa.create_relacao_projeto_funcionario$$
create procedure Empresa.create_relacao_projeto_funcionario(query JSON)
	BEGIN
		DECLARE value_projeto_id INT default null;
		DECLARE value_funcionario_id INT default null;
		DECLARE value_carga_horaria Float default null;
		DECLARE value_carga_horaria_exercida float default null;
		DECLARE value_carga_horaria_maxima float default null;
		DECLARE value_horas_conclusao float default null;
		DECLARE value_horas_totais_realizadas float default null;
        
		set value_projeto_id = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Projeto_id'));
		set value_funcionario_id = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Funcionario_id'));
		set value_carga_horaria = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Carga_horaria'));

        if (value_projeto_id is not null) AND (value_funcionario_id is not null) AND 
        (value_carga_horaria is not null) then

			SELECT Carga_horaria_exercida, Carga_horaria INTO value_carga_horaria_exercida, value_carga_horaria_maxima FROM Empresa.Funcionarios
			WHERE Funcionario_id = value_funcionario_id;

			if(value_carga_horaria_maxima >= value_carga_horaria_exercida+value_carga_horaria) then

				SELECT Horas_conclusao INTO value_horas_conclusao  FROM Empresa.Projetos
				WHERE Projeto_id = value_projeto_id;

				if(value_horas_conclusao-value_carga_horaria> 0) then

					INSERT INTO Empresa.Relacoes_projetos_funcionarios (Projeto_id, Funcionario_id, Carga_horaria) 
					VALUES (value_projeto_id, value_funcionario_id, value_carga_horaria);

					UPDATE Empresa.Funcionarios SET Carga_horaria_exercida = Carga_horaria_exercida+value_carga_horaria
					WHERE Funcionario_id = value_funcionario_id;

					UPDATE Empresa.Projetos SET Horas_conclusao = Horas_conclusao-value_carga_horaria, Horas_totais_realizadas = value_carga_horaria, 
                    Horas_realizadas = value_carga_horaria, Ultimo_calculo_horas = current_date()
					WHERE Projeto_id = value_projeto_id;
				
				else

					SIGNAL SQLSTATE '45000'
						SET MESSAGE_TEXT = 'A carga horária da relação ultrapassa a carga horária restante para conclusão do projeto';
				end if;

			else

				SIGNAL SQLSTATE '45000'
					SET MESSAGE_TEXT = 'Carga horária do funcionário excedida!';
			end if;
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
		DECLARE value_carga_horaria float default null;
        DECLARE value_carga_horaria_exercida float default null;
		DECLARE value_carga_horaria_maxima float default null;
        DECLARE value_horas_conclusao float default null;
        DECLARE value_horas_realizadas float default null;
        DECLARE value_horas_totais_realizadas float default null;
        DECLARE value_ultimo_calculo_horas date default null;
        DECLARE value_carga_horaria_antes_update float default null;
        DECLARE value_horas_realizadas_totais_antes_update float default null;
        DECLARE semanas_passadas int default 1;
        
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
            
			SELECT Carga_horaria INTO value_carga_horaria_antes_update FROM Empresa.Relacoes_projetos_funcionarios
				WHERE Relacao_id = value_relacao_id;
		
			SELECT Carga_horaria_exercida, Carga_horaria INTO value_carga_horaria_exercida, value_carga_horaria_maxima FROM Empresa.Funcionarios
			WHERE Funcionario_id = value_funcionario_id;

			if(value_carga_horaria_maxima >= (value_carga_horaria_exercida+value_carga_horaria-value_carga_horaria_antes_update)) then

				SELECT Horas_conclusao, Ultimo_calculo_horas INTO value_horas_conclusao, value_ultimo_calculo_horas
                FROM Empresa.Projetos
				WHERE Projeto_id = value_projeto_id;
                
				set semanas_passadas = FLOOR(DATEDIFF(current_date(), value_ultimo_calculo_horas)/7);
                
                if(semanas_passadas = 0) then
					set semanas_passadas=1;
				end if;

				if((value_horas_conclusao-value_carga_horaria+value_carga_horaria_antes_update)>= 0) then

					UPDATE Empresa.Relacoes_projetos_funcionarios SET Projeto_id = value_projeto_id,
					Funcionario_id =value_funcionario_id, Carga_horaria = value_carga_horaria
					WHERE Relacao_id = value_relacao_id;
                    
					UPDATE Empresa.Funcionarios SET Carga_horaria_exercida = Carga_horaria_exercida+value_carga_horaria-value_carga_horaria_antes_update
					WHERE Funcionario_id = value_funcionario_id;

					UPDATE Empresa.Projetos SET Horas_conclusao = Horas_conclusao-value_carga_horaria+value_carga_horaria_antes_update, 
                    Horas_totais_realizadas = Horas_totais_realizadas+value_carga_horaria-value_carga_horaria_antes_update, 
                    Horas_realizadas = (Horas_totais_realizadas+value_carga_horaria-value_carga_horaria_antes_update)/semanas_passadas, Ultimo_calculo_horas = current_date()
					WHERE Projeto_id = value_projeto_id;

				else
					SET @message_text = concat('A carga horária da relação ultrapassa a carga horária restante para conclusão do projeto ', semanas_passadas);
					SIGNAL SQLSTATE '45000'
					SET MESSAGE_TEXT = @message_text;
				end if;

			else
				SIGNAL SQLSTATE '45000'
					SET MESSAGE_TEXT = 'Carga horária do funcionário excedida!';
			end if;
        end if;        
	END $$
delimiter ;

/*DELETE*/
delimiter $$
drop procedure if exists Empresa.delete_relacao_projeto_funcionario$$
create procedure Empresa.delete_relacao_projeto_funcionario(query JSON)
	BEGIN
		DECLARE value_relacao_id INT default null;
		DECLARE value_projeto_id INT default null;
		DECLARE value_funcionario_id INT default null;
		DECLARE value_carga_horaria FLOAT default null;
        DECLARE semanas_passadas int default 1;
		DECLARE value_ultimo_calculo_horas DATE default null;
        
		set value_relacao_id = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Relacao_id'));
        
        if (value_relacao_id is not null) then

			SELECT Funcionario_id, Projeto_id, Carga_horaria INTO value_funcionario_id, value_projeto_id, value_carga_horaria FROM Empresa.Relacoes_projetos_funcionarios
			WHERE Relacao_id = value_relacao_id;

			SELECT Ultimo_calculo_horas INTO value_ultimo_calculo_horas
			FROM Empresa.Projetos
			WHERE Projeto_id = value_projeto_id;

			set semanas_passadas = FLOOR(DATEDIFF(current_date(), value_ultimo_calculo_horas)/7);

            DELETE FROM Empresa.Relacoes_projetos_funcionarios  
            WHERE Relacao_id = value_relacao_id;
			
			UPDATE Empresa.Funcionarios SET Carga_horaria_exercida = Carga_horaria_exercida-value_carga_horaria
			WHERE Funcionario_id = value_funcionario_id;

			UPDATE Empresa.Projetos SET Horas_conclusao = Horas_conclusao+value_carga_horaria, 
			Horas_totais_realizadas = Horas_totais_realizadas-value_carga_horaria, 
			Horas_realizadas = (Horas_totais_realizadas-value_carga_horaria)/semanas_passadas, Ultimo_calculo_horas = current_date()
			WHERE Projeto_id = value_projeto_id;
            
        end if;        
	END $$
delimiter ;

call Empresa.create_relacao_projeto_funcionario('{"Projeto_id": 2, "Funcionario_id": 3, "Carga_horaria": 6}');
call Empresa.create_relacao_projeto_funcionario('{"Projeto_id": 1, "Funcionario_id": 2, "Carga_horaria": 5.5}');
call Empresa.create_relacao_projeto_funcionario('{"Projeto_id": 3, "Funcionario_id": 5, "Carga_horaria": 7.5}');
call Empresa.read_relacao_projeto_funcionario('{"Relacao_id": 2}');
call Empresa.update_relacao_projeto_funcionario('{"Relacao_id": 3, "Carga_horaria":8.5}');
call Empresa.delete_relacao_projeto_funcionario('{"Relacao_id": 2}');
SELECT * FROM Empresa.Relacoes_projetos_funcionarios;
