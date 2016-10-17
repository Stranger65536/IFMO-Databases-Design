use "film collection" 
go

create view "films & files"
as
select "localized name", "link"
from "films info", "files info"
where "films info"."film id" = "files info"."film id"
go

create view "people & countries"
as
select "first name", "last name", "name"
from "people", "countries"
where "people"."country id" = "countries"."country id"
go

create view "films & restrictions"
as
select "localized name", "value"
from "films info", "age restrictions"
where "films info"."age restriction id" = "age restrictions"."restriction id"
go