--Employee Table 
 
CREATE TABLE employees ( 
    employee_id NUMBER PRIMARY KEY, 
    name VARCHAR2(100) not null, 
    department_id NUMBER , 
    hourly_rate NUMBER , 
    hours_worked NUMBER, 
    salary NUMBER not null, 
    hiredate DATE not null, 
    manager_id NUMBER, 
    commission NUMBER, 
    job_id VARCHAR2(100) not null, 
    CONSTRAINT fk_department FOREIGN KEY (department_id) REFERENCES departments(department_id), 
    CONSTRAINT fk_job FOREIGN KEY (job_id) REFERENCES jobs(job_id) 
); 
DROP TABLE EMPLOYEES 
SELECT * FROM EMPLOYEES 
 
--Trigger for employee table 
 
CREATE OR REPLACE TRIGGER update_hourly_rate_and_hours_worked 
BEFORE INSERT OR UPDATE OF Salary ON EMPLOYEES 
FOR EACH ROW 
BEGIN 
    :NEW.Hourly_Rate := ROUND(:NEW.Salary / 30 / 9); 
         
    IF :NEW.Hours_Worked IS NULL THEN 
        :NEW.Hours_Worked := 9; 
    END IF; 
END; 
  
--Employee table insertion 
 
BEGIN 
INSERT INTO employees (employee_id, name, department_id, hourly_rate, hours_worked, salary, hiredate, manager_id, commission, job_id) 
VALUES (1, 'John Smith', 101, NULL, NULL, 40000, TO_DATE('2005-05-01', 'YYYY-MM-DD'), NULL, NULL, 'AD_PRES'); 
  
INSERT INTO employees (employee_id, name, department_id, hourly_rate, hours_worked, salary, hiredate, manager_id, commission, job_id) 
VALUES (2, 'Jane Doe', 102, NULL, NULL, 6000, TO_DATE('2020-10-15', 'YYYY-MM-DD'), 1, NULL, 'AD_VP'); 
  
INSERT INTO employees (employee_id, name, department_id, hourly_rate, hours_worked, salary, hiredate, manager_id, commission, job_id) 
VALUES (3, 'Michael Johnson', 103, NULL, NULL, 17000, TO_DATE('2017-02-20', 'YYYY-MM-DD'), 7, NULL, 'AD_VP'); 
  
INSERT INTO employees (employee_id, name, department_id, hourly_rate, hours_worked, salary, hiredate, manager_id, commission, job_id) 
VALUES (4, 'Emily Brown', 104, NULL, NULL, 6000, TO_DATE('2023-03-10', 'YYYY-MM-DD'), 6, NULL, 'AD_ASST'); 
  
INSERT INTO employees (employee_id, name, department_id, hourly_rate, hours_worked, salary, hiredate, manager_id, commission, job_id) 
VALUES (5, 'David Jones', 105, NULL, NULL, 4200, TO_DATE('2008-07-05', 'YYYY-MM-DD'), 5, NULL, 'FI_ACCOUNT'); 
  
INSERT INTO employees (employee_id, name, department_id, hourly_rate, hours_worked, salary, hiredate, manager_id, commission, job_id) 
VALUES (6, 'Sarah Wilson', 106, NULL, NULL, 6000, TO_DATE('2017-12-20', 'YYYY-MM-DD'), 11, NULL, 'AD_ASST'); 
  
INSERT INTO employees (employee_id, name, department_id, hourly_rate, hours_worked, salary, hiredate, manager_id, commission, job_id) 
VALUES (7, 'James Taylor', 107, NULL, NULL, 6000, TO_DATE('2020-04-01', 'YYYY-MM-DD'), 12, NULL, 'AD_ASST'); 
  
INSERT INTO employees (employee_id, name, department_id, hourly_rate, hours_worked, salary, hiredate, manager_id, commission, job_id) 
VALUES (8, 'Jennifer Martinez', 108, NULL, NULL, 6000, TO_DATE('2020-01-15', 'YYYY-MM-DD'), 14, NULL, 'AD_ASST'); 
  
INSERT INTO employees (employee_id, name, department_id, hourly_rate, hours_worked, salary, hiredate, manager_id, commission, job_id) 
VALUES (9, 'Robert Garcia', 109, NULL, NULL, 6000, TO_DATE('2021-09-10', 'YYYY-MM-DD'), 15, NULL, 'AD_ASST'); 
  
INSERT INTO employees (employee_id, name, department_id, hourly_rate, hours_worked, salary, hiredate, manager_id, commission, job_id) 
VALUES (10, 'Jessica Lopez', 110, NULL, NULL, 4200, TO_DATE('2016-11-05', 'YYYY-MM-DD'), 20, NULL, 'FI_ACCOUNT'); 
  
INSERT INTO employees (employee_id, name, department_id, hourly_rate, hours_worked, salary, hiredate, manager_id, commission, job_id) 
VALUES (11, 'William Hernandez', 101, NULL, NULL, 17000, TO_DATE('2023-06-01', 'YYYY-MM-DD'), 10, NULL, 'AD_VP'); 
  
INSERT INTO employees (employee_id, name, department_id, hourly_rate, hours_worked, salary, hiredate, manager_id, commission, job_id) 
VALUES (12, 'Mary Young', 102, NULL, NULL, 17000, TO_DATE('2007-05-15', 'YYYY-MM-DD'), 9, NULL, 'AD_VP'); 
  
INSERT INTO employees (employee_id, name, department_id, hourly_rate, hours_worked, salary, hiredate, manager_id, commission, job_id) 
VALUES (13, 'Matthew King', 107, NULL, NULL, 17000, TO_DATE('2017-04-20', 'YYYY-MM-DD'), 12, NULL, 'AD_VP'); 
  
INSERT INTO employees (employee_id, name, department_id, hourly_rate, hours_worked, salary, hiredate, manager_id, commission, job_id) 
VALUES (14, 'Ashley Lee', 101, NULL, NULL, 17000, TO_DATE('2021-03-05', 'YYYY-MM-DD'), 17, NULL, 'AD_VP'); 
  
INSERT INTO employees (employee_id, name, department_id, hourly_rate, hours_worked, salary, hiredate, manager_id, commission, job_id) 
VALUES (15, 'Christopher Perez', 101, NULL, NULL, 6000, TO_DATE('2023-12-10', 'YYYY-MM-DD'), 16, NULL, 'AD_ASST'); 
  
INSERT INTO employees (employee_id, name, department_id, hourly_rate, hours_worked, salary, hiredate, manager_id, commission, job_id) 
VALUES (16, 'Amanda Nelson', 102, NULL, NULL, 6000, TO_DATE('2020-11-25', 'YYYY-MM-DD'), 1, NULL, 'AD_ASST'); 
  
INSERT INTO employees (employee_id, name, department_id, hourly_rate, hours_worked, salary, hiredate, manager_id, commission, job_id) 
VALUES (17, 'Daniel Thomas', 103, NULL, NULL, 4200, TO_DATE('2005-10-01', 'YYYY-MM-DD'), 7, NULL, 'FI_ACCOUNT'); 
  
INSERT INTO employees (employee_id, name, department_id, hourly_rate, hours_worked, salary, hiredate, manager_id, commission, job_id) 
VALUES (18, 'Kimberly Walker', 104, NULL, NULL, 4200, TO_DATE('2006-09-15', 'YYYY-MM-DD'), 10, NULL, 'FI_ACCOUNT'); 
  
INSERT INTO employees (employee_id, name, department_id, hourly_rate, hours_worked, salary, hiredate, manager_id, commission, job_id) 
VALUES (19, 'Kevin Hill', 101, NULL, NULL, 6000, TO_DATE('2020-02-05', 'YYYY-MM-DD'), 19, NULL, 'AD_ASST'); 
  
INSERT INTO employees (employee_id, name, department_id, hourly_rate, hours_worked, salary, hiredate, manager_id, commission, job_id) 
VALUES (20, 'Michelle Adams', 102, NULL, NULL, 6000,TO_DATE('2017-01-20', 'YYYY-MM-DD'), 18, NULL, 'AD_ASST'); 
END; 
 
--Jobs Table 
 
CREATE TABLE jobs ( 
    job_id VARCHAR2(10) PRIMARY KEY, 
    job_title VARCHAR2(100) NOT NULL 
); 
  
--Jobs table Insertion 
 
BEGIN 
    INSERT INTO jobs (job_id, job_title) VALUES ('AD_PRES', 'President'); 
    INSERT INTO jobs (job_id, job_title) VALUES ('AD_VP', 'Administration Vice President'); 
    INSERT INTO jobs (job_id, job_title) VALUES ('AD_ASST', 'Administration Assistant'); 
    INSERT INTO jobs (job_id, job_title) VALUES ('FI_MGR', 'Finance Manager'); 
    INSERT INTO jobs (job_id, job_title) VALUES ('FI_ACCOUNT', 'Accountant'); 
    INSERT INTO jobs (job_id, job_title) VALUES ('AC_MGR', 'Accounting Manager'); 
    INSERT INTO jobs (job_id, job_title) VALUES ('AC_ACCOUNT', 'Public Accountant'); 
    INSERT INTO jobs (job_id, job_title) VALUES ('SA_MAN', 'Sales Manager'); 
    INSERT INTO jobs (job_id, job_title) VALUES ('SA_REP', 'Sales Representative'); 
    INSERT INTO jobs (job_id, job_title) VALUES ('PU_MAN', 'Purchasing Manager'); 
END; 
 
Departments Table 
 
CREATE TABLE departments ( 
    department_id NUMBER PRIMARY KEY, 
    department_name VARCHAR2(100) NOT NULL, 
    manager_id NUMBER , 
    location_id NUMBER 
); 
  
SELECT * FROM DEPARTMENTS 
 
--Department Table Insertion 
 
BEGIN 
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (101, 'Human Resources', 1, 1); 
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (102, 'Marketing', 2, 2); 
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (103, 'Finance', 3, 3); 
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (104, 'Engineering', 4, 4); 
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (105, 'Sales', 5, 5); 
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (106, 'Customer Service', 6, 1); 
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (107, 'IT', 7, 4); 
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (108, 'Operations', 8, 3); 
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (109, 'Research and Development', 9, 4); 
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES (110, 'Supply Chain', 0, 2); 
END; 
 
--Attendence Table 
  
CREATE TABLE Attendance ( 
    Attendance_id NUMBER PRIMARY KEY, 
    Employee_id NUMBER not null , 
    Attendance_date DATE  default sysdate, 
    Check_in TIMESTAMP, 
    Check_out TIMESTAMP, 
    CONSTRAINT fk_employee FOREIGN KEY (Employee_id) REFERENCES Employees(Employee_id) 
); 
  
--Attendence Table Insertion 
  
truncate table attendance 
  
BEGIN 
  
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (1, 1, TO_DATE('2024-06-03', 'YYYY-MM-DD'), TO_DATE('2024-06-03 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-03 17:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (2, 1, TO_DATE('2024-06-04', 'YYYY-MM-DD'), TO_DATE('2024-06-04 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-04 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (3, 1, TO_DATE('2024-06-05', 'YYYY-MM-DD'), TO_DATE('2024-06-05 08:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-05 17:30:00', 'YYYY-MM-DD HH24:MI:SS')); 
  
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (4, 2, TO_DATE('2024-06-03', 'YYYY-MM-DD'), TO_DATE('2024-06-03 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-03 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (5, 2, TO_DATE('2024-06-04', 'YYYY-MM-DD'), TO_DATE('2024-06-04 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-04 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (6, 2, TO_DATE('2024-06-05', 'YYYY-MM-DD'), TO_DATE('2024-06-05 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-05 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
  
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (7, 3, TO_DATE('2024-06-03', 'YYYY-MM-DD'), TO_DATE('2024-06-03 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-03 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (8, 3, TO_DATE('2024-06-04', 'YYYY-MM-DD'), TO_DATE('2024-06-04 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-04 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (9, 3, TO_DATE('2024-06-05', 'YYYY-MM-DD'), TO_DATE('2024-06-05 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-05 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
  
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (10, 4, TO_DATE('2024-06-03', 'YYYY-MM-DD'), TO_DATE('2024-06-03 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-03 17:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (11, 4, TO_DATE('2024-06-04', 'YYYY-MM-DD'), TO_DATE('2024-06-04 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-04 19:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (12, 4, TO_DATE('2024-06-05', 'YYYY-MM-DD'), TO_DATE('2024-06-05 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-05 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
  
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (13, 5, TO_DATE('2024-06-03', 'YYYY-MM-DD'), TO_DATE('2024-06-03 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-03 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (14, 5, TO_DATE('2024-06-04', 'YYYY-MM-DD'), TO_DATE('2024-06-04 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-04 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (15, 5, TO_DATE('2024-06-05', 'YYYY-MM-DD'), TO_DATE('2024-06-05 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-05 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
  
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (16, 6, TO_DATE('2024-06-03', 'YYYY-MM-DD'), TO_DATE('2024-06-03 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-03 17:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (17, 6, TO_DATE('2024-06-04', 'YYYY-MM-DD'), TO_DATE('2024-06-04 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-04 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (18, 6, TO_DATE('2024-06-05', 'YYYY-MM-DD'), TO_DATE('2024-06-05 07:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-05 16:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
  
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (19, 7, TO_DATE('2024-06-03', 'YYYY-MM-DD'), TO_DATE('2024-06-03 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-03 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (20, 7, TO_DATE('2024-06-04', 'YYYY-MM-DD'), TO_DATE('2024-06-04 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-04 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (21, 7, TO_DATE('2024-06-05', 'YYYY-MM-DD'), TO_DATE('2024-06-05 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-05 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
  
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (22, 8, TO_DATE('2024-06-03', 'YYYY-MM-DD'), TO_DATE('2024-06-03 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-03 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (23, 8, TO_DATE('2024-06-04', 'YYYY-MM-DD'), TO_DATE('2024-06-04 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-04 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (24, 8, TO_DATE('2024-06-05', 'YYYY-MM-DD'), TO_DATE('2024-06-05 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-05 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
  
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (25, 9, TO_DATE('2024-06-03', 'YYYY-MM-DD'), TO_DATE('2024-06-03 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-03 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (26, 9, TO_DATE('2024-06-04', 'YYYY-MM-DD'), TO_DATE('2024-06-04 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-04 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (27, 9, TO_DATE('2024-06-05', 'YYYY-MM-DD'), TO_DATE('2024-06-05 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-05 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
  
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (28, 10, TO_DATE('2024-06-03', 'YYYY-MM-DD'), TO_DATE('2024-06-03 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-03 16:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (29, 10, TO_DATE('2024-06-04', 'YYYY-MM-DD'), TO_DATE('2024-06-04 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-04 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (30, 10, TO_DATE('2024-06-05', 'YYYY-MM-DD'), TO_DATE('2024-06-05 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-05 17:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
  
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (31, 11, TO_DATE('2024-06-03', 'YYYY-MM-DD'), TO_DATE('2024-06-03 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-03 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (32, 11, TO_DATE('2024-06-04', 'YYYY-MM-DD'), TO_DATE('2024-06-04 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-04 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (33, 11, TO_DATE('2024-06-05', 'YYYY-MM-DD'), TO_DATE('2024-06-05 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-05 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
  
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (34, 12, TO_DATE('2024-06-03', 'YYYY-MM-DD'), TO_DATE('2024-06-03 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-03 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (35, 12, TO_DATE('2024-06-04', 'YYYY-MM-DD'), TO_DATE('2024-06-04 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-04 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (36, 12, TO_DATE('2024-06-05', 'YYYY-MM-DD'), TO_DATE('2024-06-05 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-05 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
  
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (37, 13, TO_DATE('2024-06-03', 'YYYY-MM-DD'), TO_DATE('2024-06-03 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-03 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (38, 13, TO_DATE('2024-06-04', 'YYYY-MM-DD'), TO_DATE('2024-06-04 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-04 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (39, 13, TO_DATE('2024-06-05', 'YYYY-MM-DD'), TO_DATE('2024-06-05 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-05 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
  
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (40, 14, TO_DATE('2024-06-03', 'YYYY-MM-DD'), TO_DATE('2024-06-03 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-03 17:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (41, 14, TO_DATE('2024-06-04', 'YYYY-MM-DD'), TO_DATE('2024-06-04 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-04 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (42, 14, TO_DATE('2024-06-05', 'YYYY-MM-DD'), TO_DATE('2024-06-05 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-05 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
  
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (43, 15, TO_DATE('2024-06-03', 'YYYY-MM-DD'), TO_DATE('2024-06-03 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-03 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (44, 15, TO_DATE('2024-06-04', 'YYYY-MM-DD'), TO_DATE('2024-06-04 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-04 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (45, 15, TO_DATE('2024-06-05', 'YYYY-MM-DD'), TO_DATE('2024-06-05 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-05 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
  
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (46, 16, TO_DATE('2024-06-03', 'YYYY-MM-DD'), TO_DATE('2024-06-03 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-03 17:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (47, 16, TO_DATE('2024-06-04', 'YYYY-MM-DD'), TO_DATE('2024-06-04 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-04 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (48, 16, TO_DATE('2024-06-05', 'YYYY-MM-DD'), TO_DATE('2024-06-05 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-05 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
  
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (49, 17, TO_DATE('2024-06-03', 'YYYY-MM-DD'), TO_DATE('2024-06-03 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-03 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (50, 17, TO_DATE('2024-06-04', 'YYYY-MM-DD'), TO_DATE('2024-06-04 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-04 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (51, 17, TO_DATE('2024-06-05', 'YYYY-MM-DD'), TO_DATE('2024-06-05 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-05 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
  
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (52, 18, TO_DATE('2024-06-03', 'YYYY-MM-DD'), TO_DATE('2024-06-03 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-03 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (53, 18, TO_DATE('2024-06-04', 'YYYY-MM-DD'), TO_DATE('2024-06-04 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-04 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (54, 18, TO_DATE('2024-06-05', 'YYYY-MM-DD'), TO_DATE('2024-06-05 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-05 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
  
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (55, 19, TO_DATE('2024-06-03', 'YYYY-MM-DD'), TO_DATE('2024-06-03 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-03 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (56, 19, TO_DATE('2024-06-04', 'YYYY-MM-DD'), TO_DATE('2024-06-04 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-04 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (57, 19, TO_DATE('2024-06-05', 'YYYY-MM-DD'), TO_DATE('2024-06-05 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-05 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
  
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (58, 20, TO_DATE('2024-06-03', 'YYYY-MM-DD'), TO_DATE('2024-06-03 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-03 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (59, 20, TO_DATE('2024-06-04', 'YYYY-MM-DD'), TO_DATE('2024-06-04 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-04 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (60, 20, TO_DATE('2024-06-05', 'YYYY-MM-DD'), TO_DATE('2024-06-05 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-05 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
  
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (61, 1, TO_DATE('2024-06-06', 'YYYY-MM-DD'), TO_DATE('2024-06-06 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-06 17:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (62, 1, TO_DATE('2024-06-07', 'YYYY-MM-DD'), TO_DATE('2024-06-07 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-07 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (63, 1, TO_DATE('2024-06-08', 'YYYY-MM-DD'), TO_DATE('2024-06-08 08:30:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-08 17:30:00', 'YYYY-MM-DD HH24:MI:SS')); 
  
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (64, 11, TO_DATE('2024-06-06', 'YYYY-MM-DD'), TO_DATE('2024-06-06 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-06 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (65, 11, TO_DATE('2024-06-07', 'YYYY-MM-DD'), TO_DATE('2024-06-07 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-07 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (66, 11, TO_DATE('2024-06-08', 'YYYY-MM-DD'), TO_DATE('2024-06-08 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-08 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
  
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (67, 14, TO_DATE('2024-06-06', 'YYYY-MM-DD'), TO_DATE('2024-06-06 08:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-06 17:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (68, 14, TO_DATE('2024-06-07', 'YYYY-MM-DD'), TO_DATE('2024-06-07 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-07 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
INSERT INTO Attendance (Attendance_id, Employee_id, Attendance_date, Check_in, Check_out)  
VALUES (69, 14, TO_DATE('2024-06-08', 'YYYY-MM-DD'), TO_DATE('2024-06-08 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_DATE('2024-06-08 18:00:00', 'YYYY-MM-DD HH24:MI:SS')); 
END; 
  
SELECT * FROM ATTENDANCE 
 
--Location Table 
  
CREATE TABLE Location ( 
    Location_ID NUMBER PRIMARY KEY, 
    Street_address VARCHAR2(100) not null, 
    Postal_code VARCHAR2(20) not null, 
    City VARCHAR2(100)not null, 
    Country_name VARCHAR2(100) not null, 
    Region VARCHAR2(100) not null 
); 
  
--Location table Insertion 
  
BEGIN 
    INSERT INTO Location (Location_ID, Street_address, Postal_code, City, Country_name, Region) VALUES (1, '123 Main St', '12345', 'New York', 'USA', 'North America'); 
    INSERT INTO Location (Location_ID, Street_address, Postal_code, City, Country_name, Region) VALUES(2, '456 Elm St', '67890', 'Los Angeles', 'USA', 'North America'); 
    INSERT INTO Location (Location_ID, Street_address, Postal_code, City, Country_name, Region) VALUES(3, '789 Oak St', '54321', 'London', 'UK', 'Europe'); 
    INSERT INTO Location (Location_ID, Street_address, Postal_code, City, Country_name, Region) VALUES(4, '101 Pine St', '13579', 'Tokyo', 'Japan', 'Asia'); 
    INSERT INTO Location (Location_ID, Street_address, Postal_code, City, Country_name, Region) VALUES(5, '202 Maple St', '97531', 'Sydney', 'Australia', 'Oceania'); 
    INSERT INTO Location (Location_ID, Street_address, Postal_code, City, Country_name, Region) VALUES(6, '303 Cedar St', '86420', 'Toronto', 'Canada', 'North America'); 
    INSERT INTO Location (Location_ID, Street_address, Postal_code, City, Country_name, Region) VALUES(7, '404 Walnut St', '24680', 'Paris', 'France', 'Europe'); 
    INSERT INTO Location (Location_ID, Street_address, Postal_code, City, Country_name, Region) VALUES(8, '505 Birch St', '97531', 'Sydney', 'Australia', 'Oceania'); 
    INSERT INTO Location (Location_ID, Street_address, Postal_code, City, Country_name, Region) VALUES(9, '606 Pine St', '54321', 'Berlin', 'Germany', 'Europe'); 
    INSERT INTO Location (Location_ID, Street_address, Postal_code, City, Country_name, Region) VALUES(10, '707 Oak St', '12345', 'San Francisco', 'USA', 'North America'); 
END; 
  
select * from location 
 
--Leaverequests table 
  
CREATE TABLE LeaveRequests ( 
    Request_id NUMBER PRIMARY KEY, 
    Employee_id NUMBER not null, 
    StartDate DATE not null, 
    EndDate DATE, 
    Leave_type Varchar2(100) not null, 
    No_of_leaves number, 
    Status VARCHAR2(20) default 'Pending', 
    CONSTRAINT fk_employee_leave_request FOREIGN KEY (Employee_id) REFERENCES Employees(Employee_id) 
); 
  
--LeaveRequests Table Insertion 
  
BEGIN 
INSERT INTO LeaveRequests (Request_id, Employee_id, StartDate, EndDate, Leave_type,No_of_leaves,Status)VALUES (1, 1, TO_DATE('2005-06-01', 'YYYY-MM-DD'), TO_DATE('2005-06-05', 'YYYY-MM-DD'),'Earned',4, 'Rejected'); 
INSERT INTO LeaveRequests (Request_id, Employee_id, StartDate, EndDate,Leave_type, No_of_leaves,Status)VALUES (2, 2, TO_DATE('2021-06-03', 'YYYY-MM-DD'), TO_DATE('2021-06-07', 'YYYY-MM-DD'),'sick', 1,'Approved'); 
INSERT INTO LeaveRequests (Request_id, Employee_id, StartDate, EndDate, Leave_type,No_of_leaves,Status)VALUES (3, 3, TO_DATE('2017-06-10', 'YYYY-MM-DD'), TO_DATE('2017-06-15', 'YYYY-MM-DD'), 'Earned',3,'Approved'); 
INSERT INTO LeaveRequests (Request_id, Employee_id, StartDate, EndDate, Leave_type,No_of_leaves,Status)VALUES (4, 14, TO_DATE('2024-06-12', 'YYYY-MM-DD'), TO_DATE('2024-06-14', 'YYYY-MM-DD'),'Earned',5, 'Rejected'); 
INSERT INTO LeaveRequests (Request_id, Employee_id, StartDate, EndDate, Leave_type,No_of_leaves,Status)VALUES (5, 5, TO_DATE('2009-06-18', 'YYYY-MM-DD'), TO_DATE('2009-06-22', 'YYYY-MM-DD'), 'Bereavement',2,'Approved'); 
INSERT INTO LeaveRequests (Request_id, Employee_id, StartDate, EndDate, Leave_type,No_of_leaves,Status)VALUES (6, 6, TO_DATE('2018-06-25', 'YYYY-MM-DD'), TO_DATE('2018-06-29', 'YYYY-MM-DD'), 'sick',1,'Aprroved'); 
INSERT INTO LeaveRequests (Request_id, Employee_id, StartDate, EndDate, Leave_type,No_of_leaves,Status)VALUES (7, 17, TO_DATE('2021-07-01', 'YYYY-MM-DD'), TO_DATE('2021-07-05', 'YYYY-MM-DD'),'Earned',1, 'Approved'); 
INSERT INTO LeaveRequests (Request_id, Employee_id, StartDate, EndDate, Leave_type,No_of_leaves,Status)VALUES (8, 8, TO_DATE('2021-07-03', 'YYYY-MM-DD'), TO_DATE('2021-07-08', 'YYYY-MM-DD'),'Earned', 9,'Rejected'); 
INSERT INTO LeaveRequests (Request_id, Employee_id, StartDate, EndDate, Leave_type,No_of_leaves,Status)VALUES (9, 9, TO_DATE('2022-07-10', 'YYYY-MM-DD'), TO_DATE('2022-07-14', 'YYYY-MM-DD'), 'Earned',7,'Rejected'); 
INSERT INTO LeaveRequests (Request_id, Employee_id, StartDate, EndDate, Leave_type,No_of_leaves,Status)VALUES (10, 20, TO_DATE('2024-07-12', 'YYYY-MM-DD'), TO_DATE('2024-07-16', 'YYYY-MM-DD'), 'Earned',2,'Pending'); 
END; 
  
SELECT * FROM  LeaveRequests; 
  
drop table LeaveRequests; 
 
--Personal Information Table 
  
CREATE TABLE Personal_Info ( 
    Personal_Info_ID NUMBER PRIMARY KEY, 
    Employee_ID NUMBER NOT NULL, 
    Gender VARCHAR2(15) NOT NULL, 
    Date_Of_Birth DATE NOT NULL, 
    Address VARCHAR2(255) NOT NULL, 
    Contact_Number NUMBER(16) NOT NULL, 
    Email VARCHAR2(200) NOT NULL, 
    Constraint fk_per_info FOREIGN KEY (Employee_ID) REFERENCES Employees(Employee_ID) 
); 
  
Drop table personal_info 
 
--Personal Information Table insertion 
  
BEGIN 
INSERT INTO Personal_Info (Personal_Info_ID, Employee_ID, Gender, Date_Of_Birth, Address, Contact_Number, Email) 
VALUES (1, 1, 'Male', TO_DATE('1985-03-14','yyyy-mm-dd'), '123 Elm St, Apt 18, Downtown, New York, USA', '1212423533', 'johnsmith14@gmail.com'); 
INSERT INTO Personal_Info (Personal_Info_ID, Employee_ID, Gender, Date_Of_Birth, Address, Contact_Number, Email) 
VALUES (2, 2, 'Female', TO_DATE('1990-11-28','yyyy-mm-dd'), '456 Oak St, Unit 19, Midtown, New York, USA', '5852667477', 'janedoe28@gmail.com'); 
INSERT INTO Personal_Info (Personal_Info_ID, Employee_ID, Gender, Date_Of_Birth, Address, Contact_Number, Email) 
VALUES (3, 3, 'Male', TO_DATE('1979-07-02','yyyy-mm-dd'), '789 Pine St, Apt 20, Chelsea, London, UK', '9980201811', 'michaeljohnson02@gmail.com'); 
INSERT INTO Personal_Info (Personal_Info_ID, Employee_ID, Gender, Date_Of_Birth, Address, Contact_Number, Email) 
VALUES (4, 4, 'Female', TO_DATE('1988-05-18','yyyy-mm-dd'), '987 Maple St, Flat 21, Soho, London, UK', '3238445955', 'emilybrown@example18@gmail.com'); 
INSERT INTO Personal_Info (Personal_Info_ID, Employee_ID, Gender, Date_Of_Birth, Address, Contact_Number, Email) 
VALUES (5, 5, 'Male', TO_DATE('1993-09-30','yyyy-mm-dd'), '321 Birch St, Apt 22, Canary Wharf, London, UK', '7978589979', 'davidjones30@gmail.com'); 
INSERT INTO Personal_Info (Personal_Info_ID, Employee_ID, Gender, Date_Of_Birth, Address, Contact_Number, Email) 
VALUES (6, 6, 'Female', TO_DATE('1982-08-12','yyyy-mm-dd'), '654 Elm St, Unit 23, Covent Garden, London, UK', '2427093444', 'sarahwilson12@gmail.com'); 
INSERT INTO Personal_Info (Personal_Info_ID, Employee_ID, Gender, Date_Of_Birth, Address, Contact_Number, Email) 
VALUES (7, 7, 'Male', TO_DATE('1997-01-25','yyyy-mm-dd'), '123 Main St, Apt 24, Downtown, San Francisco, USA', '8489029880', 'jamestaylor25@gmailcom'); 
INSERT INTO Personal_Info (Personal_Info_ID, Employee_ID, Gender, Date_Of_Birth, Address, Contact_Number, Email) 
VALUES (8, 8, 'Female', TO_DATE('1978-11-08','yyyy-mm-dd'), '456 Oak St, Unit 25, Financial District, San Francisco, USA', '4445256699', 'jennifermartinez08@gmail.com'); 
INSERT INTO Personal_Info (Personal_Info_ID, Employee_ID, Gender, Date_Of_Birth, Address, Contact_Number, Email) 
VALUES (9, 9, 'Male', TO_DATE('1986-04-03','yyyy-mm-dd'), '789 Pine St, Apt 26, Fishermans Wharf, San Francisco, USA', '5556667143', 'robertgarcia03@gmail.com'); 
INSERT INTO Personal_Info (Personal_Info_ID, Employee_ID, Gender, Date_Of_Birth, Address, Contact_Number, Email) 
VALUES (10, 10, 'Female', TO_DATE('1995-12-20','yyyy-mm-dd'), '987 Maple St, Flat 27, Nob Hill, San Francisco, USA', '7278989399', 'jessicalopez20@gmail.com'); 
INSERT INTO Personal_Info (Personal_Info_ID, Employee_ID, Gender, Date_Of_Birth, Address, Contact_Number, Email) 
VALUES (11, 11, 'Male', TO_DATE('1981-07-15','yyyy-mm-dd'), '321 Birch St, Apt 28, Hayes Valley, San Francisco, USA', '3364449555', 'williamhernande15@gmail.com'); 
INSERT INTO Personal_Info (Personal_Info_ID, Employee_ID, Gender, Date_Of_Birth, Address, Contact_Number, Email) 
VALUES (12, 12, 'Female', TO_DATE('1992-09-22','yyyy-mm-dd'), '654 Elm St, Unit 29, Marina District, San Francisco, USA', '1912423633', 'maryyoung22@gmail.com'); 
INSERT INTO Personal_Info (Personal_Info_ID, Employee_ID, Gender, Date_Of_Birth, Address, Contact_Number, Email) 
VALUES (13, 13, 'Male', TO_DATE('1976-06-05','yyyy-mm-dd'), '123 Main St, Apt 30, Downtown, Berlin, Germany', '8882994000', 'matthewking05@gmail.com'); 
INSERT INTO Personal_Info (Personal_Info_ID, Employee_ID, Gender, Date_Of_Birth, Address, Contact_Number, Email) 
VALUES (14, 14, 'Female', TO_DATE('1989-08-17','yyyy-mm-dd'), '456 Oak St, Unit 31, Mitte, Berlin, Germany', '4455586266', 'ashleylee17@gmail.com'); 
INSERT INTO Personal_Info (Personal_Info_ID, Employee_ID, Gender, Date_Of_Birth, Address, Contact_Number, Email) 
VALUES (15, 15, 'Male', TO_DATE('1998-03-28','yyyy-mm-dd'), '789 Pine St, Apt 32, Kreuzberg, Berlin, Germany', '5553664777', 'christopherperez28@gmail.com'); 
INSERT INTO Personal_Info (Personal_Info_ID, Employee_ID, Gender, Date_Of_Birth, Address, Contact_Number, Email) 
VALUES (16, 16, 'Female', TO_DATE('1980-12-12','yyyy-mm-dd'), '987 Maple St, Flat 33, Charlottenburg, Berlin, Germany', '7374880999', 'amandanelson28@gmail.com'); 
INSERT INTO Personal_Info (Personal_Info_ID, Employee_ID, Gender, Date_Of_Birth, Address, Contact_Number, Email) 
VALUES (17, 17, 'Male', TO_DATE('1993-05-25','yyyy-mm-dd'), '321 Birch St, Apt 34, Friedrichshain, Berlin, Germany', '3384495555', 'danielthomas12@gmail.com'); 
INSERT INTO Personal_Info (Personal_Info_ID, Employee_ID, Gender, Date_Of_Birth, Address, Contact_Number, Email) 
VALUES (18, 18, 'Female', TO_DATE('1987-10-03','yyyy-mm-dd'), '654 Elm St, Unit 35, Prenzlauer Berg, Berlin, Germany', '1412237333', 'kimberlywalker03@gmail.com'); 
INSERT INTO Personal_Info (Personal_Info_ID, Employee_ID, Gender, Date_Of_Birth, Address, Contact_Number, Email) 
VALUES (19, 19, 'Male', TO_DATE('1977-02-25','yyyy-mm-dd'), '123 Main St, Apt 36, Downtown, Toronto, Canada', '8877960600', 'kevinhill25@gmail.com'); 
INSERT INTO Personal_Info (Personal_Info_ID, Employee_ID, Gender, Date_Of_Birth, Address, Contact_Number, Email) 
VALUES (20, 20, 'Female', TO_DATE('1990-11-18','yyyy-mm-dd'), '456 Oak St, Unit 37, Yorkville, Toronto, Canada', '4245956696', 'michelleadams18@gmail.com'); 
END; 
  
SELECT * FROM Personal_Info; 
  
DROP TABLE Personal_Info; 
  
--BANK TABLE 
 
CREATE TABLE Bank_Details( 
    Bank_Account_Number NUMBER(30) PRIMARY KEY, 
    Employee_ID NUMBER, 
    Bank_Name VARCHAR2(100), 
    Bank_Code VARCHAR2(20), 
    PF_Account_Number VARCHAR2(20), 
    Constraint fk_bank_dt FOREIGN KEY( Employee_ID) REFERENCES Employees(Employee_ID) 
); 
  
--Bank Table Insertion 
 
BEGIN 
INSERT INTO Bank_Details (Bank_Account_Number, Employee_ID, Bank_Name, Bank_Code, PF_Account_Number) VALUES ('123456789012', 1, 'Bank of America', 'BOFAUS3N', 'NY001234567'); 
INSERT INTO Bank_Details (Bank_Account_Number, Employee_ID, Bank_Name, Bank_Code, PF_Account_Number) VALUES ('234567890123', 2, 'JPMorgan Chase', 'CHASUS33', 'NY002345678'); 
INSERT INTO Bank_Details (Bank_Account_Number, Employee_ID, Bank_Name, Bank_Code, PF_Account_Number) VALUES ('345678901234', 3, 'Barclays', 'BARCGB22', 'LON001234567'); 
INSERT INTO Bank_Details (Bank_Account_Number, Employee_ID, Bank_Name, Bank_Code, PF_Account_Number) VALUES ('456789012345', 4, 'HSBC', 'HSBCGB2L', 'LON002345678'); 
INSERT INTO Bank_Details (Bank_Account_Number, Employee_ID, Bank_Name, Bank_Code, PF_Account_Number) VALUES ('567890123456', 5, 'Lloyds Bank', 'LOYDGB2L', 'LON003456789'); 
INSERT INTO Bank_Details (Bank_Account_Number, Employee_ID, Bank_Name, Bank_Code, PF_Account_Number) VALUES ('678901234567', 6, 'Barclays', 'BARCGB22', 'LON004567890'); 
INSERT INTO Bank_Details (Bank_Account_Number, Employee_ID, Bank_Name, Bank_Code, PF_Account_Number) VALUES ('789012345678', 7, 'Bank of America', 'BOFAUS3N', 'SFO001234567'); 
INSERT INTO Bank_Details (Bank_Account_Number, Employee_ID, Bank_Name, Bank_Code, PF_Account_Number) VALUES ('890123456789', 8, 'JPMorgan Chase', 'CHASUS33', 'SFO002345678'); 
INSERT INTO Bank_Details (Bank_Account_Number, Employee_ID, Bank_Name, Bank_Code, PF_Account_Number) VALUES ('901234567890', 9, 'Bank of America', 'BOFAUS3N', 'SFO003456789'); 
INSERT INTO Bank_Details (Bank_Account_Number, Employee_ID, Bank_Name, Bank_Code, PF_Account_Number) VALUES ('082345678901', 10, 'JPMorgan Chase', 'CHASUS33', 'SFO004567890'); 
INSERT INTO Bank_Details (Bank_Account_Number, Employee_ID, Bank_Name, Bank_Code, PF_Account_Number) VALUES ('294567890123', 11, 'Bank of America', 'BOFAUS3N', 'SFO005678901'); 
INSERT INTO Bank_Details (Bank_Account_Number, Employee_ID, Bank_Name, Bank_Code, PF_Account_Number) VALUES ('395678901234', 12, 'JPMorgan Chase', 'CHASUS33', 'SFO006789012'); 
INSERT INTO Bank_Details (Bank_Account_Number, Employee_ID, Bank_Name, Bank_Code, PF_Account_Number) VALUES ('956789012345', 13, 'Deutsche Bank', 'DEUTDEFF', 'BER001234567'); 
INSERT INTO Bank_Details (Bank_Account_Number, Employee_ID, Bank_Name, Bank_Code, PF_Account_Number) VALUES ('507890123456', 14, 'Commerzbank', 'COMZDEFF', 'BER002345678'); 
INSERT INTO Bank_Details (Bank_Account_Number, Employee_ID, Bank_Name, Bank_Code, PF_Account_Number) VALUES ('778901234567', 15, 'Deutsche Bank', 'DEUTDEFF', 'BER003456789'); 
INSERT INTO Bank_Details (Bank_Account_Number, Employee_ID, Bank_Name, Bank_Code, PF_Account_Number) VALUES ('989012345678', 16, 'Commerzbank', 'COMZDEFF', 'BER004567890'); 
INSERT INTO Bank_Details (Bank_Account_Number, Employee_ID, Bank_Name, Bank_Code, PF_Account_Number) VALUES ('990123456789', 17, 'Deutsche Bank', 'DEUTDEFF', 'BER005678901'); 
INSERT INTO Bank_Details (Bank_Account_Number, Employee_ID, Bank_Name, Bank_Code, PF_Account_Number) VALUES ('861234567890', 18, 'Commerzbank', 'COMZDEFF', 'BER006789012'); 
INSERT INTO Bank_Details (Bank_Account_Number, Employee_ID, Bank_Name, Bank_Code, PF_Account_Number) VALUES ('523456789012', 19, 'Royal Bank of Canada', 'ROYCCAT2', 'TOR001234567'); 
INSERT INTO Bank_Details (Bank_Account_Number, Employee_ID, Bank_Name, Bank_Code, PF_Account_Number) VALUES ('734567890123', 20, 'Toronto-Dominion Bank', 'TDOMCATTTOR', 'TOR002345678'); 
END; 
  
SELECT * FROM Bank_Details; 
  
DROP TABLE Bank_Details; 
 
--Job history table 
 
CREATE TABLE job_history ( 
    job_history_id int  primary key, 
    employee_id INT not null, 
    StartDate DATE not null, 
    EndDate DATE not null, 
    job_id varchar2(100) not null, 
    department_id INT, 
    CONSTRAINT fk_employees FOREIGN KEY (employee_id) REFERENCES employees(employee_id), 
    CONSTRAINT fk_departments FOREIGN KEY (department_id) REFERENCES departments(department_id) 
); 
  
--Job History Sequence 
 
create sequence job_trig   
    start with 1  
    increment by 1; 
 
--Job history Insertion 
 
Create or replace trigger job_history_trigger 
after update  of job_id on employees 
for each row 
declare 
    count1 number; 
    start_date date; 
    max_end_date date; 
begin 
    select count(*) into count1 from job_history where employee_id = :new.employee_id; 
    if(count1!=0) then 
        select max(EndDate) into max_end_date from job_history where employee_id = :new.employee_id; 
        start_date :=max_end_date+INTERVAL '1' DAY; 
    else 
        start_date := :new.hiredate; 
    end if; 
    insert into job_history values(job_trig.nextval, :old.employee_id,start_date,sysdate,:old.job_id,:old.department_id); 
end; 
  
update employees set job_id ='FI_ACCOUNT'   where employee_id =1; 
 
Salary History Table 
 
CREATE TABLE salary_history ( 
    salaryhistory_id NUMBER PRIMARY KEY, 
    employee_id NUMBER NOT NULL, 
    previous_salary NUMBER NOT NULL, 
    new_salary NUMBER NOT NULL, 
    change_date DATE DEFAULT SYSDATE, 
    CONSTRAINT fk_sal_employee FOREIGN KEY (employee_id) REFERENCES employees(employee_id) 
); 
  
Sequence for salary_history 
 
create sequence update_sal_sequence 
start with 1 
increment by 1 
  
select * from salary_history 
--Trigger for salary_history 
  
--Salary History Insertion Trigger 
 
Create or replace Trigger update_sal_history 
before update of salary on employees 
for each row 
Declare 
C number; 
type nes is table of number; 
id nes:=nes(); 
Begin 
    select employee_id bulk collect into id from salary_history where employee_id=:new.employee_id; 
    c:=id.count; 
    if c>0 then 
        update salary_history set previous_salary=:OLD.Salary,new_salary=:New.Salary,change_date=Sysdate where employee_id=:new.employee_id; 
    else 
        Insert into salary_history(salaryhistory_id, employee_id, previous_salary, new_salary, change_date) 
        values (update_sal_sequence.nextval,:NEW.Employee_id, :OLD.Salary, :NEW.Salary,Sysdate);    
    end if; 
end; 
  
select * from employees 
update employees set salary=40000 where employee_id=1; 
