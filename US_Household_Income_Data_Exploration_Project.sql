# US Household Income Exploratory Data Analysis


-- Taking a look at our first table
SELECT * 
FROM us_household_income
;

-- Taking a look at our second table
SELECT * 
FROM us_household_income_statistics
;

-- Looking at the SUM of Area of Land and Area of Water by State, ordered by highest ALand
SELECT State_Name, 
SUM(ALand), 
SUM(AWater)
FROM us_household_income
GROUP BY State_Name
ORDER BY 2 DESC
;

-- Looking at the SUM of Area of Land and Area of Water by State, ordered by highest ALand and limiting Top 10
SELECT State_Name, 
SUM(ALand), 
SUM(AWater)
FROM us_household_income
GROUP BY State_Name
ORDER BY 2 DESC
LIMIT 10
;

-- Looking at the SUM of Area of Land and Area of Water by State, ordered by highest AWater
SELECT State_Name, 
SUM(ALand), 
SUM(AWater)
FROM us_household_income
GROUP BY State_Name
ORDER BY 3 DESC
;

-- Looking at the SUM of Area of Land and Area of Water by State, ordered by highest AWater and limiting Top 10
SELECT State_Name, 
SUM(ALand), 
SUM(AWater)
FROM us_household_income
GROUP BY State_Name
ORDER BY 3 DESC
LIMIT 10
;

-- Combining tables using Inner Join and excluding where Mean has 0 values
SELECT * 
FROM us_household_income u
INNER JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
;

-- Filtering joined tables to select columns
SELECT u.State_Name, 
County, 
Type, 
`Primary`, 
Mean, 
Median
FROM us_household_income u
INNER JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
;

-- Looking at the Average Mean and Average Median income per Household by State, ordering by Average Mean income and Limiting 10 rows
SELECT u.State_Name, 
ROUND(AVG(Mean),1), 
ROUND(AVG(Median),1)
FROM us_household_income u
INNER JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY u.State_Name
ORDER BY 2 DESC
LIMIT 10
;

-- Looking at different Types of areas from all States and grabbing a COUNT of Types, filtering where they are over 100
SELECT Type, 
COUNT(Type), 
ROUND(AVG(Mean),1), 
ROUND(AVG(Median),1)
FROM us_household_income u
INNER JOIN us_household_income_statistics us
	ON u.id = us.id
WHERE Mean <> 0
GROUP BY Type
HAVING COUNT(Type) > 100
ORDER BY 3 DESC
;

-- Taking a look at the information where the Type = 'Community'
SELECT *
FROM us_household_income
WHERE Type = 'Community'
;

-- Taking a look at States and Cities where the income is the highest
SELECT u.State_Name, 
City, 
ROUND(AVG(Mean),1), 
ROUND(AVG(Median),1)
FROM us_household_income u
JOIN us_household_income_statistics us
	ON u.id = us.id
GROUP BY u.State_Name, City
ORDER BY ROUND(AVG(Mean),1) DESC
;