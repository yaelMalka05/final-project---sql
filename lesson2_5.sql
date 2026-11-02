--
create  view ViGermS
as
select 
[dbo].[GERMS].[NAME] as 'GermName',
[dbo].[GERMS].[MEDICINE_DATE] as 'DateOfFindMedicin',
[dbo].[MEDICINE].[NAME] as 'MedicinName'
from [dbo].[MEDICINE]  join [dbo].[TEST]
on [dbo].[MEDICINE].ID=[dbo].[TEST].MEDICIN_ID
join [dbo].[GERMS]
on[dbo].[GERMS].ID=[dbo].[TEST].GERM_ID
where [dbo].[TEST].[REACTION_TYPE]='dead'
----------
select * from [dbo].[ViGermS]
--