----------============----------
create function TEST_TO_GERM (@Id_GerM int)
returns int
as 
begin
declare @AmounT int
select @AmounT = count(*)  from [dbo].[TEST] 
where @Id_GerM =[GERM_ID]

return @AmounT
end
-------
print [dbo].[TEST_TO_GERM] (4)
--
select * from [dbo].[GERMS]
-------==========-------
create function GERM_FOR_VACCINE (@MedicinE_NamE varchar(20))
returns table
as
return (select [dbo].[GERMS].[ID] , [dbo].[GERMS].[NAME],
[dbo].[GERMS].[SHORT_DESC] , [dbo].[GERMS].[ID_DATE] ,
[dbo].[GERMS].[MEDICINE_DATE] 
from [dbo].[GERMS] join [dbo].[TEST] 
on [dbo].[GERMS].ID=[dbo].[TEST].GERM_ID
join [dbo].[MEDICINE]
on [dbo].[MEDICINE].ID=[dbo].[TEST].MEDICIN_ID
where [dbo].[TEST].[REACTION_TYPE]='dead' 
and [dbo].[MEDICINE].NAME=@MedicinE_NamE)

--end--
--====--

select * from [dbo].[GERM_FOR_VACCINE] ('coldoro')
------
select * from [dbo].[MEDICINE]
select * from [dbo].[GERMS]
select * from [dbo].[TEST] 
--
