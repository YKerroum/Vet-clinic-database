/* Populate database with sample data. */

INSERT INTO animals (name,date_of_birth, escape_attempts, neutered, weight_kg) 
VALUES ('Agumon','2020-02-03',0,true, 10.23),
('Gabumon','2018-11-15',2,true, 8.0),
('Pikachu','2021-01-07',1,false,15.04),
('Devimon','2017-05-12',5,true,11.0);

INSERT INTO animals (name,date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Charmander','2020-02-08',0,false, -11),
('Plantmon','2021-11-15',2,true, -5.7),
('Squirtle','1993-04-02',3,false, -12.13),
('Angemon','2005-06-12',1,true, -45),
('Boarmon','2005-06-07',7,true,20.4),
('Blossom','1998-10-13',3,true,17),
('Ditto','2022-05-14',4,true,22);

INSERT INTO owners (full_name, age)
VALUES ('Sam Smith',34),
('Jennifer Orwell',19),
('Bob',45),
('Melody Pond',77),
('Dean Winchester',14),
('Jodie Whittaker',38);

INSERT INTO species (name)
VALUES ('Pokemon'),
('Digimon');

UPDATE animals
SET species_id = case 
when name like '%mon' then (select id from species where name= 'Digimon')
else (select id from species where name = 'Pokemon')
end;

UPDATE animals
SET owner_id = case 
when name = 'Agumon' then (select id from owners where full_name= 'Sam Smith')
when name in ('Gabumon','Pikachu') then (select id from owners where full_name= 'Jennifer Orwell')
when name in ('Devimon','Plantmon') then (select id from owners where full_name= 'Bob')
when name in ('Charmander','Squirtle','Blossom') then (select id from owners where full_name= 'Melody Pond')
when name in ('Angemon','Boarmon') then (select id from owners where full_name= 'Dean Winchester')
end;

INSERT INTO vets (name, age, date_of_graduation)
VALUES ('William Tatcher',45,'2000-04-23'),
('Maisy Smith',26,'2019-01-17'),
('Stephanie Mendez',64,'1981-05-04'),
('Jack Harkness',38,'2008-06-08');

INSERT INTO specializations
(species_id, veterinarian_id) VALUES
((select id from species where name = 'Pokemon'), (select id from vets where name = 'William Tatcher')),
((select id from species where name = 'Digimon'), (select id from vets where name = 'Stephanie Mendez')),
((select id from species where name = 'Pokemon'), (select id from vets where name = 'Stephanie Mendez')),
((select id from species where name = 'Digimon'), (select id from vets where name = 'Jack Harkness'));

INSERT INTO visits (animal_id, veterinarian_id, date_of_visit)
VALUES
((select id from animals where name = 'Agumon'), (select id from vets where name = 'William Tatcher'), '2020-05-24'),
((select id from animals where name = 'Agumon'), (select id from vets where name = 'Stephanie Mendez'), '2020-07-22'),
((select id from animals where name = 'Gabumon'), (select id from vets where name = 'Jack Harkness'), '2021-02-02'),
((select id from animals where name = 'Pikachu'), (select id from vets where name = 'Maisy Smith'), '2020-01-05'),
((select id from animals where name = 'Pikachu'), (select id from vets where name = 'Maisy Smith'), '2020-03-08'),
((select id from animals where name = 'Pikachu'), (select id from vets where name = 'Maisy Smith'), '2020-05-14'),
((select id from animals where name = 'Devimon'), (select id from vets where name = 'Stephanie Mendez'), '2021-05-04'),
((select id from animals where name = 'Charmander'), (select id from vets where name = 'Jack Harkness'), '2021-02-24'),
((select id from animals where name = 'Plantmon'), (select id from vets where name = 'Maisy Smith'), '2019-12-21'),
((select id from animals where name = 'Plantmon'), (select id from vets where name = 'William Tatcher'), '2020-08-10'),
((select id from animals where name = 'Plantmon'), (select id from vets where name = 'Maisy Smith'), '2021-04-07'),
((select id from animals where name = 'Squirtle'), (select id from vets where name = 'Stephanie Mendez'), '2019-09-29'),
((select id from animals where name = 'Angemon'), (select id from vets where name = 'Jack Harkness'), '2020-10-03'),
((select id from animals where name = 'Angemon'), (select id from vets where name = 'Jack Harkness'), '2020-11-04'),
((select id from animals where name = 'Boarmon'), (select id from vets where name = 'Maisy Smith'), '2019-01-24'),
((select id from animals where name = 'Boarmon'), (select id from vets where name = 'Maisy Smith'), '2019-05-15'),
((select id from animals where name = 'Boarmon'), (select id from vets where name = 'Maisy Smith'), '2020-02-27'),
((select id from animals where name = 'Boarmon'), (select id from vets where name = 'Maisy Smith'), '2020-08-03'),
((select id from animals where name = 'Blossom'), (select id from vets where name = 'Stephanie Mendez'), '2020-05-24'),
((select id from animals where name = 'Blossom'), (select id from vets where name = 'William Tatcher'), '2021-01-11');


INSERT INTO visits (animal_id, veterinerian_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';