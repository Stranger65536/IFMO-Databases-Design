use "film collection"
go

declare @temptable1 table ("localized name"	nvarchar(80) not null, "link" varchar(800) not null unique)

select "localized name", "link"
into #temptable1
from "films info", "files info"
where "films info"."film id" = "files info"."film id"

select * from #temptable1

drop table #temptable1
go


create procedure "#year range temp"
as
	select min(year("films info"."year")) as "min year", max(year("films info"."year")) as "max year"
	from "films info"
go

exec "#year range temp"
go

drop procedure "#year range temp"
go


declare @temptable1 table ("year" int)
insert into @temptable1
select year("films info"."year") from "films info"
select * from @temptable1
go