/*Criando database*/
delimiter $$
	drop DATABASE if exists Empresa$$
delimiter ;

CREATE DATABASE Empresa;

/*Removendo tabelas e procedures existentes*/
delimiter $$
	drop PROCEDURE if exists Empresa.create_projeto$$
	drop PROCEDURE if exists Empresa.create_funcionario$$
	drop PROCEDURE if exists Empresa.create_projeto$$
	drop PROCEDURE if exists Empresa.create_relacao_projeto_funcionario$$

	drop PROCEDURE if exists Empresa.read_projeto$$
	drop PROCEDURE if exists Empresa.read_funcionario$$
	drop PROCEDURE if exists Empresa.read_projeto$$
	drop PROCEDURE if exists Empresa.read_relacao_projeto_funcionario$$
    
	drop PROCEDURE if exists Empresa.update_projeto$$
	drop PROCEDURE if exists Empresa.update_funcionario$$
	drop PROCEDURE if exists Empresa.update_projeto$$
	drop PROCEDURE if exists Empresa.update_relacao_projeto_funcionario$$

	drop PROCEDURE if exists Empresa.delete_projeto$$
	drop PROCEDURE if exists Empresa.delete_funcionario$$
	drop PROCEDURE if exists Empresa.delete_projeto$$
	drop PROCEDURE if exists Empresa.delete_relacao_projeto_funcionario$$
    
	drop TABLE if exists Empresa.Relacoes_projetos_funcionarios$$
	drop TABLE if exists Empresa.Projetos$$
	drop TABLE if exists Empresa.Departamentos$$
	drop TABLE if exists Empresa.Funcionarios$$

delimiter ;

/*Criando tabelas*/

/*Departamentos*/
CREATE TABLE Empresa.Departamentos (
    Departamento_id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Nome varchar(255) UNIQUE
);

/*Funcionarios*/
CREATE TABLE Empresa.Funcionarios (
    Funcionario_id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Nome varchar(255) UNIQUE,
    CPF varchar(255) UNIQUE,
    RG varchar(255) UNIQUE,
    SEXO varchar(255),
    Data_nascimento date,
    Possui_habilitacao boolean,
    Salario float,
    Carga_horaria float
);

/*Projetos*/
CREATE TABLE Empresa.Projetos (
    Projeto_id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Departamento_id int NOT NULL,
    Supervisor_id int NOT NULL,
    Nome varchar(255) UNIQUE,
    Horas_conclusao float,
    Prazo_estimado date,
    Horas_realizadas float,
    Ultimo_calculo_horas date,
	FOREIGN KEY (Departamento_id) REFERENCES Empresa.Departamentos(Departamento_id) ON DELETE CASCADE,
	FOREIGN KEY (Supervisor_id) REFERENCES Empresa.Funcionarios(Funcionario_id) ON DELETE CASCADE
);

/*Relacoes_projetos_funcionarios*/
CREATE TABLE Empresa.Relacoes_projetos_funcionarios(
	Relacao_id int NOT NULL PRIMARY KEY AUTO_INCREMENT,
    Projeto_id int NOT NULL,
    Funcionario_id int NOT NULL,
    Carga_horaria float NOT NULL,
  	FOREIGN KEY (Projeto_id) REFERENCES Empresa.Projetos(Projeto_id) ON DELETE CASCADE,
	FOREIGN KEY (Funcionario_id) REFERENCES Empresa.Funcionarios(Funcionario_id) ON DELETE CASCADE
);