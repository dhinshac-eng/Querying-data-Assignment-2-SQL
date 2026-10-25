use employee;
insert into Departments(department_id,department_name)values(101,"Finance"),(102,"IT"),(103,"HR"),(104,"Marketing"),(105,"Research");
insert into Location(location_id,location_name)values(111,"Kozhikode"),(112,"Kochi"),(113,"Kannur"),(114,"Thalassery"),(115,"Trissur");
insert into Employees(employee_id,employee_name,gender,age,hire_date,designation,department_id,location_id,salary)
values(121,"Anu","F",25,'2018-03-25',"Data Analyst",101,111,45000),(122,"Rahul","M",29,'2015-06-19',"Accountant",102,112,65000),
 (123,"Meera","F",26,'2020-07-15',"HR Executive",103,113,40000),(124,"Akash","M",32,'2015-08-21',"Software Engineer",104,114,52000),
 (125,"Diya","F",24,'2021-01-11',"Data Scientist",105,115,70000),(126,"Nikhil","M",30,'2018-05-16',NULL,105,112,75000),
 (127,"Vishnu","M",24,'2022-10-20',"Business Analyst",102,111,50000),(128,"Adithya","F",27,'2018-08-23',"Accountant",102,114,55000),
 (129,"Sneha","F",29,'2018-04-22',"Software Engineer",104,115,66000),(130,"Dhanush","M",30,'2018-02-15',"HR Manager",103,111,60000);
select * from Departments;
select* from Location;
select * from Employees; 

-- Distinct
select distinct salary from Employees;
-- Alias
select age as Employee_age,salary as Employee_salary from Employees;
-- Where clause & operators
select * from Employees where salary > 50000 and hire_date < '2016-01-01';
select * from Employees where designation is null;
update Employees set designation = "Data Scientist" where employee_id = 126;

-- Order by
select * from Employees order by department_id asc,salary desc;

-- Limit
select * from Employees where hire_date >= '2018-01-01' and hire_date < '2019-01-01'order by hire_date asc limit 5;

-- Aggregate function
select sum(e.salary) as Total_finance_salary from Employees e inner join Departments d on e.department_id=d.department_id where d.department_name="Finance";
select min(age) as minimum_age from Employees;

-- Group by
select location_id,max(salary) as maximum_salary from Employees group by location_id;
select designation,avg(salary)as average_salary from Employees where designation like "%Analyst%" group by designation;

-- Having
Select
    department_id,
    count(*) as Total_Employees
	location_namefrom employees
	group by department_id
having count(*) < 3;
select
    location_id,
	avg(age) as Average_Age
	from employees
	where gender = "F"
	group by location_id
	having avg(age) < 30;

-- Inner join
select
    e.employee_name,
    e.designation,
    d.department_name
	from employees as e
	inner join departments as d
    on e.department_id = d.department_id;
    
-- Left join    
select
    d.department_name,
	count(e.employee_id) as Total_Employees
	from departments as d
	left join employees as e
	on d.department_id = e.department_id
	group by d.department_id, d.department_name;

-- Right join
select
   l.location_name,e.employee_name
   from employees as e 
   right join location as l
   on e.location_id = l.location_id;