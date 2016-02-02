---------Full Text Catalog-------------
--Create a new database with a file for a full text index
--Add a table with some text
--Create a full text index catalog
----Run Queries on the full text catalog
USE Master

CREATE DATABASE FullTextExample
GO

ALTER DATABASE FullTextExample ADD Filegroup FullTextCatalog
GO

USE FullTextExample
GO

CREATE TABLE Test (
    TestId INT identity(1, 1) PRIMARY KEY
    ,TestNotes NVARCHAR(255)
    )
GO

--run all above
--insert text
INSERT INTO Test (TestNotes)
VALUES ('I go something blue')
    ,('I going the something blue')
    ,('I have been gone something blue')
    ,('For test to be successful we must have a lot of text')
    ,('The test was not successful. sad face')
    ,('there is more than one test that can try a man')
    ,('Success is a relative term')
    ,('It is a rare man that is always successful')
    ,('The root of satisfaction is sad')
    ,('men want success')
GO

SELECT *
FROM Test
GO

--create full text catalog
CREATE FULLTEXT CATALOG TestDescription ON Filegroup FullTextCatalog
GO

--Create a full text index
CREATE FULLTEXT INDEX ON Test (TestNotes) KEY INDEX [PK__Test__8CC33160171B0B3B] ON TestDescription
    WITH Change_tracking auto
GO

--find all instances that have the word "sad"
SELECT TestID
    ,TestNotes
FROM Test
WHERE FREETEXT (
        TestNotes
        ,'sad'
        )

--do the same with successful
SELECT TestID
    ,TestNotes
FROM Test
WHERE FREETEXT (
        TestNotes
        ,'successful'
        )

SELECT TestID
    ,TestNotes
FROM Test
WHERE CONTAINS (
        TestNotes
        ,'"success"'
        )

SELECT TestID
    ,TestNotes
FROM Test
WHERE CONTAINS (
        TestNotes
        ,'"men want"'
        )

--look for any words containing the letters "success"
--the * is a wildcard
SELECT TestID
    ,TestNotes
FROM Test
WHERE CONTAINS (
        TestNotes
        ,'"success*"'
        )

SELECT TestID
    ,TestNotes
FROM Test
WHERE CONTAINS (
        TestNotes
        ,'"want men*"'
        )

--looks for all grammatical forms of a word
SELECT TestID
    ,TestNotes
FROM Test
WHERE CONTAINS (
        TestNotes
        ,'Formsof (Inflectional, go)'
        )

