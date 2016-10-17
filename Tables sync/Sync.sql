use first
go

create procedure sync
	@delay datetime
as
	while 0 = 0 
	begin
		--second diff
		select A.id, A.name, A.log_time 
		into #temptable1
		from Table1 A
		left join second.dbo.Table1 B
		on (A.id = B.id and A.name = B.name)
		where (B.id is NULL or B.name is NULL)

		--first diff
		select A.id, A.name, A.log_time
		into #temptable2 
		from second.dbo.Table1 A
		left join Table1 B
		on (A.id = B.id and A.name = B.name)
		where (B.id is NULL or B.name is NULL)

		declare @id int
		declare @name varchar(50) 
		declare @localname varchar(50)
		declare @localtime datetime
		declare @remotetime datetime

		declare diffsecond cursor local forward_only static for select id, name, log_time from #temptable1;
		open diffsecond
		fetch next from diffsecond into @id, @name, @remotetime
	
		while @@fetch_status = 0
		begin
			--if current id exist in second
			if exists (select * from second.dbo.Table1 where id = @id)
			begin
				--get name and time from second
				select @localname = name, @localtime = log_time 
				from second.dbo.Table1
				where id = @id
				if (@localtime > @remotetime)
				begin
					--update local
					update Table1
					set name = @localname
					where id = @id
				end
				else
				begin
					--update remote
					update second.dbo.Table1
					set name = @name
					where id = @id
				end
			end
			else
			begin
				--id exist in second and not exist in first
				--just add row in first
				insert into second.dbo.Table1
				values (@id, @name, NULL);
			end
			fetch next from diffsecond INTO @id, @name, @remotetime
		end
	
		close diffsecond
		deallocate diffsecond

		declare difffirst cursor local forward_only static for select id, name, log_time from #temptable2;
		open difffirst
		fetch next from difffirst into @id, @name, @remotetime
	
		while @@fetch_status = 0
		begin
			--if current id exist in first
			if exists (select * from Table1 where id = @id)
			begin
				--get name and time from first
				select @localname = name, @localtime = log_time 
				from Table1
				where id = @id
				if (@localtime < @remotetime)
				begin
					--update local
					update Table1
					set name = @name
					where id = @id
				end
				else
				begin
					--update remote
					update second.dbo.Table1
					set name = @localname
					where id = @id
				end
			end
			else
			begin
				--id exist in second and not exist in first
				--just add row in first
				insert into Table1
				values (@id, @name, NULL);
			end
			fetch next from difffirst INTO @id, @name, @remotetime
		end
	
		close difffirst
		deallocate difffirst

		drop table #temptable1
		drop table #temptable2
		
		
		
		
		--second diff
		select A.id, A.position, A.log_time 
		into #temptable3
		from Table2 A
		left join second.dbo.Table2 B
		on (A.id = B.id and A.position = B.position)
		where (B.id is NULL or B.position is NULL)

		--first diff
		select A.id, A.position, A.log_time
		into #temptable4
		from second.dbo.Table2 A
		left join Table2 B
		on (A.id = B.id and A.position = B.position)
		where (B.id is NULL or B.position is NULL)

		declare diffsecond cursor local forward_only static for select id, position, log_time from #temptable3;
		open diffsecond
		fetch next from diffsecond into @id, @name, @remotetime
	
		while @@fetch_status = 0
		begin
			--if current id exist in second
			if exists (select * from second.dbo.Table2 where id = @id)
			begin
				--get name and time from second
				select @localname = position, @localtime = log_time 
				from second.dbo.Table2
				where id = @id
				if (@localtime > @remotetime)
				begin
					--update local
					update Table2
					set position = @localname
					where id = @id
				end
				else
				begin
					--update remote
					update second.dbo.Table2
					set position = @name
					where id = @id
				end
			end
			else
			begin
				--id exist in second and not exist in first
				--just add row in first
				insert into second.dbo.Table2
				values (@id, @name, NULL);
			end
			fetch next from diffsecond INTO @id, @name, @remotetime
		end
	
		close diffsecond
		deallocate diffsecond

		declare difffirst cursor local forward_only static for select id, position, log_time from #temptable4;
		open difffirst
		fetch next from difffirst into @id, @name, @remotetime
	
		while @@fetch_status = 0
		begin
			--if current id exist in first
			if exists (select * from Table2 where id = @id)
			begin
				--get name and time from first
				select @localname = position, @localtime = log_time 
				from Table2
				where id = @id
				if (@localtime < @remotetime)
				begin
					--update local
					update Table2
					set position = @name
					where id = @id
				end
				else
				begin
					--update remote
					update second.dbo.Table2
					set position = @localname
					where id = @id
				end
			end
			else
			begin
				--id exist in second and not exist in first
				--just add row in first
				insert into Table2
				values (@id, @name, NULL);
			end
			fetch next from difffirst INTO @id, @name, @remotetime
		end
	
		close difffirst
		deallocate difffirst

		drop table #temptable3
		drop table #temptable4
		
		waitfor delay @delay
	end
go