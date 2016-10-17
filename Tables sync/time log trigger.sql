use first
go

create trigger "time log table 1"
on Table1
for update, insert
as
	declare @id int 
	declare insertedData cursor local forward_only static 
		for select id from inserted
	open insertedData
	
	fetch next from insertedData into @id
		
	while @@fetch_status = 0
	begin
		update Table1
		set Table1.log_time = SYSDATETIME()
		where id = @id
		fetch next from insertedData into @id
	end
	
	close insertedData
	deallocate insertedData
go

create trigger "time log table 2"
on Table2
for update, insert
as
	declare @id int 
	declare insertedData cursor local forward_only static 
		for select id from inserted
	open insertedData
	
	fetch next from insertedData into @id
		
	while @@fetch_status = 0
	begin
		update Table2
		set Table2.log_time = SYSDATETIME()
		where id = @id
		fetch next from insertedData into @id
	end
	
	close insertedData
	deallocate insertedData
go

use second
go

create trigger "time log table 1"
on Table1
for update, insert
as
	declare @id int 
	declare insertedData cursor local forward_only static 
		for select id from inserted
	open insertedData
	
	fetch next from insertedData into @id
		
	while @@fetch_status = 0
	begin
		update Table1
		set Table1.log_time = SYSDATETIME()
		where id = @id
		fetch next from insertedData into @id
	end
	
	close insertedData
	deallocate insertedData
go

create trigger "time log table 2"
on Table2
for update, insert
as
	declare @id int 
	declare insertedData cursor local forward_only static 
		for select id from inserted
	open insertedData
	
	fetch next from insertedData into @id
		
	while @@fetch_status = 0
	begin
		update Table2
		set Table2.log_time = SYSDATETIME()
		where id = @id
		fetch next from insertedData into @id
	end
	
	close insertedData
	deallocate insertedData
go