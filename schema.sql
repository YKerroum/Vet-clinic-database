/* Database schema to keep the structure of entire database. */

create table if not exists animals (
  id int primary key GENERATED ALWAYS AS IDENTITY,
  name varchar(100) not null,
  date_of_birth date not null,
  escape_attempts int not null,
  neutered boolean not null,
  weight_kg decimal not null
);

alter table animals
add column species varchar(100);

create table if not exists owners (
id int primary key GENERATED always as IDENTITY,
full_name varchar(100) not null,
age int not null
);

create table if not exists species (
id int primary key GENERATED always as IDENTITY,
name varchar(100) not null
);

do $$
begin
if NOT exists (select constraint_name from information_schema.table_constraints where table_name = 'animals' and constraint_type = 'PRIMARY KEY') OR (select is_identity  from information_schema.columns where table_name = 'animals' and column_name= 'id') != 'YES' then
ALTER TABLE animals
ADD PRIMARY KEY (id);
alter table animals
ALTER COLUMN id SET GENERATED ALWAYS;
end if;
end $$;

alter table animals
drop column species;

alter table animals
add column species_id int references species(id); 

alter table animals
add column owner_id int references owners(id);

create table if not exists vets (
id int GENERATED ALWAYS AS IDENTITY,
name varchar(100) not null,
age int not null,
date_of_graduation date not null,
primary key (id)
);

create table if not exists specializations (
species_id int references species(id),
veterinarian_id int references vets(id),
);

create table if not exists visits (
animal_id int references animals(id),
veterinarian_id int references vets(id),
date_of_visit date not null,
);

