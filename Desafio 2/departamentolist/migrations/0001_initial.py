# Generated by Django 4.1.5 on 2023-01-19 01:59

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Departamento',
            fields=[
                ('Departamento_id', models.AutoField(primary_key=True, serialize=False)),
                ('Nome', models.CharField(max_length=200, unique=True)),
            ],
            options={
                'db_table': 'Departamentos',
            },
        ),
    ]