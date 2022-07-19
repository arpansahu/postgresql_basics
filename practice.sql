-- Refernce : https://www.sql-practice.com/

-- Table patients
-- patient_id	INT
-- first_name	TEXT
-- last_name	TEXT
-- gender	CHAR(1)
-- birth_date	DATE
-- city	TEXT
-- primary key icon	province_id	CHAR(2)
-- allergies	TEXT
-- height	INT
-- weight	INT

-- Table admissions
-- patient_id	INT
-- admission_date	DATE
-- discharge_date	DATE
-- primary_diagnosis	TEXT
-- secondary_diagnoses	TEXT
-- primary key icon	attending_physician_id	INT
-- primary key icon	nursing_unit_id	TEXT
-- room	INT
-- bed	INT
-- primary key icon	pk_admissions

-- Table provinces
-- province_id	CHAR(2)
-- province_name	TEXT


-- Q2 SELECT first_name, last_name FROM patients who dont have any allergies
--
--



SELECT first_name, last_name from patients Where allergies is NULL;


-- Q3 SELECT first_name of patietns whoose name starts with C

SELECT first_name from patients Where first_name LIKE 'C%';

--Q4 Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)

SELECT first_name, last_name from patients Where weight BETWeen 100 and 120;

-- Q5 Update the patients table for the allergies column. If the patient's allergies is null then
-- replace it with 'NKA'

Update patients SET allergies='NKA' where allergies is NULL;

-- Q6 Show first name and last name concatinated into one column to show their full name.

Select Concat(first_name,' ', last_name) as full_name from patients;

--Q7 Show first name, last name, and the full province name of each patient. Example: 'Ontario' instead of 'ON'
SELECT first_name,last_name,province_name FROM patients
  JOIN provinces on provinces.province_id = patients.province_id;

--Q8 Show how many patients have a birth_date with 2010 as the birth year.

SELECT COUNT(*) as total_patients FROM patients WHERE YEAR(birth_date) = 2010;

--Q9 show pateints first_name, last_name and max height from patients table

SELECT first_name,last_name, MAX(height) as height FROM patients;

-- Q10 Show all columns for patients who have one of the following patient_ids: 1,45,534,879,1000

SELECT * FROM patients WHERE patient_id IN (1,45,534,879,1000);

-- Q11 Show the total number of admissions

select count(*) from admissions;

-- Q12 Show unique first names from the patients table which only occurs once in the list.

select distinct YEAR(birth_date) from patients order by YEAR(birth_date) ASC;


-- Q 13 For example, if two or more people are named 'John' in the first_name column then don't include their
-- name in the output list. If only 1 person is named 'Leo' then include them in the output.

SELECT first_name FROM patients GROUP BY first_name HAVING count(*) = 1;

-- Q14 Show patient_id and first_name from patients where their first_name start and ends with
--     's' and is atleast 5 characters long.


SELECT patient_id, first_name FROM patients where first_name like 's___%s';

-- Q15 Show patient_id, first_name, last_name from patients whos primary_diagnosis is 'Dementia'.
-- Primary diagnosis is stored in the admissions table.

SELECT patient_id, first_name FROM patients where first_name like 's___%s';

--Q16 Show patient_id, first_name, last_name from patients whos primary_diagnosis is 'Dementia'.
-- Primary diagnosis is stored in the admissions table.

SELECT patients.patient_id, first_name,last_name FROM patients
JOIN admissions ON admissions.patient_id = patients.patient_id
WHERE primary_diagnosis = 'Dementia';

-- Q17 Show patient_id, first_name, last_name from the patients table.Order the rows by the
-- first_name ascending and then by the last_name descending.

SELECT patient_id, first_name, last_name FROM patients ORDer by first_name ASC, last_name DESC;

-- Q18 Show the total amount of male patients and the total amount of female patients in the
-- patients table

select (SELECT COUNT(*) FROM patients WHERE gender='M') as male_count, (select count(*) from patients
where gender='F') as female_count;

-- Q19 Show first and last name, allergies from patients which have allergies to
--     either 'Penicillin' or 'Morphine'.
-- Show results ordered ascending by allergies then by first_name then by last_name.

SELECT first_name, last_name, allergies FROM patients
  WHERE allergies IN ('Penicillin', 'Morphine')
  ORDER BY allergies, first_name, last_name;


-- Q20 Show patient_id, primary_diagnosis from admissions. Find patients admitted multiple times for
-- the same primary_diagnosis.

select patient_id, primary_diagnosis from admissions group by patient_id, primary_diagnosis
having count(*) > 1;


-- Q21 Show the city and the total number of patients in the city in the order from most to least
-- patients.

select city, count(*) as  num_patients from patients group by city order by num_patients desc ;

-- Q22 Show first name, last name and role of every person that is either patient or physician.
-- The roles are either "Patient" or "Physician"

select first_name, last_name, 'Patient' as 'Role' from patients
union
select first_name, last_name, 'Physician'  as 'Role' from physicians;

-- Q23 Show all of the patients grouped into weight groups.
-- Show the total amount of patients in each weight group.
-- Order the list by the weight group decending.
--
-- For example, if they weight 100 to 109 they are placed in the 100 weight group,
-- 110-119 = 110 weight group, etc.
--

select count(*) as patients_in_group, weight/10*10 as weight_group from patients
group by weight_group
order by weight_group desc;


-- Q24 Show patient_id, weight, height, isObese from the patients table.
--
-- Display isObese as a boolean 0 or 1.
--
-- Obese is defined as weight(kg)/(height(m)2) >= 30.
--
-- weight is in units kg.
--
-- height is in units cm.

select patient_id, weight, height,
(
CASE
      WHEN weight/(POWER(height/100.0,2)) >= 30 THEN
          1
      ELSE
          0
END
)
AS isObese
from patients;

-- Q25 Show patient_id, first_name, last_name, and attending physician's specialty.
-- Show only the patients who has a primary_diagnosis as 'Dementia' and the physician's first name
-- is 'Lisa'
--
-- Check patients, admissions, and physicians tables for required information.

SELECT p.patient_id, p.first_name as patient_first_name, p.last_name as patient_last_name, ph.specialty as attending_physician_specialty FROM patients p
  JOIN admissions a ON a.patient_id = p.patient_id
  JOIN physicians ph ON ph.physician_id = a.attending_physician_id
  WHERE primary_diagnosis = 'Dementia' AND ph.first_name = 'Lisa';

-- Q26 All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.
--
-- The password must be the following, in order:
-- 1. patient_id
-- 2. the numerical length of patient's last_name
-- 3. year of patient's birth_date

SELECT distinct patient_id,temp_password FROM
(SELECT patients.patient_id,
CONCAT(patients.patient_id,LEN(last_name),YEAR(birth_date)) as temp_password
from admissions
JOIN patients ON admissions.patient_id = patients.patient_id)


-- q27 Each admission costs $50 for patients without insurance, and $10 for patients with insurance.
-- All patients with an even patient_id have insurance.
--
-- Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. ' ||
-- 'Add up the admission_total cost for each has_insurance group.

SELECT
CASE WHEN patient_id % 2 = 0 Then
    'Yes'
ELSE
    'No'
END as has_insurance,
SUM(CASE WHEN patient_id % 2 = 0 Then
    10
ELSE
    50
END) as cost_after_insurance
FROM admissions
GROUP BY has_insurance;


-- Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name

SELECT
pr.province_name
FROM
patients as pa
JOIN
provinces as pr
ON
pa.province_id = pr.province_id
GROUP BY
pr.province_name
HAVING
COUNT(CASE WHEN gender = 'M' THEN 1 END) > COUNT(CASE WHEN gender = 'F' THEN 1 END);

-- We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
-- - First_name contains an 'r' after the first two letters.
-- - Identifies their gender as 'F'
-- - Born in February, May, or December
-- - Their weight would be between 60kg and 80kg
-- - Their patient_id is an odd number
-- - They are from the city 'Halifax'

select * from patients where first_name like '__r%' and
gender = 'F' and
month(birth_date) in (2, 5, 12) and
weight between 60 and 80 and
patient_id % 2 = 1 and
city= 'Halifax';

-- Show the percent of patients that have 'M' as their gender. Round the answer to the nearest
--     hundreth number and in percent form.

SELECT
CONCAT(ROUND((SELECT COUNT(*) FROM patients WHERE gender = 'M')/(COUNT(*)*1.0),4)*100,'%') as percent_of_male_patients
FROM patients;