# Desafio Back-end

- [Interpretação](#Interpretação)
- [Desafio 1](#Desafio1)
- [Desafio 2](#Desafio2)


## Interpretaçao

Interpretando o problema foi notada que a quantidade de horas que um funcionário trabalha é igual a soma da quantidade de horas de projetos os quais ele superviosiona, juntamente com com a quantidade de horas de projetos os quais ele é funcionário. Sendo assim, são necessárias tabelas auxiliares para determinar a carga-horária dedicada a cada projeto supervisionada ou o qual o funcionário trabalho.

Na tabela Projetos temos que que a quantidade de horas realizadas no projeto igual à soma de horas de trabalho realizadas pelos funcionários (somente, sem o supervisor), dividido pelo número de semanas passadas desde a data do último cálculo, registrada no campo Ultimo_calculo_horas.

## Desafio 1

### Lista de arquivos

- Create_tables.sql: Primeiro a ser rodado, para exclusão de tabelas, procedures e database existentes e criação da database "Empresa" e suas respectivas tabelas:
    - Departamentos: Tabela para armazenar os nomes dos departamentos existentes.
    - Funcionários: Tabela para armazenas os dados dos funcionários existentes.
    - Projetos: Tabela para armazenar os dados dos projetos existentes, contendo duas chaves estrangeiras, uma para o funcionário supervisor e outra para o departamento correspondente.
    - Relacoes_projetos_funcionarios: Tabela utilizar para armazenas as relações entre os funcionários e projetos, assim como a carga horária destinada pelo funcionário para o dado projeto.
    - Relacoes_projetos_supervisores: Tabela utilizar para armazenas as relações entre os supervisores e projetos, assim como a carga horária destinada pelo supervisor para um dado projeto. Cada projeto tem um único supervisor.
    ![Modelagem de dados do BD](https://github.com/AmandaACLucio/CAM_teste_desenvolvedor/blob/master/Modelagem.png)


- CRUD_Departamentos.sql: Arquivo contendo as procedures da tabela Departamentos:
    - Empresa.create_departamento: Insere dados no BD
    ```sql
    call Empresa.create_departamento('{"Nome": "Estratégia"}');
    ```
    - Empresa.read_departamento: Leitura de dados no BD através da chave primária *departamento_id*
    ```sql
    call Empresa.read_departamento('{"Departamento_id": 1}');
    ```
    - Empresa.update_departamento: Atualiza o campo nome de um dado específicado através do campo *departamento_id*
    ```sql
    call Empresa.update_departamento('{"Departamento_id": 1, "Nome": "Estratégia e Gestão"}');
    ```
    - Empresa.delete_departamento: Deleção de dados no BD através da chave primária *departamento_id*
    ```sql
    call Empresa.delete_departamento('{"Departamento_id": 2}');
    ```

- CRUD_Funcionarios.sql: Arquivo contendo as procedures da tabela Funcionarios:
    - Empresa.create_funcionario: Insere dados no BD
    ```sql
    call Empresa.create_funcionario('{"Nome": "Jose Silva", "CPF": "15612553", "RG":"15546333", "Sexo": "M", 
    "Data_Nascimento":"17-08-2003", "Possui_habilitacao": false, "Salario":1700, "Carga_horaria":20.5}');
    ```
    - Empresa.read_funcionario: Leitura de dados no BD através da chave primária *funcionario_id*
    ```sql
    call Empresa.read_funcionario('{"Funcionario_id": 1}');
    ```
    - Empresa.update_funcionario: Atualiza um campo ou mais de um dado específicado através do campo *funcionario_id*
    ```sql
    call Empresa.update_funcionario('{"Funcionario_id": 3, "Nome": "Roane Silveira"}');
    ```
    - Empresa.delete_funcionario: Deleção de dados no BD através da chave primária *funcionario_id*
    ```sql
    call Empresa.delete_funcionario('{"Funcionario_id": 4}');
    ```

- CRUD_Projetos.sql: Arquivo contendo as procedures da tabela Projetos:
    - Empresa.create_projeto: Insere dados no BD
    ```sql
    call Empresa.create_projeto('{"Departamento_id": 1, "Supervisor_id": 1, "Nome": "CAM Back",  "Horas_conclusao": 54.5, "Prazo_estimado": "14-6-2023", "Horas_realizadas": 20.5, "Ultimo_calculo_horas":"14-1-2023"}');
    ```
    - Empresa.read_projeto: Leitura de dados no BD através da chave primária *projeto_id*
    ```sql
    call Empresa.read_projeto('{"Projeto_id": 1}');
    ```
    - Empresa.update_projeto: Atualiza um campo ou mais de um dado específicado através do campo *projeto_id*
    ```sql
    call Empresa.update_projeto('{"Projeto_id": 2, "Departamento_id": 3, "Supervisor_id": 3}');
    ```
    - Empresa.delete_projeto: Deleção de dados no BD através da chave primária *projeto_id*
    ```sql
    call Empresa.delete_projeto('{"Projeto_id": 3}');
    ```

- CRUD_Relacoes_projetos_funcionarios.sql: Arquivo contendo as procedures da tabela Relacoes_projetos_funcionarios:
    - Empresa.create_relacao_projeto_funcionario: Insere dados no BD
    ```sql
    call Empresa.create_relacao_projeto_funcionario('{"Projeto_id": 2, "Funcionario_id": 2, "Carga_horaria": 20.5}');    
    ```
    - Empresa.read_departamento: Leitura de dados no BD através da chave primária *departamento_id*
    ```sql
    call Empresa.read_relacao_projeto_funcionario('{"Relacao_id": 1}');
    ```
    - Empresa.update_departamento: Atualiza um campo ou mais de um dado específicado através do campo *departamento_id*
    ```sql
    call Empresa.update_relacao_projeto_funcionario('{"Relacao_id": 3, "Carga_horaria": 14.5}');    
    ```
    - Empresa.delete_departamento: Deleção de dados no BD através da chave primária *departamento_id*
    ```sql
    call Empresa.delete_relacao_projeto_funcionario('{"Relacao_id": 2}');
    ```

- CRUD_Relacoes_projetos_supervisores.sql: Arquivo contendo as procedures da tabela Relacoes_projetos_supervisores.:
    - Empresa.create_relacao_projeto_supervisor: Insere dados no BD
    ```sql
    call Empresa.create_relacao_projeto_supervisor('{"Projeto_id": 2, "Supervisor_id": 2, "Carga_horaria": 20.5}');    
    ```
    - Empresa.read_departamento: Leitura de dados no BD através da chave primária *departamento_id*
    ```sql
    call Empresa.read_relacao_projeto_supervisor('{"Relacao_id": 1}');
    ```
    - Empresa.update_departamento: Atualiza um campo ou mais de um dado específicado através do campo *departamento_id*
    ```sql
    call Empresa.update_relacao_projeto_supervisor('{"Relacao_id": 3, "Carga_horaria": 14.5}');    
    ```
    - Empresa.delete_departamento: Deleção de dados no BD através da chave primária *departamento_id*
    ```sql
    call Empresa.delete_relacao_projeto_supervisor('{"Relacao_id": 2}');
    ```


## Desafio 2

### Instalações
- python 3
- pip3 install django
- pip3 install djangorestframework
- pip3 install pymysql
- pip3 install django-cors-headers
- pip3 install datetime
- mysql> CREATE DATABASE IF NOT EXISTS Empresa;

### Inserindo models no BD
- Dentro da pasta Desafio 2
```shell
python manage.py makemigrations departamentolist
python manage.py makemigrations funcionariolist
python manage.py makemigrations projetolist
python manage.py makemigrations relacaolist
python manage.py migrate
```

### End-Points
- api/departamentos/
- api/departamentos/<int:Departamento_id>/
- api/funcionarios/
- api/funcionarios/<int:Funcionario_id>/
- api/projetos/
- api/projetos/<int:Funcionario_id>/
- api/relacoesprojetosfuncionarios/
- api/relacoesprojetosfuncionarios/<int:Relacao_id>/
- api/relacoesprojetossupervisores/
- api/relacoesprojetossupervisores/<int:Relacao_id>/

![Testando API no Postman](https://github.com/AmandaACLucio/CAM_teste_desenvolvedor/blob/master/Desafio%202/Postman.png)