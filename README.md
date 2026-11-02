# Germs & Medicine Database

A first-year university project built with SQL Server (T-SQL). It models germs, the medicines tested against them, and the test results.

## Database structure
- GERMS: germ name, description, identification date, date a cure was found
- MEDICINE: available medicines
- TEST: tests of a medicine on a germ (many-to-many), with reaction type (alive / dying / dead)
- ARCHIVERS: archive of tests for germs that were defeated
- ERRORS: log of errors caught inside stored procedures

## What's inside
| File | Topic |
|------|-------|
| lesson1.sql | Creating the database and tables, constraints (PK, FK, UNIQUE, CHECK), INSERT / UPDATE, JOIN |
| lesson2_5.sql | View of germs that were defeated |
| lesson3_5.sql | Stored procedures, TRY/CATCH error logging |
| lesson4.sql | Stored procedures that update test status |
| lesson5.sql | Trigger that archives a germ when its test result is "dead" |
| lesson6.sql | Scalar function and table-valued function |
| lesson7.sql | Cursor and aggregation (work in progress) |

## How to run
1. Open SQL Server Management Studio.
2. Run lesson1.sql first, then the other files in order.

## Concepts practiced
Relational design, constraints, joins, views, stored procedures, triggers, functions, cursors, error handling.

## Notes
Learning project from my first year of studies. Some scripts contain unfinished work.

(
Known issues - to fix later (each with a suggested fix):

lesson1.sql
- Issue: CREATE TABLE GERMS and CREATE TABLE TEST end with a trailing comma before the closing parenthesis.
  Fix: remove the last comma in each table.
- Issue: the last INSERT into TEST uses GERM_ID 10 and MEDICINE_ID 60, which do not exist (foreign key violation).
  Fix: use existing IDs (germs 1-6, medicines 5, 10, 15, 20, 25, 30), or insert the missing rows first.
- Issue: dates are written as mm/dd/yyyy, which depends on the server language settings.
  Fix: write dates as yyyy-mm-dd.

lesson3_5.sql
- Issue: Add_Test inserts names into TEST instead of IDs, and the looked-up IDs are never used.
  Fix: INSERT INTO TEST (GERM_ID, MEDICIN_ID, TEST_DATE, REACTION_TYPE) VALUES (@Details_GERMS, @Details_MEDICINE, @TEST_DATE1, @REACTION_TYPE1).
- Issue: EXEC copt_to_Archivers with a SELECT as the parameter is not allowed.
  Fix: call it with the variable: EXEC copt_to_Archivers @Details_GERMS.
- Issue: the UPDATE condition compares a germ name to an ID, so it never matches.
  Fix: WHERE [ID] = @Details_GERMS.
- Issue: the ERRORS table is created after the procedures that use it.
  Fix: move CREATE TABLE ERRORS above the procedures.
- Issue: copt_to_Archivers inserts duplicate rows if it runs twice for the same germ.
  Fix: add WHERE NOT EXISTS against ARCHIVERS, or delete the germ's old rows before inserting.

lesson4.sql
- Issue: Update_Status uses EXEC with a SELECT as the parameter.
  Fix: EXEC copt_to_Archivers @GERMS_CODE (it already holds the ID).

lesson5.sql
- Issue: the trigger reads one row from "inserted", so it fails on multi-row statements.
  Fix: work on all rows at once: UPDATE GERMS joined to inserted where REACTION_TYPE = 'dead', and INSERT INTO ARCHIVERS ... SELECT from inserted joined to GERMS and MEDICINE.
- Issue: any update of a row that is already "dead" archives it again.
  Fix: join to "deleted" and act only when the old REACTION_TYPE was not 'dead'.
- Issue: some sample INSERTs reference germ IDs that do not exist.
  Fix: use existing IDs only.

lesson7.sql
- Issue: GERM_PRENSISTENT_MOST is a function without RETURNS, and functions cannot use PRINT or cursors.
  Fix: change to CREATE PROCEDURE.
- Issue: the variable @thisId holds a count, not an ID.
  Fix: rename it to @thisCount.
- Issue: the cursor is longer than needed.
  Fix: SELECT g.NAME FROM GERMS g JOIN TEST t ON g.ID = t.GERM_ID GROUP BY g.NAME HAVING COUNT(*) = (SELECT MAX(c) FROM (SELECT COUNT(*) AS c FROM TEST GROUP BY GERM_ID) x).
- Issue: a lot of commented-out draft code.
  Fix: delete it.

General
- Run the files in order, starting with lesson1.sql.
- Issue: Hebrew notes to self appear in several files.
  Fix: delete them or translate them to English.
)
