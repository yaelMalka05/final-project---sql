---====---
create table ARCHIVERS 
(
GERM_NAME varchar(20),
GERM_ID smallint,
TEST_DATE date,
MEDICINE_NAME varchar(20),
REACTION_TYPE varchar(10)
)
----------
create procedure copt_to_Archivers @ID_OF_GERMS int
as
begin
insert into [dbo].[ARCHIVERS]([GERM_NAME],[GERM_ID],[TEST_DATE],
[MEDICINE_NAME],[REACTION_TYPE])
(select [dbo].[GERMS].NAME,[dbo].[GERMS].[ID],[dbo].[TEST].TEST_DATE,
[dbo].[MEDICINE].[NAME],[dbo].[TEST].REACTION_TYPE
from [dbo].[TEST] join [dbo].[GERMS]
on [dbo].[TEST].GERM_ID=[dbo].[GERMS].ID
join [dbo].[MEDICINE]
on [dbo].[MEDICINE].ID=[dbo].[TEST].MEDICIN_ID
where [dbo].[GERMS].[ID]=@ID_OF_GERMS)
end
------------------------
exec copt_to_Archivers 1
exec copt_to_Archivers 10
exec copt_to_Archivers 4
--
--==delete  from [dbo].[ARCHIVERS]
--==where [GERM_ID]=1,10
--
select * from [dbo].[ARCHIVERS]
----------==----------
create procedure  Add_Test   
@GERMS_NAME1 varchar(50), 
@MEDICINE_NAME1 varchar(50), 
@TEST_DATE1 varchar(50) , 
@REACTION_TYPE1 varchar(50)
as 
begin
begin try
declare @Details_GERMS int
select @Details_GERMS=[ID] from [dbo].[GERMS] 
where [NAME]=@GERMS_NAME1

declare @Details_MEDICINE int
select @Details_MEDICINE=[ID] from [dbo].[MEDICINE] 
where [NAME]=@MEDICINE_NAME1

insert into [dbo].[TEST]  values 
(@GERMS_NAME1, @MEDICINE_NAME1, @TEST_DATE1, @REACTION_TYPE1)

if(@REACTION_TYPE1='dead' )
begin
 exec copt_to_Archivers (select [ID] from [dbo].[GERMS]
 where @GERMS_NAME1=[NAME])
 update [dbo].[GERMS] 
 set [MEDICINE_DATE] = @TEST_DATE1
 --החיידק הרלוונטי
 where @GERMS_NAME1 = (select [ID] from [dbo].[GERMS] 
 where [NAME]=@GERMS_NAME1)
-- where @REACTION_TYPE1='dead'
 end

 end try

 begin catch
 insert into [dbo].[ERRORS] values (error_message())
end catch

end 
----------==-----------
--
exec ADD_TEST @GERMS_NAME1='cough',@MEDICINE_NAME1='coldoro',@TEST_DATE1='1884-06-22',
@REACTION_TYPE1='dead'
-------------------
--delete procedure ADD_TEST

--
create table ERRORS
(
  MESSAGE_ERROR varchar(300)
)
------------------
select * from [dbo].[MEDICINE]
select * from [dbo].[GERMS]
select * from [dbo].[TEST]

 --if([NAME] from [dbo].[MEDICINE] != @MEDICINE_NAME1 &&
 --[NAME] from [dbo].[GERMS] != @GERMS_NAME1)
 --{
 --print 'error'
 --}

 --(select  [TEST_DATE],[REACTION_TYPE] from [dbo].[TEST]
 --where @REACTION_TYPE1='dead')


 --if(@REACTION_TYPE1='dead')

 --join [dbo].[TEST]
 --on [dbo].[GERMS].[ID]=[dbo].[TEST].[MEDICIN_ID]

 -- set [MEDICINE_DATE]=[TEST_DATE]

--select * from [dbo].[ERRORS]

 /*
 copy (select  [TEST_DATE],[REACTION_TYPE] from [dbo].[TEST])
 to ARCHIVERS 
 update [MEDICINE_DATE]=[TEST_DATE]
 where[REACTION_TYPE]='dead' 
 )
 else
 if(@GERMS_NAME1=null || @MEDICINE_NAME1=null)
 ( 
 break
 )
 else
 (
 if([REACTION_TYPE]= error || @MEDICINE_NAME1='taken')
 (
 break
 )
 else
 break
 )
 */


 --if([NAME] from [dbo].[MEDICINE] != @MEDICINE_NAME1 &&
 --[NAME] from [dbo].[GERMS] != @GERMS_NAME1)

 /*
 (select [dbo].[GERMS].ID,[dbo].[MEDICINE].ID
from [dbo].[MEDICINE] join [dbo].[TEST]
on [dbo].[MEDICINE].ID=[dbo].[TEST].MEDICIN_ID
join [dbo].[GERMS]
on [dbo].[GERMS].ID=[dbo].[TEST].GERM_ID
where [dbo].[GERMS].NAME = @GERMS_NAME1)
*/
--([GERM_ID],[MEDICIN_ID],[TEST_DATE],
--[REACTION_TYPE])