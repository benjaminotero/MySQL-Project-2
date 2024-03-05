#US Household Income Data Cleaning


-- Taking a look at our first table
SELECT * 
FROM us_household_income
;

-- Taking a look at our second table
SELECT * 
FROM us_household_income_statistics
;

-- Altering the column name to remove all unnecessary characters
ALTER TABLE us_household_income_statistics RENAME COLUMN `ï»¿id` TO `id`;

-- Taking a look at the number of rows for 'id' compared to original dataset from first table
SELECT COUNT(id)
FROM us_household_income
;

-- Taking a look at the number of rows for 'id' compared to original dataset from second table
SELECT COUNT(id)
FROM us_household_income_statistics
;

-- Identify if there were any duplicate 'id's from our first table
SELECT id, COUNT(id)
FROM us_household_income
GROUP BY id
HAVING COUNT(id) > 1
;

-- Identified which rows contained duplicate 'id's from our first table
SELECT *
FROM (
SELECT row_id, id,
ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
FROM us_household_income
) duplicates
WHERE row_num > 1
;

-- Removed all duplicate 'id's from first table
DELETE FROM us_household_income
WHERE row_id IN (
		SELECT row_id
		FROM (
			SELECT row_id, 
			id,
			ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
			FROM us_household_income
			) duplicates
WHERE row_num > 1)
;

-- Identified if there were any duplicate 'id's from our second table
SELECT id, COUNT(id)
FROM us_household_income_statistics
GROUP BY id
HAVING COUNT(id) > 1
;

-- Identifying all State Names and seeing if there are any errors 
SELECT State_Name, COUNT(State_Name)
FROM us_household_income
GROUP BY State_Name
;

-- Manually updating an incorrectly spelled State to match the correct one
UPDATE us_household_income
SET State_Name = 'Georgia'
WHERE State_Name = 'georia'
;

-- Updating the State Name to standarize it with the rest of the same State
UPDATE us_household_income
SET State_Name = 'Alabama'
WHERE State_Name = 'alabama'
;

-- Checking the State Abbreviations to see if there were any errors
SELECT DISTINCT State_ab
FROM us_household_income
ORDER BY 1
;

-- Identifying if a certain County has the same Place
SELECT County, Place
FROM us_household_income
WHERE County = 'Autauga County'
ORDER BY 1
;

-- Updating the empty cells for Place based off of matching County and City of other cells
UPDATE us_household_income
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont'
;

-- Looking at all Types and seeing if there are any errors
SELECT Type, COUNT(Type)
FROM us_household_income
GROUP BY Type
# ORDER BY 1
;

-- Updating an incorrect Type to match correct one
UPDATE us_household_income
SET Type = 'Borough'
WHERE Type = 'Boroughs'
;

-- Verifying there is no blank data for ALand or AWater
SELECT ALand, AWater 
FROM us_household_income
WHERE (AWater = 0 OR AWater = '' OR AWater IS NULL)
AND (ALand = 0 OR ALand = '' OR ALand IS NULL)
;