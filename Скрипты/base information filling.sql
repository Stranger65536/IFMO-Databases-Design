use "film collection" 

insert into "file formats"
values  ('mkv', 'matroshka file format'), 
		('mp4', 'MPEG-4 part 14'),
		('avi', 'Audio Video Interleave');
		
insert into "codecs" ("name")
values  ('DivX Low Motion'),
		('DivX Fast Motion'),
		('MPEG-1'),
		('MPEG-2'),
		('MPEG-4'),
		('Motion JPEG'),
		('xvid'),
		('x264'),
		('nuv'),
		('raw'),
		('copy'),
		('frameno'),
		('avc');
		
insert into "aspect ratios"
values	('4:3'),
		('1,375:1'),
		('1,43:1'),
		('3:2'),
		('14:9'),
		('16:10'),
		('1,66:1'),
		('1,85:1'),
		('16:9'),
		('2,2:1'),
		('2,35:1'),
		('2,39:1'),
		('2,4:1'),
		('2,55:1'),
		('2,6:1'),
		('2,75:1');
		
insert into "currencies" 
values	('dollar', '$'),
		('euro', '€'),
		('rouble', null);
		
insert into "genres" ("name")
values  ('Action'),
		('Adventure'),
		('Comedy'),
		('Crime'),
		('Drama'),
		('Epic'),
		('Horror'),
		('Sci-fi'),
		('War'),
		('Western');
		
insert into "age restrictions" ("value")
values  ('0+'),
		('6+'),
		('12+'),
		('16+'),
		('18+');
		
insert into "mpaa rating"
values  ('G', 'General Audiences'),
		('PG', 'Parental Guidance Suggested'),
		('PG-13', 'Parents Strongly Cautioned'),
		('R', 'Restricted'),
		('NC-17', 'No One 17 & Under Admitted'); 
		
insert into "countries"
values  ('Russia'),
		('USSR'),
		('USA'),
		('RSFSR'),
		('Austria'),
		('Ukraine'),
		('New Zealand'),
		('Great Britan');
		
insert into "people" 
values  ('Леонид', 'Гайдай', '30.01.1923', 2),
		('Александр', 'Демьяненко', '30.05.1937', 2),
		('Наталья', 'Селезнёва', '19.06.1945', 2),
		('Алексей', 'Смирнов', '28.02.1920', 4),
		('Юрий', 'Никулин', '18.12.1921', 1),
		('Евгений', 'Моргунов', '27.04.1927', 2),
		('Георгий', 'Вицин', '18.04.1917', 1),
		('Михаил', 'Пуговкин', '13.07.1923', 2),
		('Виктор', 'Павлов', '5.10.1940', 2),
		('Владимир', 'Басов', '28.07.1923', 2),
		('Валентина', 'Янковская', null, null),
		('Артур', 'Бергер', '27.05.1892', 5),
		('Константин', 'Бровин', null, null),
		('Морис', 'Слободской', '30.11.1913', 1),
		('Петр', 'Феллер', null, null),
		('Александр', 'Зацепин', '10.03.1926', 2),
		('Яков', 'Костюковский', '23.08.1921', 6),
		('Питер', 'Джексон', '31.10.1961', 7),
		('Фрэнсис', 'Уолш', '10.01.1959', 7),
		('Элайджа', 'Вуд', '28.01.1981', 3),
		('Иэн', 'МакКеллен', '25.05.1939', 8),
		('Вигго', 'Мортенсен', '20.10.1958', 3);
		
insert into "positions" ("name")
values  ('director'),
		('stage manager'),
		('screenwriter'),
		('producer'),
		('operator'),
		('composer'),
		('painter'),
		('editior'),
		('actor');