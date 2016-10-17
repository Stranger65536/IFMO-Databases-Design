use "film collection" 
go

create nonclustered index films
on "films info" ("localized name" asc)
with (pad_index = on)
go

create nonclustered index people
on "people" ("first name" asc, "last name" asc, "birth date" asc, "country id" asc)
go

create unique index filmsID
on "files info" ("film id" asc)
go