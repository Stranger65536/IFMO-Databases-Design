use "film collection" 
go
insert into "people"
values  ('Вигго', 'Мортенсен', '20.10.1958', 3),
		('ВиГГо', 'МорТенсен', '20.10.1958', 3),
		('ВиГГо', 'МортеНсен', '20.10.1958', 4),
		('Вигго', 'Мортенсен', '20.10.1958', 4),
	    ('Вигго', 'Мортенсен', '20.10.1958', 5);

update "people"
set "country id" = 3
where "first name" = 'Вигго' and "last name" = 'Мортенсен' and "birth date" = '20.10.1958' and "country id" = 4

delete from "people"
where "first name" = 'Вигго' and "last name" = 'Мортенсен' and "birth date" = '20.10.1958' and "country id" = 5