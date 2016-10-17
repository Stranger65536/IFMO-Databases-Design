use "film collection"
go

create assembly SqlStackSelect
authorization dbo
from 'C:\SqlStackSelect.dll'
with permission_set = unsafe
go

create procedure savecolumntofile
	@tablename nvarchar(50),
	@columnname nvarchar(50),
	@savepath nvarchar(50)
as external name SqlStackSelect.[SqlStackSelect.SqlStack].SaveColumnToFile
go