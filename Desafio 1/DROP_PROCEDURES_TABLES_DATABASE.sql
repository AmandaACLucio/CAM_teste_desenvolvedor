delimiter $$
	drop DATABASE if exists Empresa$$
delimiter ;

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
