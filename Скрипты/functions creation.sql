use "film collection"
go

create function "get count of films by person" (@firstname varchar(80), @lastname varchar(80), @birthdate date, @countryid int)
returns int
as
begin 
	declare @personid int
	declare @count int
	set @personid = 0
	select @personid = "people"."people id"
	from "people"
	where	@firstname = "people"."first name" and 
			@lastname = "people"."last name" and 
			@birthdate = "people"."birth date" and 
			@countryid = "people"."country id"
	select @count = count(distinct "people in film"."film id")
	from "people in film"
	where "people id" = @personid
	return @count
end
go

create function "get min year" ()
returns int
as
begin
	declare @min int
	select @min = year(min("films info"."year"))
	from "films info"
	return @min
end
go

create function "get count of people by film id"(@id int)
returns int
as 
begin
	declare @count int
	select @count = count(distinct "people in film"."people id")
	from "people in film"
	where "film id" = @id
	return @count
end