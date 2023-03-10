/* CRUD Projetos */

/*CREATE*/
delimiter $$
drop procedure if exists Empresa.create_projeto$$
create procedure Empresa.create_projeto(query JSON)
	BEGIN
    
		DECLARE value_departamento_id INT default null;
		DECLARE value_nome varchar(255) default null;
		DECLARE value_horas_conclusao float default null;
		DECLARE value_prazo_estimado date default null;
		DECLARE value_horas_realizadas float default null;
        DECLARE value_ultimo_calculo_horas date default null;

		set value_departamento_id = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Departamento_id'));
		set value_nome = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Nome'));
		set value_horas_conclusao = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Horas_conclusao'));
		set value_prazo_estimado = STR_TO_DATE(JSON_UNQUOTE(JSON_EXTRACT(query,'$.Prazo_estimado')),"%d-%m-%Y");
		set value_horas_realizadas = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Horas_realizadas'));
        set value_ultimo_calculo_horas = current_date();
        
        if (value_departamento_id is not null)  AND 
        (value_nome is not null) AND (value_horas_conclusao is not null) AND
        (value_prazo_estimado is not null) AND (value_horas_realizadas is not null) then

            INSERT INTO Empresa.Projetos (Departamento_id, Nome, Horas_conclusao,
            Prazo_estimado, Horas_realizadas, Ultimo_calculo_horas) 
            VALUES (value_departamento_id, value_nome, value_horas_conclusao, 
            value_prazo_estimado, value_horas_realizadas, value_ultimo_calculo_horas);
            
        end if;        
	END $$
delimiter ;

/*READ*/
delimiter $$
drop procedure if exists Empresa.read_projeto$$
create procedure Empresa.read_projeto(query JSON)
	BEGIN
		DECLARE value_projeto_id INT default null;
        
		set value_projeto_id = JSON_UNQUOTE(JSON_EXTRACT(query,'$.projeto_id'));
        
        if (value_projeto_id is not null) then

            SELECT * FROM Empresa.Projetos
            WHERE Projeto_id = value_projeto_id;
            
        end if;        
	END $$
delimiter ;

/*UPDATE*/
delimiter $$
drop procedure if exists Empresa.update_projeto$$
create procedure Empresa.update_projeto(query JSON)
	BEGIN
		DECLARE value_projeto_id INT default null;
		DECLARE value_departamento_id INT default null;
		DECLARE value_nome varchar(255) default null;
		DECLARE value_horas_conclusao float default null;
		DECLARE value_prazo_estimado date default null;
		DECLARE value_horas_realizadas float default null;

		set value_projeto_id = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Projeto_id'));
		set value_departamento_id = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Departamento_id'));
		set value_nome = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Nome'));
		set value_horas_conclusao = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Horas_conclusao'));
		set value_prazo_estimado = STR_TO_DATE(JSON_UNQUOTE(JSON_EXTRACT(query,'$.Prazo_estimado')),"%d-%m-%Y");
		set value_horas_realizadas = JSON_UNQUOTE(JSON_EXTRACT(query,'$.Horas_realizadas'));
        
        if (value_projeto_id is not null) then

			if(value_nome is null) then
				SELECT Nome INTO value_nome FROM Empresa.Projetos
				WHERE Projeto_id = value_projeto_id;
			end if;

			if(value_horas_conclusao is null) then
				SELECT Horas_conclusao INTO value_horas_conclusao FROM Empresa.Projetos
				WHERE Projeto_id = value_projeto_id;
			end if;            

			if(value_prazo_estimado is null) then
				SELECT Prazo_estimado INTO value_prazo_estimado FROM Empresa.Projetos
				WHERE Projeto_id = value_projeto_id;
			end if;               
            
			if(value_horas_realizadas is null) then
				SELECT Horas_realizadas INTO value_horas_realizadas FROM Empresa.Projetos
				WHERE Projeto_id = value_projeto_id;
			end if;   

            UPDATE Empresa.Projetos SET Departamento_id = value_departamento_id,
            Nome=value_nome, Horas_conclusao=value_horas_conclusao, Prazo_estimado=value_prazo_estimado,
            Horas_realizadas=value_horas_realizadas, Ultimo_calculo_horas= current_date()
            WHERE Projeto_id = value_projeto_id;
            
        end if;        
	END $$
delimiter ;

/*DELETE*/
delimiter $$
drop procedure if exists Empresa.delete_projeto$$
create procedure Empresa.delete_projeto(query JSON)
	BEGIN
		DECLARE value_projeto_id INT default null;
        
		set value_projeto_id = JSON_UNQUOTE(JSON_EXTRACT(query,'$.projeto_id'));
        
        if (value_projeto_id is not null) then

            DELETE FROM Empresa.projetos  
            WHERE Projeto_id = value_projeto_id;
            
        end if;        
	END $$
delimiter ;


call Empresa.create_projeto('{"Departamento_id": 1, "Nome": "CAM SQL",  
"Horas_conclusao": 54.5, "Prazo_estimado": "14-6-2023", "Horas_realizadas": 20.5}');
call Empresa.create_projeto('{"Departamento_id": 3,"Nome": "CAM BD",  
"Horas_conclusao": 37.5, "Prazo_estimado": "14-5-2023", "Horas_realizadas": 18.5}');
call Empresa.create_projeto('{"Departamento_id": 4, "Nome": "CAM Backoffice",  
"Horas_conclusao": 27.5, "Prazo_estimado": "21-4-2023", "Horas_realizadas": 19.5}');
call Empresa.read_projeto('{"Projeto_id": 1}');
call Empresa.update_projeto('{"Projeto_id": 2, "Departamento_id": 3}');
call Empresa.delete_projeto('{"Projeto_id": 3}');
SELECT * FROM Empresa.Projetos;
