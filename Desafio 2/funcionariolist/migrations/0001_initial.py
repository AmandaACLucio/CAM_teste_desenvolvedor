# Generated by Django 4.1.5 on 2023-01-27 23:41

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Funcionario',
            fields=[
                ('Funcionario_id', models.AutoField(primary_key=True, serialize=False)),
                ('Nome', models.CharField(max_length=200, unique=True)),
                ('CPF', models.CharField(max_length=200, unique=True)),
                ('RG', models.CharField(max_length=200, unique=True)),
                ('Sexo', models.CharField(max_length=200)),
                ('Data_nascimento', models.DateField()),
                ('Possui_habilitacao', models.BooleanField()),
                ('Salario', models.FloatField()),
                ('Carga_horaria', models.FloatField()),
                ('Carga_horaria_exercida', models.FloatField()),
            ],
            options={
                'db_table': 'Funcionarios',
            },
        ),
    ]
