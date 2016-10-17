use "film collection"
go
create procedure "films by people"
	@firstname varchar(80),
	@lastname  varchar(80)
as
	select "films info"."english name", year("films info"."year") as "year"
	from "films info"
	where "film id" in
		(select "people in film"."film id"
		from "people in film"
		where "people in film"."people id" in
			(select "people"."people id" 
			from "people"
			where "people"."first name" = @firstname and "people"."last name" = @lastname
			)
		)
go

create procedure "year range"
as
	select min(year("films info"."year")) as "min year", max(year("films info"."year")) as "max year"
	from "films info"
go

create procedure "get file size by link"
	@link	  varchar(800),
	@size     bigint		 output
as
	select @size = "files info"."file size"
	from "files info"
	where @link = "files info"."link"