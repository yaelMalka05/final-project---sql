--
create procedure Update_Status
@GERMS_CODE int, 
@MEDICINE_CODE  int, 
@NEW_REACTION_TYPE  varchar(50)
--@Date_New date 
--check (@Date_New <getdate())
as 
begin

begin try 
   -- declare @Date_New  = getdate()
update [dbo].[TEST]
set [REACTION_TYPE] = @NEW_REACTION_TYPE 
--וגם אותה תרופה
where ([GERM_ID] = @GERMS_CODE and [MEDICIN_ID] = @MEDICINE_CODE)

if(@NEW_REACTION_TYPE ='dead')
begin
 exec copt_to_Archivers
 (select [ID] from [dbo].[GERMS]
 --הקוד שווה לקוד
 where @GERMS_CODE=[ID])

 update [dbo].[GERMS]
 set [MEDICINE_DATE]=getdate()
 --@Date_New לא נכון
 --@NEW_REACTION_TYPE לא נכון
 --תנאי אחר
 --where  @NEW_REACTION_TYPE='dead'
 where [ID] = @GERMS_CODE
 --@NEW_REACTION_TYPE = (select [ID] from [dbo].[GERMS] where
--[ID] = (select [ID] from [dbo].[GERMS]
--where [ID]=@GERMS_CODE ))
end
end try

begin catch
insert into  [dbo].[ERRORS] values (error_message())
end catch

end
----==-----
exec  Update_Status  @GERMS_CODE=6,@MEDICINE_CODE=20,
@NEW_REACTION_TYPE='alive'
exec  Update_Status  @GERMS_CODE=6,@MEDICINE_CODE=20,
@NEW_REACTION_TYPE='dead'
exec  Update_Status  @GERMS_CODE=6,@MEDICINE_CODE=25,
@NEW_REACTION_TYPE='dead'

------
select * from [dbo].[GERMS]
select * from [dbo].TEST
select * from [dbo].[ARCHIVERS]


--update [dbo].[TEST].[REACTION_TYPE]=
--if([REACTION_TYPE]='dead')
--{

--where [dbo].[GERMS].[ID]= 

--}
 --where [dbo].[TEST].[REACTION_TYPE]='dead'

 create procedure Staying_Alive
 @GERMS_CODE1 int, 
@MEDICINE_CODE1  int
 as
 begin

 begin try 
 declare @Stay_Date date
 select @Stay_Date=[TEST_DATE] from [dbo].[TEST]
 where [GERM_ID]= @GERMS_CODE1 and [MEDICIN_ID]=@MEDICINE_CODE1

 if(datediff(mm, @Stay_Date ,getdate() ) >=2)
 begin
 exec Update_Status  @GERMS_CODE1,@MEDICINE_CODE1,'alive'
 --(select [ID] from [dbo].[GERMS]
 --where [ID] = @GERMS_CODE1 )
 ------
 --update [dbo].[TEST] הדרך לא נכונה 
 --set [REACTION_TYPE]='alive' זה מתעדכן כבר ששולחים לפרוצדורה
 -------
 --where [REACTION_TYPE]='dying'
 end
 end try

 begin catch
 insert into [dbo].[ERRORS] values (error_message())
 end catch

 end
 --
      exec  Staying_Alive  @GERMS_CODE1=6,@MEDICINE_CODE1=20
   exec  Staying_Alive  @GERMS_CODE1=2,@MEDICINE_CODE1=10
 exec  Staying_Alive  @GERMS_CODE1=6,@MEDICINE_CODE1=25
 --
 select * from [dbo].[GERMS]
 select * from [dbo].[TEST]
 --
 update [dbo].[TEST]
 set [REACTION_TYPE]='dying'
 where [MEDICIN_ID]=25
 --
 update [dbo].[GERMS]
 set [MEDICINE_DATE]='01-05-1009'
 where [NAME]='old age'
--


 print GETDATE()
 -----