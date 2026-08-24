drop table if exists hospital_data;
create table hospital_data(
	hospital_name varchar(100), 
	location varchar(50),
	department varchar(50),
	doctors_count int,
	patients_count int,
	admission_date date,
	discharge_date date,
	medical_expenses numeric(10,2)

);

copy hospital_data(hospital_name , location ,department , doctors_count ,
patients_count , admission_date , discharge_date ,	medical_expenses 
)
from 'D:\DEMON KING\One drive\OneDrive\Desktop\Tandon\MySQL notes\Hospital_Data.csv'
delimiter ','
csv header;

select * from hospital_data;

--1. Total Number of Patients
select sum(patients_count) as total_patients from hospital_data;

--2. Average Number of Doctors per Hospital
select hospital_name, avg(doctors_count) as avg_doct_count from hospital_data
group by hospital_name;

--3. Top 3 Departments with the Highest Number of Patients.
select department, sum(patients_count) as no_of_patients from hospital_data
group by department
order by no_of_patients desc limit 3;

--4. Hospital with the Maximum Medical Expenses
select hospital_name,sum(medical_expenses) as max_expenses from hospital_data
group by hospital_name
order by max_expenses desc limit 1;

--5. Daily Average Medical Expenses
select hospital_name,avg(medical_expenses) as avg_expenses from hospital_data
group by hospital_name;

--6. Longest Hospital Stay
select * (discharge_date::date - admission_date::date) as stay_days
from hospital_data
order by stay_days desc limit 1;

--7. Total Patients Treated Per City
select  location , sum(patients_count) as total_patients
from hospital_data
group by location 
order by total_patients desc;

--8. Average Length of Stay Per Department
select department ,avg(discharge_date::date - admission_date::date) as stay_days
from hospital_data
group by department;

--9. Identify the Department with the Lowest Number of Patients
select department,sum(patients_count) as lowest_patient from hospital_data 
group by department
order by lowest_patient limit 1;

--10. Monthly Medical Expenses Report
select to_char(admission_date::date,'YYYY-MM') as month,
	sum(medical_expenses) as total_expenses
from hospital_data
group by month
order by month;
