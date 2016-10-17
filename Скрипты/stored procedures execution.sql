use "film collection"

exec "films by people" @firstname = 'Элайджа', @lastname = 'Вуд';
go

exec "year range"
go

declare @filesize int;
declare @filelink varchar(800);
set @filesize = 0;
set @filelink = '/films/Operacia Y (1965).avi';
exec "get file size by link" @link = @filelink, @size = @filesize output
select @filelink as "link", @filesize as "size"