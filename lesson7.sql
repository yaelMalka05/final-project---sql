--==--

create function GERM_PRENSISTENT_MOST ()

as

begin 



--select ID , count(*)  --לא נכון
--from [dbo].[GERMS]
--group by [ID]



--with findMax as (    --דרך שניה


--==[GERM_ID] ,
--==@maxGerm =
--select  [GERM_ID] , count(*) as 'findId'  --דרך שניה
--from [dbo].[TEST]
--group by [GERM_ID]  )


--select [GERM_ID] , max([GERM_ID]) as 'findId'  --לא נכון
--from [dbo].[TEST]
--group by [GERM_ID])



--select [GERM_ID]   --דרך שניה
--from findMax 
--where findId=(select max(findId) from findMax)

declare @maxGerm  int 

select top 1 @maxGerm =  count(*)
from [dbo].[TEST]
group by [GERM_ID]
order by count(*) desc

--print @maxGerm 

select [GERM_ID], count(*)
from [dbo].[TEST]
group by [GERM_ID]

select [dbo].[GERMS].NAME , count(*)
from [dbo].[GERMS]  join [dbo].[TEST]
on [dbo].[GERMS].ID=[dbo].[TEST].GERM_ID
--group by [dbo].[TEST].[GERM_ID]     --לא נכון 
group by [dbo].[GERMS].NAME
--having max()        --שגוי 

--==--
declare  @thisId int , @thisName varchar(20)
declare FM cursor for

select [dbo].[GERMS].NAME , count(*)
from [dbo].[GERMS]  join [dbo].[TEST]
on [dbo].[GERMS].ID=[dbo].[TEST].GERM_ID
group by [dbo].[GERMS].NAME
 
open FM
fetch next from FM into @thisName, @thisId 
while @@FETCH_STATUS=0
begin 
  if(  @thisId = @maxGerm )

   print @thisName

fetch next from FM into  @thisName , @thisId
end

--print @maxGerm       -- לא צריך
--print @thisName    

close FM
deallocate FM




end


--------==-------
select * from [dbo].[GERMS]
select * from [dbo].[TEST]