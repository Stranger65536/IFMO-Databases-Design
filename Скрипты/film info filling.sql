use "film collection" 

insert into "films info" 
values  (1, 'Operacia Y', 'Операция «Ы» и другие приключения Шурика', '1965', null, '01:35', 69600000, null, null, 3, 1, null),
		(2,	'The Lord of the Rings: The Fellowship of the Ring', 'Властелин колец: Братство кольца', '2001', 'Power can be held in the smallest of things', '02:58', 100000000, null, 93000000, 1, 4, 3), 	
		(3, 'The Lord of the Rings: The Two Towers', 'Властелин колец: Две крепости', '2002', 'Приключение продолжается', '02:59', 150000000, null, 94000000, 1, 3, 3),
		(4,	'The Lord of the Rings: The Return of the King', 'Властелин колец: Возвращение Короля', '2003', 'There can be no triumph without loss. No victory without suffering. No freedom without sacrifice', '03:21', 1650000000, null, 94000000, 1, 3, 3);	

insert into "files info"
values	(1, 1, '\films\Operacia Y (1965).avi', 1564293120, 704, 528, 3, 7, 1),
		(2, 2, '\films\The Lord of the Rings: The Fellowship of the Ring (2001).mkv', 14416671502, 1280, 534, 1, 8, 12),
		(3, 3, '\films\The Lord of the Rings: The Two Towers (2002).mkv', 14903363544, 1280, 536, 1, 8, 12),
		(4, 4, '\films\The Lord of the Rings: The Return of the King (2003).mkv', 17658135843, 1280, 532, 1, 8, 12);

insert into "people in film"
values  (1, 1, 2),
		(1, 2, 9),
		(1, 3, 9),
		(1, 4, 9),
		(1, 5, 9),
		(1, 6, 9),
		(1, 7, 9),
		(1, 8, 9),
		(1, 9, 9),
		(1, 10, 9),
		(1, 15, 4),
		(1, 1, 3),
		(1, 14, 3),
		(1, 13, 5),
		(1, 16, 6),
		(1, 12, 7),
		(1, 11, 8),
		(1, 17, 3),
		(2, 18, 2),
		(2, 19, 3),
		(2, 20, 9),
		(2, 21, 9),
		(2, 22, 9),
		(3, 18, 2),
		(3, 19, 3),
		(3, 20, 9),
		(3, 21, 9),
		(3, 22, 9),
		(4, 18, 2),
		(4, 19, 3),
		(4, 20, 9),
		(4, 21, 9),
		(4, 22, 9);
		
insert into "films genre"
values  (1, 2),
		(1, 3),
		(1, 4),
		(2, 2),
		(2, 9),
		(3, 2),
		(3, 9),
		(4, 2),
		(4, 9);