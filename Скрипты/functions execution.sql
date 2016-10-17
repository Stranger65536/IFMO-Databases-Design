use "film collection"
go

select "dbo"."get count of films by person" ('Питер', 'Джексон', '1961-10-31', 7)
select "dbo"."get count of films by person" ('Леонид', 'Гайдай'	,'1923-01-30', 2)
select "dbo"."get min year"()
select "dbo"."get count of people by film id"(1)