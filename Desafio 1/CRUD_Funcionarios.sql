/* CRUD FUNCIONARIOS */

/*CREATE*/
delimiter $$
drop procedure if exists Empresa.create_funcionario$$
create procedure Empresa.create_funcionario(query JSON)
	BEGIN
		DECLARE value_nome varchar(255) default null;
		DECLARE value_cpf varchar(255) default null;
		DECLARE value_rg varchar(255) default null;
		DECLARE value_sexo varchar(255) default null;
		DECLARE value_data_nascimento date default null;
		DECLARE value_possui_habilitacao boolean default null;
		DECLARE value_salario float default null;
		DECLARE value_carga_horaria float default null;
        
		set value_nome = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Nome'));
		set value_cpf = JSON_UNQUOTE(JSON_EXTRACT(query,'$.CPF'));
		set value_rg = JSON_UNQUOTE(JSON_EXTRACT(query,'$.RG'));
		set value_sexo = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Sexo'));
		set value_data_nascimento = STR_TO_DATE(JSON_UNQUOTE(JSON_EXTRACT(query,'$.Data_Nascimento')),"%d-%m-%Y");
		set value_possui_habilitacao = JSON_EXTRACT(query,'$.Possui_habilitacao');
		set value_salario = JSON_EXTRACT(query,'$.Salario');
		set value_carga_horaria = JSON_EXTRACT(query,'$.Carga_horaria');
  
        if (value_nome is not null) AND (value_cpf is not null) AND (value_rg is not null) 
        AND (value_sexo is not null) AND (value_data_nascimento is not null) 
        AND (value_possui_habilitacao is not null) AND (value_salario is not null) 
        AND (value_carga_horaria is not null) then

            INSERT INTO Empresa.Funcionarios (Nome,CPF, RG, Sexo, Data_nascimento, Possui_habilitacao, 
            Salario, Carga_horaria) 
            VALUES (value_nome, value_cpf, value_rg, value_sexo, value_data_nascimento, value_possui_habilitacao,
            value_salario, value_carga_horaria);
            
        end if;        
	END $$
delimiter ;

/*READ*/
delimiter $$
drop procedure if exists Empresa.read_funcionario$$
create procedure Empresa.read_funcionario(query JSON)
	BEGIN
		DECLARE value_funcionario_id INT default null;
        
		set value_funcionario_id = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Funcionario_id'));
        
        if (value_funcionario_id is not null) then

            SELECT * FROM Empresa.Funcionarios
            WHERE Funcionario_id = value_funcionario_id;
            
        end if;        
	END $$
delimiter ;

/*UPDATE*/
delimiter $$
drop procedure if exists Empresa.update_funcionario$$
create procedure Empresa.update_funcionario(query JSON)
	BEGIN
		DECLARE value_funcionario_id INT default null;
        DECLARE value_nome varchar(255) default null;
		DECLARE value_cpf varchar(255) default null;
		DECLARE value_rg varchar(255) default null;
		DECLARE value_sexo varchar(255) default null;
		DECLARE value_data_nascimento date default null;
		DECLARE value_possui_habilitacao boolean default null;
		DECLARE value_salario float default null;
		DECLARE value_carga_horaria float default null;
        
        set value_funcionario_id = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Funcionario_id'));
		set value_nome = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Nome'));
		set value_cpf = JSON_UNQUOTE(JSON_EXTRACT(query,'$.CPF'));
		set value_rg = JSON_UNQUOTE(JSON_EXTRACT(query,'$.RG'));
		set value_sexo = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Sexo'));
		set value_data_nascimento = STR_TO_DATE(JSON_UNQUOTE(JSON_EXTRACT(query,'$.Data_Nascimento')),"%d-%m-%Y");
		set value_possui_habilitacao = JSON_EXTRACT(query,'$.Possui_habilitacao');
		set value_salario = JSON_EXTRACT(query,'$.Salario');
		set value_carga_horaria = JSON_EXTRACT(query,'$.Carga_horaria');
        
        if (value_funcionario_id is not null) then

			if(value_nome is null) then
				SELECT Nome INTO value_nome FROM Empresa.Funcionarios
				WHERE Funcionario_id = value_funcionario_id;
			end if;

			if(value_cpf is null) then
				SELECT CPF INTO value_cpf FROM Empresa.Funcionarios
				WHERE Funcionario_id = value_funcionario_id;
			end if;

			if(value_rg is null) then
				SELECT RG INTO value_rg FROM Empresa.Funcionarios
				WHERE Funcionario_id = value_funcionario_id;
			end if;

			if(value_sexo is null) then
				SELECT Sexo INTO value_sexo FROM Empresa.Funcionarios
				WHERE Funcionario_id = value_funcionario_id;
			end if;

			if(value_data_nascimento is null) then
				SELECT Data_nascimento INTO value_data_nascimento FROM Empresa.Funcionarios
				WHERE Funcionario_id = value_funcionario_id;
			end if;

			if(value_possui_habilitacao is null) then
				SELECT Possui_habilitacao INTO value_possui_habilitacao FROM Empresa.Funcionarios
				WHERE Funcionario_id = value_funcionario_id;
			end if;

			if(value_salario is null) then
				SELECT Salario INTO value_salario FROM Empresa.Funcionarios
				WHERE Funcionario_id = value_funcionario_id;
			end if;
            
			if(value_carga_horaria is null) then
				SELECT Carga_horaria INTO value_carga_horaria FROM Empresa.Funcionarios
				WHERE Funcionario_id = value_funcionario_id;
			end if;

            UPDATE Empresa.Funcionarios SET Nome = value_nome, CPF=value_cpf, RG=value_rg, 
            Sexo=value_sexo, Data_nascimento=value_data_nascimento,
			Possui_habilitacao=value_possui_habilitacao, 
            Salario=value_salario, Carga_horaria=value_carga_horaria
            WHERE Funcionario_id = value_funcionario_id;
            
        end if;        
	END $$
delimiter ;

/*DELETE*/
delimiter $$
drop procedure if exists Empresa.delete_funcionario$$
create procedure Empresa.delete_funcionario(query JSON)
	BEGIN
		DECLARE value_funcionario_id INT default null;
        
		set value_funcionario_id = JSON_UNQUOTE(JSON_EXTRACT(query,'$.funcionario_id'));
        
        if (value_funcionario_id is not null) then

            DELETE FROM Empresa.funcionarios  
            WHERE funcionario_id = value_funcionario_id;
            
        end if;        
	END $$
delimiter ;

call Empresa.create_funcionario('{"Nome": "Amanda Lucio", "CPF": "145612553", "RG":"1556333", "Sexo": "F", 
"Data_Nascimento":"25-06-2000", "Possui_habilitacao": true, "Salario":1500, "Carga_horaria":17.5}');
call Empresa.create_funcionario('{"Nome": "Jose Silva", "CPF": "15612553", "RG":"15546333", "Sexo": "M", 
"Data_Nascimento":"17-08-2003", "Possui_habilitacao": false, "Salario":1700, "Carga_horaria":20.5}');
call Empresa.create_funcionario('{"Nome": "Roane Monteiro", "CPF": "445612553", "RG":"3556333", "Sexo": "NB", "Data_Nascimento":"09-09-2006", "Possui_habilitacao": true, "Salario":1300, "Carga_horaria":25}');
call Empresa.create_funcionario('{"Nome": "Roane Silva", "CPF": "143612553", "RG":"36856333", "Sexo": "NB", "Data_Nascimento":"09-09-2006", "Possui_habilitacao": true, "Salario":1300, "Carga_horaria":25}');
call Empresa.read_funcionario('{"Funcionario_id": 1}');
call Empresa.update_funcionario('{"Funcionario_id": 3, "Nome": "Roane Silveira"}');
call Empresa.delete_funcionario('{"Funcionario_id": 4}');

SELECT * FROM Empresa.Funcionarios;
