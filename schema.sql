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