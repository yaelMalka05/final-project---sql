--==--
create database yaelMalka
go
use yaelMalka
go
----------
create table GERMS
(
ID smallint identity(1,1) primary key,
NAME varchar(20) unique NOT NULL,
SHORT_DESC varchar(50),
ID_DATE date not null check(ID_DATE<=getdate()),
MEDICINE_DATE date check(MEDICINE_DATE<=getdate()), 
)
----
create table MEDICINE
(
ID smallint identity(5,5) primary key,
NAME varchar(20) unique NOT NULL,
)
----
create table TEST
(
GERM_ID smallint foreign key references GERMS(ID),
MEDICIN_ID smallint foreign key references MEDICINE(ID),
constraint GM primary key (GERM_ID , MEDICIN_ID ),
TEST_DATE date check(TEST_DATE<=getdate()),
REACTION_TYPE varchar(10) check(REACTION_TYPE in ('alive' , 'dying' , 'dead') ),
)
----====----
--insert into [dbo].[GERMS] ([NAME]) values('flu')
--insert into [dbo].[GERMS] ([SHORT_DESC]) values('fever,headache,dizziness')
--insert into [dbo].[GERMS] ([ID_DATE]) values('20-05-1719')
--insert into [dbo].[GERMS] ([MEDICINE_DATE]) values('16-02-1903') לא דרך תקינה
insert into [dbo].[GERMS] (NAME, SHORT_DESC, ID_DATE, MEDICINE_DATE )
values('flu', 'fever,headache,dizziness', '05/20/1719', '02/16/1903')
insert into [dbo].[GERMS] (NAME, SHORT_DESC, ID_DATE, MEDICINE_DATE )
values('sore throat', 'weakness,vomit,nausea', '05/07/1712', '04/13/1907')
insert into [dbo].[GERMS] (NAME, SHORT_DESC, ID_DATE, MEDICINE_DATE )
values('headache', 'tiredness,overstimultion', '05/19/1972', '11/27/2008')
insert into [dbo].[GERMS] (NAME, SHORT_DESC, ID_DATE, MEDICINE_DATE )
values('cough', 'burning,nerve', '08/29/1837', '11/26/1952')
insert into [dbo].[GERMS] (NAME, SHORT_DESC, ID_DATE, MEDICINE_DATE )
values('old age', 'over complain,big regrets', '01/01/1001', '10/20/2010')
insert into [dbo].[GERMS] (NAME, SHORT_DESC, ID_DATE, MEDICINE_DATE )
values('Puberty', 'anxiety,depression', '05/15/2005', null)
--
select * from [dbo].[GERMS]

--לבדיקה לא לשימוש חוזר!!!
--==drop table GERMS==--
--==drop table TEST==--
--==drop table MEDICINE==--
--שימי לב!!!
----------------------------
insert into [dbo].[MEDICINE] (NAME)
values('flura')
insert into [dbo].[MEDICINE] (NAME)
values('soret')
insert into [dbo].[MEDICINE] (NAME)
values('peacelee')
insert into [dbo].[MEDICINE] (NAME)
values('coldoro')
insert into [dbo].[MEDICINE] (NAME)
values('momentos')
insert into [dbo].[MEDICINE] (NAME)
values('teenagery')
-----
select * from [dbo].[MEDICINE]
-----
insert into [dbo].[TEST] ([GERM_ID],[MEDICIN_ID] ,[TEST_DATE], [REACTION_TYPE])
values(1,5,'03/17/1897','dying')
insert into [dbo].[TEST] ([GERM_ID],[MEDICIN_ID] ,[TEST_DATE], [REACTION_TYPE])
values(2,10,'05/10/1896','dead')
insert into [dbo].[TEST] ([GERM_ID],[MEDICIN_ID] ,[TEST_DATE], [REACTION_TYPE])
values(3,15,'12/26/2004','alive')
insert into [dbo].[TEST] ([GERM_ID],[MEDICIN_ID] ,[TEST_DATE], [REACTION_TYPE])
values(4,20,'06/22/1884','dead')
insert into [dbo].[TEST] ([GERM_ID],[MEDICIN_ID] ,[TEST_DATE], [REACTION_TYPE])
values(6,25,'02/02/1010','alive')
insert into [dbo].[TEST] ([GERM_ID],[MEDICIN_ID] ,[TEST_DATE], [REACTION_TYPE])
values(10, 60 ,'01/25/2025','alive')
----
select * from [dbo].[TEST]
-----
select * from [dbo].[GERMS] join [dbo].[TEST]
on [dbo].[GERMS].ID=[dbo].[TEST].GERM_ID
join [dbo].[MEDICINE]
on [dbo].[MEDICINE].ID=[dbo].[TEST].MEDICIN_ID
----------==----------
update [dbo].[GERMS]
set [MEDICINE_DATE]=null
where [NAME]='old age'
--
update [dbo].[GERMS]
set [SHORT_DESC]='fever,dizziness'
where [NAME]='flu'
--
update [dbo].[GERMS]
set [MEDICINE_DATE]=null
where [NAME]='headache'
-----------
--==update [dbo].[TEST]
--==set [MEDICIN_ID]=null
--==where [GERM_ID]='3'     איך יש תרופה אם לא מצאנו אותה? לעדכן שנלמד!0
-----------

