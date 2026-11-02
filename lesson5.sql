--====================--
create trigger  Germ_Dead on [dbo].[TEST] for insert,update
as

begin

declare @REACTION_TYPE_o varchar(50)
declare @GERM_ID_O smallint

 select @REACTION_TYPE_o = [REACTION_TYPE] from inserted
 select  @GERM_ID_O = [GERM_ID] from inserted
 
 if( @REACTION_TYPE_o = 'dead')
 begin

 update [dbo].[GERMS]
 set [MEDICINE_DATE] = getdate()
 where [ID] = @GERM_ID_O

 exec copt_to_Archivers   @GERM_ID_O
 --אפשר לכתוב ככה ששולחים לו את מה שהפרוצדורה מקבלת--

 end
 --rollback

end
--==--==--==--==--==--==--
insert into [dbo].[TEST] values (10,25,'2001-12-22','dying')
insert into [dbo].[TEST] values (4,10,'1957-4-20','dead')
insert into [dbo].[TEST] values (3,5,'2001-12-22','dead')
insert into [dbo].[TEST] values (3,25,'2001-9-15','dead')
insert into [dbo].[TEST] values (10,15,'2000-11-24','dead')
------
select * from [dbo].[TEST]
select * from [dbo].[GERMS]
select * from [dbo].[ARCHIVERS]
--==--


