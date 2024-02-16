create database human_resources;

use human_resources;

select * from hr;

-- get column names from dataset

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'hr';

-- Change column name
alter table hr change column ï»¿id emp_id varchar(20)null;

-- data type of each column
describe hr;

select birthdate from hr;

-- Formatting & changing data type in birthdate , termdate & hire date column
set sql_safe_updates = 0;

update hr
set birthdate = case
	when birthdate like "%/%" then date_format(str_to_date(birthdate, "%m/%d/%Y"), "%Y-%m-%d")
    when birthdate like "%-%" then date_format(str_to_date(birthdate, "%m-%d-%Y"), "%Y-%m-%d")
    else null
end;

alter table hr modify column birthdate date;

update hr
set hire_date = case
	when hire_date like "%/%" then date_format(str_to_date(hire_date, "%m/%d/%Y"), "%Y-%m-%d")
    when hire_date like "%-%" then date_format(str_to_date(hire_date, "%m-%d-%Y"), "%Y-%m-%d")
    else null
end;

alter table hr modify column hire_date date;

update hr
set termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
where termdate is not null and termdate != '';

UPDATE hr
SET termdate = '1970-01-01'
WHERE termdate = '0000-00-00' OR termdate = '';

alter table hr modify column termdate date;

select termdate from hr;

alter table hr add column age int;

update hr set age = timestampdiff(year,birthdate,curdate());

select min(age) as youngest, max(age) as oldest from hr;

select count(*) from hr where age < 18;

