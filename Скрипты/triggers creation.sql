use "film collection" 
go

create trigger "exclude duplication on insert/update"
on "people"
for insert, update
as
	declare @firstname	varchar(80)
	declare @lastname	varchar(80)
	declare @birthdate	date
	declare @countryid	int
	declare @peopleid   int
	declare @count int
	
	declare insertedData cursor local forward_only static 
		for select "people id", "first name", "last name", "birth date", "country id" from inserted;
		
	open insertedData
	
	fetch next from insertedData into @peopleid, @firstname, @lastname, @birthdate, @countryid	
		
	while @@fetch_status = 0
	begin
		select @count = count(*) from "people"
		where	"first name" Collate Cyrillic_General_CS_AS = @firstname and 
				"last name" Collate Cyrillic_General_CS_AS = @lastname and 
				"birth date" = @birthdate and 
				"country id" = @countryid
	
		if (@count = 2)
		begin
			delete from "people"
			where "people id" = @peopleid
		end
		
		fetch next from insertedData into @peopleid, @firstname, @lastname, @birthdate, @countryid
	end
	
	close insertedData
	deallocate insertedData
go

create trigger "format names on create/update"
on "people"
for insert, update
as
	declare @id int
	declare @firstname varchar(80)
	declare @lastname  varchar(80)
	declare @length	int
	declare @newfirstname varchar(80)
	declare @newlastname  varchar(80)
	
	declare insertedData cursor local forward_only static 
		for select "people id", "first name", "last name" from inserted;
		
	open insertedData
	
	fetch next from insertedData into @id, @firstname, @lastname
	
	while @@fetch_status = 0
	begin
		--does not deleted by another trigger
		if exists
		(
			select count(*)
			from "people"
			where "people id" = @id
		)
		begin
			--if bad names, delete
			if ((len(@firstname) = 0) or (len(@lastname) = 0))
			begin
				delete from "people"
				where "people id" = @id	
			end
			else
			begin
				set @length = len(@firstname)
				set @newfirstname = upper(substring(@firstname, 1, 1)) + lower(substring(@firstname, 2, @length - 1))
				set @length = len(@lastname)
				set @newlastname = upper(substring(@lastname, 1, 1)) + lower(substring(@lastname, 2, @length - 1))
				
				--if new names equals old, do nothing
				if ((@newfirstname Collate Cyrillic_General_CS_AS != @firstname) or (@newlastname Collate Cyrillic_General_CS_AS != @lastname))
				begin
					update "people"
					set "first name" = @newfirstname, "last name" = @newlastname 
					where "people id" = @id
				end
			end
		end
		
		fetch next from insertedData INTO @id, @firstname, @lastname
	end
	
	close insertedData
	deallocate insertedData
go
	
create trigger "unix/linux links format"
on "files info"
for insert, update
as
	declare @id int
	
	declare insertedData cursor local forward_only static 
		for select "file id" from inserted;
		
	open insertedData
	
	fetch next from insertedData into @id
	
	while @@fetch_status = 0
	begin
		update "files info"
		set "link" = replace ("link", '\', '/')
		where "file id" = @id
		
		fetch next from insertedData INTO @id
	end
	
	close insertedData
	deallocate insertedData
go
	