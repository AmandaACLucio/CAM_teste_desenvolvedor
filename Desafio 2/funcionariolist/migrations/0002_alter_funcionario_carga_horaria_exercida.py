# Generated by Django 4.1.5 on 2023-01-27 23:48

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('funcionariolist', '0001_initial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='funcionario',
            name='Carga_horaria_exercida',
            field=models.FloatField(default=0),
        ),
    ]
