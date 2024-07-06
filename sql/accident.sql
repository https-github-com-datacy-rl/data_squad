-- DATABASE: national_accident

-- DROP SCHEMA IF EXISTS accident_dataset ;


CREATE DATABASE IF NOT EXISTS national_accident
	AUTHORIZATION postgres;



-- SCHEMA: accident_dataset

-- DROP SCHEMA IF EXISTS accident_dataset ;

CREATE SCHEMA IF NOT EXISTS accident_dataset
    AUTHORIZATION postgres;
	
	




/* Create table called US_accident_1 */
DROP TABLE IF EXISTS accident_dataset.us_accident_1;
CREATE TABLE accident_dataset.us_accident_1(
	Airport_Code VARCHAR(6),
	Amenity BOOLEAN,
	Astronomical_Twilight CHAR(6),
	Bump BOOLEAN,
	Calculation1 CHAR(10),
	City CHAR(60),
	Civil_Twilight CHAR(6),
	count_of_Bump SMALLINT,
	Count_of_Crossing SMALLINT,
	count_Traffic_Signal SMALLINT,
	Country CHAR(25),
	County CHAR(35),
	Crossing BOOLEAN,
	Description VARCHAR(300),
	End_Lat FLOAT,
	End_Lng FLOAT,
	End_Time VARCHAR(30),
	Give_Way BOOLEAN,
	ID VARCHAR(10) PRIMARY KEY NOT NULL,
	Junction BOOLEAN,
	Nautical_Twilight CHAR(26),
	No_Exit BOOLEAN,
	Number INT,
	Railway BOOLEAN,
	Roundabout BOOLEAN,
	Severity SMALLINT,
	Side CHAR(10),
	Source CHAR(15),
	Start_Time VARCHAR(30),
	State CHAR(2),
	Station BOOLEAN,
	Stop BOOLEAN,
	Street VARCHAR(80),
	Sunrise_Sunset CHAR(6),
	Temperature FLOAT,
	Timezone VARCHAR(30),
	Traffic_Calming BOOLEAN,
	Traffic_Signal BOOLEAN,
	Turning_Loop BOOLEAN,
	Visibility FLOAT,
	Weather_Condition VARCHAR(40)
);

/* Create table called US_accident_2 */
DROP TABLE if exists accident_dataset.us_accident_2;
CREATE TABLE accident_dataset.us_accident_2 (
	Airport_Code VARCHAR,
	Amenity  BOOLEAN,
	Astronomical_Twilight VARCHAR,
	Bump BOOLEAN,
	Calculation1 VARCHAR,
	City VARCHAR,
	Civil_Twilight VARCHAR,
	Count_of_Bump INT,
	Count_of_Crossing INT,
	Count_of_Traffic_Signal INT,
	Country TEXT,
	County VARCHAR,
	Crossing BOOLEAN,
	Description VARCHAR,
	End_Lat VARCHAR,
	End_Lng VARCHAR,
	End_Time Timestamp,
	Give_Way BOOLEAN,
	ID VARCHAR NOT NULL primary key,
	Junction BOOLEAN,
	Nautical_Twilight VARCHAR,
	No_Exit BOOLEAN,
	Number INT,
	Weather_Timestamp VARCHAR,
	Wind_Direction VARCHAR,
	Zipcode VARCHAR (15),
	Count_of_accidents INT,
	count_of_county INT,
	Distance_mi real,
	Humidity_Percentages INT,
	Number_of_Records INT,
	Precipitation_in VARCHAR,
	Pressure_in double precision,
	Records INT,
	Start_Lat double precision,
	Start_Lng double precision,
	TMC INT,
	Wind_Chill_F real,
	Wind_Speed_mph real
	)


/* Create table called US_accident_3 */
-- US ACCIDENT 3
	DROP TABLE if exists accident_dataset.us_accident_3;
	CREATE TABLE accident_dataset.us_accident_3 (
	Airport_Code VARCHAR,
	Amenity  BOOLEAN,
	Astronomical_Twilight VARCHAR,
	Bump BOOLEAN,
	Calculation1 VARCHAR,
	City VARCHAR,
	Civil_Twilight VARCHAR,
	Count_of_Bump INT,
	Count_of_Crossing INT,
	Count_Traffic_Signal INT,
	ID VARCHAR NOT NULL primary key,
	Junction BOOLEAN,
	Nautical_Twilight VARCHAR,
	No_Exit BOOLEAN,
	Number INT,
	Railway BOOLEAN,
	Roundabout BOOLEAN,
	Severity VARCHAR,
	Side VARCHAR,
	Source VARCHAR,
	Start_Time Timestamp,
	State VARCHAR,
	Station BOOLEAN,
	Stop BOOLEAN,
	Street VARCHAR,
	Sunrise_Sunset VARCHAR,
	Temperature_F VARCHAR,
	Timezone VARCHAR,
	Traffic_Calming BOOLEAN,
	Traffic_Signal BOOLEAN,
	Turning_Loop BOOLEAN,
	Visibility_mi real,
	Weather_Condition VARCHAR,
	Weather_Timestamp VARCHAR,
	Wind_Direction VARCHAR,
	Zipcode VARCHAR (15),
	Count_of_accidents INT,
	count_of_county INT,
	Distance_mi real,
	Humidity_Percentages INT,
	Number_of_Records INT,
	Precipitation_in VARCHAR,
	Pressure_in double precision,
	Records INT,
	Start_Lat double precision,
	Start_Lng double precision,
	TMC INT,
	Wind_Chill_F real,
	Wind_Speed_mph real
	)


/* Create table called US_accident_4 */
-- US ACCIDENT 4
DROP TABLE if exists accident_dataset.us_accident_4;
CREATE TABLE accident_dataset.us_accident_4 (
	Count_of_Bump INT,
	Count_of_Crossing INT,
	Count_of_Traffic_Signal INT,
	Country TEXT,
	County VARCHAR,
	Crossing BOOLEAN,
	Description VARCHAR,
	End_Lat VARCHAR,
	End_Lng VARCHAR,
	End_Time Timestamp,
	Give_Way BOOLEAN,
	ID VARCHAR NOT NULL primary key,
	Junction BOOLEAN,
	Nautical_Twilight VARCHAR,
	No_Exit BOOLEAN,
	Number INT,
	Railway BOOLEAN,
	Roundabout BOOLEAN,
	Severity VARCHAR,
	Side VARCHAR,
	Source VARCHAR,
	Start_Time Timestamp,
	State VARCHAR,
	Station BOOLEAN,
	Stop BOOLEAN,
	Street VARCHAR,
	Sunrise_Sunset VARCHAR,
	Temperature_F VARCHAR,
	Timezone VARCHAR,
	Traffic_Calming BOOLEAN,
	Traffic_Signal BOOLEAN,
	Turning_Loop BOOLEAN,
	Visibility_mi VARCHAR,
	Weather_Condition VARCHAR,
	Weather_Timestamp VARCHAR,
	Wind_Direction VARCHAR,
	Zipcode INT,
	Count_of_accidents INT,
	count_of_county INT,
	Distance_mi INT,
	Humidity_Percentages INT,
	Number_of_Records INT,
	Precipitation_in VARCHAR,
	Pressure_in INT,
	Records INT,
	Start_Lat INT,
	Start_Lng INT,
	TMC INT,
	Wind_Chill_F INT,
	Wind_Speed_mph INT
)


--C:\Users\Public\US_Accident_1.csv

SELECT * 
from accident_dataset.us_accident_1


--C:\Users\Public\US_Accident_1.csv
COPY accident_dataset.us_accident_1
FROM 'C:\Users\Public\accident\US_Accident_1.csv' 
DELIMITER ',' 
CSV HEADER;

COPY accident_dataset.us_accident_2
FROM 'C:\Users\Public\accident\US_Accident_2.csv' 
DELIMITER ',' 
CSV HEADER;

COPY accident_dataset.us_accident_3
FROM 'C:\Users\Public\accident\US_Accident_3.csv' 
DELIMITER ',' 
CSV HEADER;

COPY accident_dataset.us_accident_4
FROM 'C:\Users\Public\accident\US_Accident_4.csv' 
DELIMITER ',' 
CSV HEADER;


--############
SELECT *
FROM accident_dataset.us_accident_1;

----#########################################################################
-- Using full join combine the 4 US_accident  files together with their unique identifiers as  “Total_US_Accident”.

SELECT A1.airport_code, 
		A1.ID, 
		A1.Astronomical_Twilight,
		A1.County,
		A2.Count_of_accidents,
		A2.Civil_Twilight, 
		A3.Severity,
		A3.City,
		A4.Weather_condition, 
		A4.Start_Time 
INTO accident_dataset.total_us_accident
FROM accident_dataset.us_accident_1 AS A1
FULL JOIN accident_dataset.us_accident_2 AS A2 ON A1.Id = A2.Id
FULL JOIN accident_dataset.us_accident_3 AS A3 ON A1.Id = A3.Id
FULL JOIN accident_dataset.us_accident_4 AS A4 ON A1.Id = A4.Id

---#####
-- 2. total COUNT of accidents that happened during the day?
SELECT *
FROM accident_dataset.US_Accident_1
WHERE Civil_Twilight ='Day';

----######  
SELECT COUNT(*) 
FROM accident_dataset.US_Accident_1
WHERE Civil_Twilight ='Day';

--##################
--Find the total number of 
--accident that happened in KARA and KFWD during the period 2016 -2021

SELECT COUNT(*) 
FROM accident_dataset.US_Accident_1
WHERE Airport_Code ='KARA'
--WHERE year BETWEEN 2000 AND 2010;

--############################
SELECT COUNT(Count of accidents) 
FROM accident_dataset.US_Accident_1
WHERE (airport_code = 'KARA' OR airport_code = 'KFWD')
And year BETWEEN 2016 AND 2021;

---###########################################
-- 4Find the sum of accidents that occurred Tarrant County.
SELECT SUM(count_of_accidents)
FROM accident_dataset.US_Accident_1
WHERE county = 'Tarrant'
GROUP BY County;

--############################################
-- 5.Find all the accident where the city name start with “T”
SELECT *
FROM accident_dataset.Total_US_Accident
WHERE city LIKE 'T%'

-----############################################################################
6.Show the accident numbers for each county
SELECT COUNT(count_of_accidents) AS number_of_accidents, county
FROM accident_dataset.Total_US_Accident
GROUP BY county
-----------------###############################################
7.Show the accident numbers  where the severity level is more than 1 and the weather condition is Mostly cloudy
SELECT count_of_accidents, severity, weather_condition
FROM accident_dataset.Total_US_Accident
WHERE severity > 1 AND weather_condition = 'Mostly Cloudy'








