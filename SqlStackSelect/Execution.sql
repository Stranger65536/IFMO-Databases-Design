use "film collection"
go

exec dbo.savecolumntofile @tablename = 'countries', @columnname = 'name', @savepath = 'C:\res.txt'