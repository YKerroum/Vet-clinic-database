/*Queries that provide answers to the questions from all projects.*/

select * from animals where name like '%mon';

select name from animals where date_of_birth between '2016-01-01' and '2019-12-31';

select name from animals where neutered = true and escape_attempts < 3;

select date_of_birth from animals where name in ('Agumon','Pikachu');

select name, escape_attempts from animals where weight_kg > 10.5;

select * from animals where neutered = true;

select * from animals where name != 'Gabumon';

select * from animals where weight_kg between 10.4 and 17.3;

begin;
update animals set species = 'unspecified';
select * from animals;
rollback;

begin;
update animals set species = 'digimon' where name like '%mon';
update animals set species = 'pokemon' where species is null;
commit;
select * from animals;

begin;
delete from animals;
rollback;
select * from animals;

begin;
delete from animals where date_of_birth > '2022-01-01';
savepoint deleted_animals;
update animals set weight_kg = weight_kg * (-1);
rollback to savepoint deleted_animals;
update animals set weight_kg = weight_kg * (-1) where weight_kg < 0;
commit;

select count(id) as "number of animals" from animals;

select count(id) as "number of never escaped animals" from animals where escape_attempts = 0;

select avg(weight_kg) as "average weight" from animals;

select neutered
from animals 
group by neutered
order by sum(escape_attempts) desc
limit 1;

select species, min(weight_kg) as "min weight", max(weight_kg) as "max weight" 
from animals 
group by species;

select species, avg(escape_attempts) as average_number_of_escape
from animals
where date_of_birth between '1990-01-01' and '2000-12-31'
group by species;

select name from animals inner join owners on animals.owner_id=owners.id where owners.full_name='Melody Pond';

select animals.name from animals inner join species on animals.species_id=species.id where species.name= 'Pokemon';

select full_name as owner_name, name as animal_name 
from owners left join animals on owners.id=animals.owner_id; 

select species.name, count(*) 
from species left join animals on species.id= animals.species_id
group by species.name;

select animals.name as animal_name 
from owners inner join animals on owners.id=animals.owner_id
inner join species on animals.species_id=species.id
where owners.full_name= 'Jennifer Orwell' and species.name= 'Digimon';

select animals.name as animal_name
from owners inner join animals on owners.id=animals.owner_id
where owners.full_name= 'Dean Winchester' and escape_attempts=0;

select owners.full_name as owner_name, count(*) as number_of_animals
from owners left join animals on owners.id=animals.owner_id
group by owners.full_name
order by number_of_animals desc
limit 1;