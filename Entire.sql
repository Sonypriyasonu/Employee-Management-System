/*A1. Create a package which includes 
    1.Create a procedure to retrieve Payroll summary of an employee 
    2.Retrieve Bank Details: Create a function that takes an employee ID as input and returns their bank details including account number,  
    bank name, bank code, and PF account number. 
    3. Find Employees by Location: Create a procedure that takes a location ID as input  
    and returns the names of all employees located at that location. 
    4.Create a procedure to retrieve department-wise salary distribution. 
    5.Calculate Annual Leave Balance: Design a procedure that calculates the remaining annual leave balance for an employee. 
    6.Withdraw leave request from leaverequest table and update status as rejected. 
    7.Find Employees by Department: Write a procedure that takes a department ID as input and returns the names of all employees within that department. 
    8. Find Employees with Pending Leave Requests under specified manager. 
*/ 
  
Create or replace package EMS is 
    Procedure payroll(id in employees.employee_id%type,month in number,year in number); 
    Function Retrieve_bank_details(id in employees.employee_id%type) return varchar2; 
    Procedure emps_in_location(l in Departments.location_id%type); 
    Procedure dept_tot_sal; 
    procedure Annual_leave_balance(e_id employees.employee_id%type); 
    procedure  withdraw_leaverequest(e_id employees.employee_id%type ); 
    procedure emps_in_department(d_id departments.department_id%type); 
    procedure pending_leave_requests(m_id employees.employee_id%type); 
end; 
  
drop package ems 
select TRUNC(MONTHS_BETWEEN(SYSDATE,HIREDATE)/12) from employees 
  
Create or replace package body EMS is 
  
    --1. Create a procedure to retrieve Payroll summary of an employee 
    Procedure payroll(id in employees.employee_id%type,month in number,year in number) is 
        n employees.name%type; 
        hr_rate employees.hourly_rate%type; 
        hrs_w employees.hours_worked%type; 
        hire_date employees.hiredate%type; 
        sal employees.salary%type; 
        comm employees.commission%type; 
        b_ac bank_details.bank_account_number%type; 
        b_name bank_details.bank_name%type; 
        pf bank_details.pf_account_number%type; 
        dob personal_info.date_of_birth%type; 
        dept_n departments.department_name%type; 
        tot number; 
        pf_cut number; 
        bonus number; 
        tax number; 
        deductions number; 
        lop number; 
        lop1 number; 
        further exception; 
    begin 
        select e.name,e.hourly_rate,e.hours_worked,e.hiredate,e.salary,nvl(e.commission,0),b.bank_account_number,b.bank_name,b.pf_account_number,p.date_of_birth,d.department_name 
               into n,hr_rate,hrs_w,hire_date,sal,comm,b_ac,b_name,pf,dob,dept_n       
               from employees e  
               join bank_details b on b.employee_id=e.employee_id 
               join personal_info p on p.employee_id=e.employee_id 
               join departments d on d.department_id=e.department_id 
               where e.employee_id=id; 
        select count(*) into lop from attendance where status='lop' and extract(month from attendance_date) = month  
                                                                    and extract(year from attendance_date) = year  
                                                                    and employee_id=id; 
        if(extract(month from sysdate)<= month or extract(year from sysdate)< year) then 
            raise further; 
        end if;                                                          
        lop1:=lop*hr_rate*9; 
        pf_cut:=sal*0.05;  --0.5 percent from sal 
        tax:=sal*0.005; --0.05 percent from sal 
        bonus:=case when TRUNC(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12)>15 then 2000 
                    when TRUNC(MONTHS_BETWEEN(SYSDATE,HIRE_DATE)/12)>=10 then 1000 
                    else 500 end; 
        tot:=sal+comm+bonus; 
        deductions:=tax+pf_cut+lop1; 
        dbms_output.put_line('--------------------------------------  '||CHR(10)|| 
                             '            Employee Details     '||CHR(10)|| 
                             '--------------------------------------  '||CHR(10)|| 
                             ' Employee Name       : '||n||CHR(10)|| 
                             ' Date of Birth       : '||dob||CHR(10)|| 
                             ' Date of Joining     : '||hire_date||CHR(10)|| 
                             ' Hours Worked per day: '||hrs_w||CHR(10)|| 
                             '--------------------------------------'||CHR(10)|| 
                             '               Bank Details'||CHR(10)|| 
                             '--------------------------------------'||CHR(10)|| 
                             ' Bank Account Number : '||b_ac||CHR(10)|| 
                             ' Bank Name           : '||b_name||CHR(10)|| 
                             ' PF Account Number   : '||pf||CHR(10)|| 
                             '--------------------------------------'||CHR(10)|| 
                             '               Earnings'||CHR(10)|| 
                             '--------------------------------------'||CHR(10)||                             
                             ' Hourly Rate         : '||hr_rate||CHR(10)|| 
                             ' Salary              : '||sal||CHR(10)|| 
                             ' Commission          : '||comm||CHR(10)|| 
                             ' Bonus               : '||bonus||CHR(10)|| 
                             ' Total Earning       : '||tot||CHR(10)|| 
                             '--------------------------------------'||CHR(10)|| 
                             '               Deductions   '||CHR(10)|| 
                             '--------------------------------------'||CHR(10)||    
                             ' PF Deduction        : '||pf_cut||CHR(10)|| 
                             ' Tax Deduction       : '||tax||CHR(10)|| 
                             ' LOP Days            : '||lop||CHR(10)||                              
                             ' Loss of Pay         : '||lop1||CHR(10)|| 
                             ' Total Deductions    : '||deductions||CHR(10)|| 
                             '--------------------------------------'||CHR(10)|| 
                             'Total Salary         : '||to_char(tot-deductions)); 
    Exception 
        when no_data_found then 
            dbms_output.put_line('Employee not found'); 
        when further then 
            dbms_output.put_line('The year or month is either ongoing or not yet finished.'); 
        when others then 
            dbms_output.put_line('Error occured'||sqlerrm); 
    end; 
  
    --2. Create a function that takes an employee ID as input and returns their bank details 
    Function Retrieve_bank_details(id in employees.employee_id%type) return varchar2 
    is 
        Details Varchar2(400); 
        b_act_no Bank_details.bank_account_number%type; 
        b_name Bank_details.bank_name%type; 
        b_code bank_details.bank_code%type; 
        Pf_no Bank_details.pf_account_number%type; 
    Begin 
        select bank_account_number,bank_name,bank_code,pf_account_number into b_act_no,b_name,b_code,Pf_no from bank_details where employee_id=id; 
        details:='Bank Account Number: '||to_char(b_act_no)||CHR(10)|| 
                  'Bank Name         : '||b_name||CHR(10)|| 
                  'Bank Code         : '||to_char(b_code)||CHR(10)|| 
                  'PF Number         : '||to_char(Pf_no); 
        return details; 
    Exception 
        when no_data_found then 
            return 'No bank details found for employee ID: ' || to_char(id);       
    end; 
  
    --3. Create procedure to Find Employees by Location. 
    Procedure emps_in_location(l in Departments.location_id%type)  
    is 
        Location_found boolean:=false; 
        Employee_found boolean:=false; 
        c number; 
        location_not_found exception; 
        Employee_not_found exception; 
    Begin 
        select count(*) into c from location where location_id=l; 
        if c>0 then 
            location_found:=true; 
        end if; 
        if location_found then 
            for i in (select e.* from employees e join departments d on e.department_id=d.department_id where d.location_id=l) 
            loop 
                employee_found:=true; 
                dbms_output.put_line('ID: '||i.employee_id||CHR(10)|| 
                                    'Name: '||i.name||CHR(10)|| 
                                    'Salary: '||i.salary); 
            end loop; 
            If not employee_found then 
                raise employee_not_found; 
            end if; 
        else 
          raise location_not_found; 
        end if; 
    Exception 
        when location_not_found then 
            dbms_output.put_line('Location not found'); 
        when employee_not_found then 
            dbms_output.put_line('No Employee found in that location'); 
    end; 
  
    --4. Create a procedure to retrieve department-wise salary distribution. 
    Procedure dept_tot_sal is 
        sal employees.salary%type; 
    begin 
        for i in (select distinct d.Department_name as dept,sum(e.salary) over(partition by d.department_name) as sal  
                  from employees e  
                  join departments d  
                  on d.department_id=e.department_id ) 
        loop    
            dbms_output.put_line('Department_name: '||i.dept||' Total Salary: '||i.sal); 
        end loop; 
    end; 
  
    --5. Calculate Annual Leave Balance: Design a procedure that calculates the remaining annual leave balance for an employee.     
    procedure Annual_leave_balance(e_id employees.employee_id%type) 
        is 
            Earned_leaves number; 
            sick_leaves number; 
            tot number; 
        begin 
            select sum(case when leave_type='Earned' then no_of_leaves else 0 end), 
                   sum(case when leave_type='sick' then no_of_leaves else 0 end) into Earned_leaves,sick_leaves 
            from leaverequests where employee_id=e_id and extract(year from startdate)=extract(year from sysdate) and status='Approved' group by employee_id; 
            Dbms_output.put_line('Earned Leave balance: '||to_char(11-Earned_leaves)||' Leaves left'); 
            Dbms_output.put_line('Sick Leave balance: '||to_char(6-sick_leaves)||' Leaves left'); 
    end; 
  
    --6. Withdraw leave request from leaverequest table and update status as rejected. 
    procedure  withdraw_leaverequest(e_id employees.employee_id%type ) 
    is 
        r_id leaverequests.request_id%type; 
        status leaverequests.status%type; 
    begin 
        select request_id,status into r_id,status from leaverequests where enddate=(select max(enddate) from leaverequests where employee_id=e_id); 
        if status='Approved' then 
            dbms_output.put_line('Ooops!😧 Leave request has already been approved.'); 
        elsif status='Rejected' then 
            dbms_output.put_line('Leave request has been rejected or withdrawn.'); 
        elsif status='Pending' then 
            update leaverequests set status='Rejected' where request_id=r_id; 
            dbms_output.put_line('Leave has been withdrawn successfully! 😊'); 
        end if; 
    Exception 
        when no_data_found then 
            dbms_output.put_line('leave request not found'); 
        when others then 
            dbms_output.put_line('Error occured'||sqlerrm); 
    end; 
  
    --7. Find Employees by Department: Write a procedure that takes a department ID as input and returns the names of all employees within that department. 
    procedure emps_in_department(d_id departments.department_id%type) 
    is 
        d number; 
        e number; 
        employee_not_found exception; 
        department_not_found exception; 
    begin 
        select count(*) into d from departments where department_id=d_id; 
        select count(*) into e from employees where department_id=d_id; 
        if d>0 then 
            if e>0 then 
                dbms_output.put_line('ID   Name'||CHR(10)||'--   ----'); 
                for i in (select employee_id,name from employees where department_id=d_id) 
                loop 
                    dbms_output.put_line(i.employee_id||'   '||i.name); 
                end loop; 
            else 
                raise employee_not_found; 
            end if; 
        else 
            raise department_not_found; 
        end if; 
    exception 
        when employee_not_found then 
            dbms_output.put_line('Employee not found in that department'); 
        when department_not_found then 
            dbms_output.put_line('Department not found');    
    end; 
  
    --8. Find Employees with Pending Leave Requests under specified manager. 
    procedure pending_leave_requests(m_id employees.employee_id%type) 
    is 
        c number; 
    begin 
        select count(*) into c from leaverequests where employee_id in (select employee_id from employees where manager_id=m_id) and status='Pending'; 
        if c>0 then 
            dbms_output.put_line('Request_id   Employee_id   Start_date     End_date       leave_type      No_of_leaves   Status'||CHR(10)|| 
                                 '----------   -----------   ----------     --------       ----------      ------------   ------'); 
            for i in (select * from leaverequests where employee_id in (select employee_id from employees where manager_id=m_id) and status='Pending') 
            loop 
                dbms_output.put_line(LPAD(i.request_id, 2) || LPAD(i.employee_id, 13) || LPAD(i.startdate, 22) || 
                LPAD(i.enddate, 14) || LPAD(i.leave_type, 16) || LPAD(i.no_of_leaves, 8) || LPAD(i.status, 21)); 
            end loop; 
            dbms_output.put_line(CHR(10)||'Total pending leave requests: ' ||c); 
        else 
            dbms_output.put_line('No pending leave requests found'); 
        end if; 
    end; 
end; 
  
begin 
    ems.payroll(14,2,2024); 
end; 
  
begin 
    dbms_output.put_line(ems.Retrieve_bank_details(1)); 
end; 
  
begin 
    ems.emps_in_location(5); 
end; 
  
begin 
    ems.dept_tot_sal(); 
end; 
  
begin 
    ems.Annual_leave_balance(1); 
end;  
  
Begin 
    ems.withdraw_leaverequest(14); 
end; 
  
begin 
    ems.emps_in_department(101); 
end; 
  
begin 
    ems.pending_leave_requests(12); 
end; 
 
/*A2. Calculate Overtime Pay: Create a function that calculates the overtime pay for a given employee ID based on their hourly rate and hours worked (assuming overtime starts after 45 hours in a week).*/ 
  
Create or replace function overtime_pay(e_id employees.employee_id%type,first_date date,last_date date) return number 
is 
    pay number; 
    hours_worked number; 
    min_hrs number:=45; 
    extra_hrs number; 
    hr_rate employees.hourly_rate%type; 
begin 
    select hourly_rate into hr_rate from employees where employee_id=e_id; 
    select sum((extract(hour from check_out)-extract(hour from check_in))) into hours_worked 
            from attendance  
            where attendance_date >= first_date 
            and attendance_date <= last_date and employee_id=e_id 
            group by employee_id; 
    extra_hrs:=case when (min_hrs-hours_worked)<0 then abs(min_hrs-hours_worked) else 0 end; 
    pay:=hr_rate*extra_hrs; 
    return pay; 
end; 
  
begin 
 dbms_output.put_line('Overtime pay is '||overtime_pay(3,to_date('2024-06-03','yyyy-mm-dd'),to_date('2024-06-09', 'yyyy-mm-dd'))||' rupees'); 
end; 
  
select * from leaverequests 
update leaverequests set status='Pending' where employee_id=14; 
 
--A3. Create backup table for employee and insert data into back up table whenever employee table is updated or deleted 
  
CREATE TABLE backup_employees ( 
    Backup_id number primary key, 
    employee_id NUMBER, 
    name VARCHAR2(100) not null, 
    department_id NUMBER , 
    hourly_rate NUMBER , 
    hours_worked NUMBER, 
    salary NUMBER not null, 
    hiredate DATE not null, 
    manager_id NUMBER, 
    commission NUMBER, 
    job_id VARCHAR2(100) not null, 
    operation VARCHAR2(10), 
    backup_time TIMESTAMP, 
    backup_user VARCHAR2(30) 
); 
drop table backup_employees 
select * from backup_employees 
  
create sequence backup_emp 
start with 1  
increment by 1; 
  
Create or replace trigger insert_into_backup_emp 
before update or delete on employees 
for each row 
begin 
    if deleting then 
        insert into backup_employees (backup_id,employee_id, name, department_id, hourly_rate, hours_worked, salary, hiredate,  
                                      manager_id, commission, job_id, operation, backup_time, backup_user) VALUES  
                                      (backup_emp.nextval,:OLD.employee_id,:OLD.name,:OLD.department_id,:OLD.hourly_rate,:OLD.hours_worked,:OLD.salary,:OLD.hiredate, 
                                      :OLD.manager_id,:OLD.commission,:OLD.job_id,'DELETE',SYSTIMESTAMP,USER); 
    elsif updating then 
        insert into backup_employees (backup_id,employee_id, name, department_id, hourly_rate, hours_worked, salary, hiredate,  
                                      manager_id, commission, job_id, operation, backup_time, backup_user) VALUES  
                                      (backup_emp.nextval,:OLD.employee_id,:OLD.name,:OLD.department_id,:OLD.hourly_rate,:OLD.hours_worked,:OLD.salary,:OLD.hiredate, 
                                      :OLD.manager_id,:OLD.commission,:OLD.job_id,'UPDATE',SYSTIMESTAMP,USER);   
    end if; 
end; 
  
update employees set salary=39000 where employee_id=1; 
  
update employees set salary=(select salary from backup_employees where backup_id=1) where employee_id=1; 
select * from employees 
 
--B1)Allow managers to approve leave requests and track attendance.  
--B2)Implement role-based access control for sensitive employee data. 
Creating Package : 
 
create or replace package psa is  
type rec is table of varchar2(100) index by varchar2(100); 
type leave_row is table of leaverequests%rowtype; 
procedure check_out(emp_id number); 
procedure check_in(emp_id number); --completed 
procedure attendance_tracking(emp_id number);  --completed 
function total_leaves_emp (emp_id number)return rec; --completed 
procedure leave_request (emp_id IN NUMBER, e_leave_type IN VARCHAR2, e_no_of_leaves IN NUMBER, start_date IN DATE, end_date IN DATE) ; 
procedure manager_leave_request (leave_id number,emp_id number,man_id number);  --completed 
procedure update_employee_info(updated_person_id in number , 
    e_employee_id in number, 
    e_department_id in number , 
    e_job_id in varchar2, 
    e_salary in number, 
    e_commission in number); 
procedure  all_employee_attendance_tracking(mana_id in number); --completed  
end ; 
  
drop package psa 
  
create or replace package body psa is 
  
--procedure for check_out 
procedure check_out (emp_id number) is 
    begin 
    update attendance set check_out = systimestamp where employee_id =emp_id and check_out is null; 
    end; 
  
--procedure for check_in 
procedure check_in(emp_id number) is 
    id number; 
    begin 
    select count(attendance_id) into id from attendance ; 
    id:=id+1; 
    insert into attendance (attendance_id,employee_id,attendance_date,check_in) values(id,emp_id,sysdate,systimestamp); 
end; 
  
--attendance traking 
create or replace procedure attendance_tracking (emp_id number,r_month in number default null, r_year in number default null) is 
    emp_row employees%rowtype; 
    type full_rec is table of attendance%rowtype; 
    full_record full_rec; 
    phone_number personal_info.contact_number%type; 
    emp_email varchar2(100); 
    count1 number; 
    time_difference interval day to second; 
    hours number; 
    minutes number; 
    seconds number; 
    current_year number; 
    begin  
    select * into emp_row from employees where employee_id = emp_id; 
    select contact_number,email into phone_number,emp_email from personal_info where employee_id = emp_id; 
    dbms_output.put_line('                             Attendance details                       '); 
    dbms_output.put_line('Employee id    :  '||emp_row.employee_id); 
    dbms_output.put_line('Name           :  '||emp_row.name); 
    dbms_output.put_line('Phone number   :  '||phone_number); 
    dbms_output.put_line('Email          :  '||emp_email); 
    dbms_output.put_line('Manager id     :  '||emp_row.manager_id); 
    dbms_output.put_line(' '); 
    --dbms_output.put_line('id   Attendance_date     check_in          check_out     Total_time'); 
    count1:=1; 
    if(r_month is null and r_year is null) then  
    select * bulk collect into full_record from attendance where employee_id = emp_id; 
    elsif(r_month is null and r_year is not null) then 
    select * bulk collect into full_record from  attendance where employee_id = emp_id and extract(year from check_in)= r_year; 
    elsif(r_month is not null and r_year is null) then 
    --current_year := extract(year from sysdate); 
    select * bulk collect into full_record from attendance where employee_id = emp_id and extract(year from check_in)=current_year and extract(month from check_in)=r_month; 
    else 
        select * bulk collect into full_record from attendance where employee_id = emp_id and extract(year from check_in)=r_year and extract(month from check_in)=r_month; 
    end if; 
    if(full_record.count!=0) then 
    dbms_output.put_line('id   Attendance_date     check_in          check_out     Total_time'); 
    end if; 
  
    for i in full_record.first .. full_record.last  
    loop 
    dbms_output.put(count1||'   '); 
    dbms_output.put(full_record (i).attendance_date||'            '); 
    dbms_output.put(to_char(full_record (i).check_in,'HH:MI:SS AM')||'     '); 
    DBMS_OUTPUT.PUT(TO_CHAR(full_record (i).CHECK_OUT,'hh:mi:ss am')||'     '); 
    time_difference :=full_record (i).check_out-full_record (i).check_in; 
    hours := EXTRACT(HOUR FROM time_difference); 
    minutes := EXTRACT(MINUTE FROM time_difference); 
    seconds := EXTRACT(SECOND FROM time_difference); 
    dbms_output.put_line(hours||' : '||minutes||' : '||seconds); 
    dbms_output.put_line(' '); 
    count1:=count1+1; 
    end loop; 
    exception 
    when no_data_found then 
        dbms_output.put_line('employee with id ' || emp_id || ' not found.'); 
    when value_error then 
        dbms_output.put_line('no attendance in  that month or year'); 
    when others then 
        dbms_output.put_line('an error occurred: ' || sqlerrm); 
    end; 
  
  
FUNCTION total_leaves_emp(emp_id IN NUMBER, start_year in date, end_year in date) RETURN rec IS 
    TYPE leave_row IS TABLE OF leaverequests%ROWTYPE; 
    d1 leave_row; 
    list1 rec; 
    sum1 number; 
    max_end_date DATE; 
  
BEGIN 
    SELECT * BULK COLLECT INTO d1 FROM leaverequests WHERE employee_id = emp_id; 
    for i in 1 .. d1.count 
    loop 
        if d1(i).startdate>= start_year and d1(i).enddate<=end_year then 
         null; 
        else 
        d1.delete(i); 
        end if; 
  
    end loop; 
  
    max_end_date := NULL; 
  
    FOR i IN 1..d1.COUNT LOOP 
        IF d1(i).leave_type = 'sick' and d1(i).status = 'Approved' THEN 
        if(list1.exists(d1(i).leave_type)) then  
            sum1:=to_number(list1(d1(i).leave_type))+d1(i).no_of_leaves; 
            list1(d1(i).leave_type) :=to_char(sum1); 
            else 
               list1(d1(i).leave_type) := to_char(d1(i).no_of_leaves); 
            end if; 
                --dbms_output.put_line('sick'); 
                IF max_end_date IS NULL OR d1(i).enddate > max_end_date THEN 
                    max_end_date := d1(i).enddate; 
                END IF; 
        ELSIF d1(i).leave_type = 'Earned' and  d1(i).status = 'Approved' THEN 
            if(list1.exists(d1(i).leave_type)) then  
            sum1:=to_number(list1(d1(i).leave_type))+d1(i).no_of_leaves; 
            list1(d1(i).leave_type) :=to_char(sum1); 
            else 
               list1(d1(i).leave_type) := to_char(d1(i).no_of_leaves); 
            end if; 
                --dbms_output.put_line('earned'); 
        ELSE 
            IF d1(i).status = 'Approved' THEN 
               if(list1.exists(d1(i).leave_type)) then  
            sum1:=to_number(list1(d1(i).leave_type))+d1(i).no_of_leaves; 
            list1(d1(i).leave_type) :=to_char(sum1); 
            else 
               list1(d1(i).leave_type) := to_char(d1(i).no_of_leaves); 
            end if; 
               dbms_output.put_line('otherleaves'); 
            END IF; 
        END IF; 
    END LOOP; 
  
    list1('max_end_date') := TO_CHAR(max_end_date, 'DD-MM-YYYY'); 
    RETURN list1; 
END; 
  
-- apply leave request by employee 
PROCEDURE leave_request(emp_id IN NUMBER, e_leave_type IN VARCHAR2, e_no_of_leaves IN NUMBER, start_date IN DATE, end_date IN DATE) IS 
    total_leaves NUMBER; 
    leave_list rec; 
    date_diff NUMBER; 
    total_sick_leaves NUMBER := 6; 
    total_earned_leaves NUMBER := 11; 
    id1 NUMBER; 
    diff number; 
    y varchar2(100); 
    request_cancel EXCEPTION; 
    no_enough EXCEPTION; 
BEGIN 
    SELECT COUNT(request_id) INTO id1 FROM leaverequests ; 
    id1 := id1 + 1; 
    leave_list := total_leaves_emp(emp_id);  
    y :=leave_list.first; 
    while y is not null loop 
    dbms_output.put_line(y||'  '||leave_list(y)); 
    y:=leave_list.next(y); 
    end loop; 
    IF e_leave_type = 'sick' THEN 
        date_diff := end_date - start_date; 
        IF date_diff > 1  THEN  
            RAISE request_cancel; 
        elsif leave_list.EXISTS('sick') then  
            diff:= start_date-to_date(leave_list('max_end_date'),'dd-mm-yyyy'); 
            IF total_sick_leaves - leave_list('sick') = 0  THEN 
            RAISE no_enough; 
            elsif diff = 1 then 
                raise request_cancel; 
            else 
            INSERT INTO leaverequests(request_id, employee_id, startdate, enddate, leave_type, no_of_leaves)  
            VALUES(id1, emp_id, start_date, end_date, e_leave_type, e_no_of_leaves); 
            end if; 
        ELSE 
            INSERT INTO leaverequests(request_id, employee_id, startdate, enddate, leave_type, no_of_leaves)  
            VALUES(id1, emp_id, start_date, end_date, e_leave_type, e_no_of_leaves); 
        END IF; 
    ELSIF e_leave_type = 'Earned' THEN 
        date_diff := end_date - start_date; 
        if leave_list.EXISTS('Earned') then  
          IF total_earned_leaves - leave_list('Earned') <= 0 THEN  
            RAISE no_enough; 
          else 
          INSERT INTO leaverequests(request_id, employee_id, startdate, enddate, leave_type, no_of_leaves)  
            VALUES(id1, emp_id, start_date, end_date, e_leave_type, e_no_of_leaves); 
          end if; 
        ELSE 
            INSERT INTO leaverequests(request_id, employee_id, startdate, enddate, leave_type, no_of_leaves)  
            VALUES(id1, emp_id, start_date, end_date, e_leave_type, e_no_of_leaves); 
        END IF; 
    ELSE 
        INSERT INTO leaverequests(request_id, employee_id, startdate, enddate, leave_type, no_of_leaves)  
        VALUES(id1, emp_id, start_date, end_date, e_leave_type, e_no_of_leaves); 
    END IF; 
  
EXCEPTION 
    WHEN request_cancel THEN 
        DBMS_OUTPUT.PUT_LINE('You should not take Sick leaves simultaneous days'); 
    WHEN no_enough THEN 
        DBMS_OUTPUT.PUT_LINE('earned leaves or sick are completed '); 
END leave_request; 
  
--allowing manager to approve leave request 
procedure manager_leave_request(leave_id number,emp_id number,man_id number)  is 
    m_id number; 
    not_manager exception; 
    begin 
    select manager_id into m_id from employees where employee_id = emp_id; 
    if(m_id != man_id) then 
    raise not_manager; 
    else 
    update leaverequests set status = 'Approved' where request_id = leave_id; 
    dbms_output.put_line('Leave request is approved by '||m_id); 
    end if; 
exception 
WHEN not_manager then 
    dbms_output.put_line('Manager is not authorized to approve leave requests'); 
when others then 
    dbms_output.put_line(sqlerrm); 
end; 
  
  
--procedure for update employee _ info by hr 
    procedure update_employee_info(updator_id in number , 
    e_employee_id in number, 
    e_department_id in number , 
    e_job_id in varchar2, 
    e_salary in number, 
    e_commission in number) 
 
    d_id number; 
    cannot_update exception; 
    begin 
    select department_id into d_id from employees where employee_id = updator_id; 
    if(d_id = 101 ) then 
    update employees set  department_id = e_department_id, job_id = e_job_id, salary = e_salary,commission = e_commission where employee_id = e_employee_id; 
    else 
    raise cannot_update; 
end if; 
exception 
    when cannot_update then  
        dbms_output.put_line('only hr can update'); 
    when others then  
        dbms_output.put_line('error occured: '||sqlerrm); 
end; 
  
--attendance tracking can see only own manager 
procedure  all_employee_attendance_tracking(mana_id in number) 
    is 
    type lists is table of number; 
    emp_list lists; 
    begin 
    select employee_id bulk collect into emp_list from employees where manager_id = mana_id; 
    for i in 1..emp_list.count  
    loop 
    attendance_tracking(emp_list(i)); 
    dbms_output.put_line('_________________________************************_____________________________'); 
    end loop; 
    if(emp_list.count = 0) then 
    dbms_output.put_line('No employee under this manager'); 
    end if; 
    end; 
  
--trigger for manager leave requests 
create or replace  trigger leave_request_trig 
after insert on leaverequests 
for each row 
declare 
m_id number; 
begin 
select manager_id into m_id from employees where employee_id =:new.employee_id; 
manager_leave_request(:new.request_id,:new.employee_id,m_id); 
end; 
  
end psa; 
 
--testing 
--calling attendance tracking 
begin 
psa. attendance_tracking(2); 
end; 
  
--calling all_employee_attendance_tracking for particular manager  
begin 
psa. all_employee_attendance_tracking(7); 
end; 
 
--calling procedure to apply leave 
begin 
psa.leave_request (4, 'Earned', 1, to_date('07-06-2024','dd-mm-yyyy'),to_date('07-06-2024','dd-mm-yyyy') ) ; 
end; 
  
begin 
psa.leave_request (7, 'sick', 1, to_date('07-06-2024','dd-mm-yyyy'),to_date('07-06-2024','dd-mm-yyyy') ) ; 
end; 
  
--calling procedures for  manager to approve leave request 
begin 
psa. manager_leave_request(12,7,12); 
end; 
  
begin 
psa.leave_request (7, 'sick', 1, to_date('08-06-2024','dd-mm-yyyy'),to_date('08-06-2024','dd-mm-yyyy') ) ; 
end; 
 
 --calling procedure for check_in by employee 
begin 
Aps.check_in(1); 
end; 
 
--procedure to insert new job 
 
 begin 
 exception 
         dbms_output.put_line('already present'); 
         dbms_output.put_line('error occured : '||sqlerrm); 

 new_job('AD_PRES','President'); 



 create or replace procedure new_department(dep_name in departments.department_name%type,dep_manager_id in number, dep_location_id in number) is 
 begin 
 d_id:=d_id+1; 
 exception 
         dbms_output.put_line('already present'); 
         dbms_output.put_line('error occured : '||sqlerrm); 



 create or replace procedure new_location(new_street_address in location.street_address%type,new_postal_code in location.postal_code%type,new_city in location.city%type,new_country_name in location.country_name%type,new_region in location.region%type) is 
 begin 
 loc_id:=loc_id+1; 
 exception 
         dbms_output.put_line('already present'); 
         dbms_output.put_line('error occured : '||sqlerrm); 



 create or replace procedure update_employee_department(p_employee_id in employees.employee_id%type,p_new_department_id in employees.department_id%type)  
     v_previous_department_id employees.department_id%type; 
     v_new_department_name departments.department_name%type; 
 begin 
     into v_previous_department_id,v_employeename,v_previous_department_name 

     set department_id = p_new_department_id 

     into v_new_department_name 
     where department_id = p_new_department_id; 
    dbms_output.put_line('employee id: ' || p_employee_id ||chr(10)||'Employee name: '||v_employeename||chr(10)||'previous department id: ' || v_previous_department_id ||chr(10)||'previous_department name:  '||v_previous_department_name||chr(10)|| 'new department id: ' || p_new_department_id||chr(10)||'new departmentname: '||v_new_department_name); 
 exception 
         dbms_output.put_line('employee with id ' || p_employee_id || ' not found.'); 
         dbms_output.put_line('an error occurred: ' || sqlerrm); 
 
select * from employees order by employee_id 
begin 
 end; 
--C2. Finding employees who works on weekends (taking specific month)     
create or replace procedure find_weekend_workers is 
  cursor weekend_cursor  
   is 
 select e.employee_id, e.name, a.attendance_date, to_char(a.attendance_date, 'dy', 	 'nls_date_language=english') as day_name 
        from attendance a 
        join employees e on a.employee_id = e.employee_id  
        where extract(month from a.attendance_date) = 6 --8 no emps    
          and to_char(a.attendance_date, 'dy', 'nls_date_language=english') in ('sat', 'sun') order by      e.employee_id; 
    v_records_found boolean := false; 
begin 
    for i in weekend_cursor  
   loop 
      v_records_found := true; 
       dbms_output.put_line('employee id: ' || rpad(i.employee_id, 20) || ' name: ' || rpad(i.name, 20) || '           	attendance date: ' || to_char(i.attendance_date, 'yyyy-mm-dd') ||  
                             ' day: ' || (case when i.day_name = 'sat' then 'saturday'  
                                                when i.day_name = 'sun' then 'sunday'  
                                                else 'unknown' end)); 
 end loop;   
    if not v_records_found then 
        dbms_output.put_line('no employees worked on weekends in this month.'); 
    end if; 
end; 
/ 
--outputs:employee_id ,attendance date 
Begin 
find_weekend_workers; 
end; 
/ 
 --C3. Find employees who do not have bank details registered. 
Create or replace procedure employees_without_bank_details is 
 begin 
     into v_count from employees e 
     where b.employee_id is null; 
        dbms_output.put_line('all employees have bank details.'); 
         for rec in (select e.employee_id, e.name from employees e 
             where b.employee_id is null  )  
        loop 
         end loop; 
 end; 

     employees_without_bank_details; 
end; 


 select * from employees; 
 INSERT INTO Bank_Details (Bank_Account_Number, Employee_ID,Bank_Name, Bank_Code, PF_Account_Number) VALUES ('789012345678', 7, 'Bank of America', 'BOFAUS3N', 'SFO001234567'); 
--C4. Employees who choose which bank and number of employees choosen each bank. 
Create or replace function total_employees_inthat_bank return sys_refcursor  
Is 
v_result sys_refcursor; 
Begin 
open v_result for 
select bank_name,count(employee_id) as total_employees from bank_details  group by bank_name; 
return v_result; 
end; 
/ 
-- outputting part: bank name,employee names ,total employees opeted that bank. 
declare 
    v_cursor sys_refcursor; 
    v_bank_name bank_details.bank_name%type; 
    v_total_employees number; 
begin 
    v_cursor := total_employees_inthat_bank; 
     
    loop 
        fetch v_cursor into v_bank_name, v_total_employees; 
        exit when v_cursor%notfound; 
 
        dbms_output.put_line('bank name: ' || rpad(v_bank_name, 30) || 'total employees: ' || v_total_employees); 
        dbms_output.put_line('--------------------------'); 
  
        for i in (select e.name from bank_details bd join employees e on bd.employee_id = e.employee_id where bd.bank_name = v_bank_name) 
        loop 
            dbms_output.put_line('  employee: ' || i.name); 
            end loop; 
            dbms_output.put_line(' '); 
    end loop;  
    close v_cursor; 
end; 
/ 
--D1. Create a procedure to insert new employee to the employee table  
  
------ADDING-------- 
     e_name IN VARCHAR2, 
     e_salary IN NUMBER, 
     e_commission IN NUMBER, 
     e_date_of_birth in  date, 
     e_contact_number in  number, 
     e_gender in varchar2, 
     e_bank_account_number in number , 
     e_pf_account_number in varchar2 
 id number; 
 Count1 Number; 
 SELECT count(email) INTO Count1 from personal_info where email = e_email; 
 raise DUP_VAL_ON_INDEX; 
 -----EMPLOYEES------------ 
 id:=id+1; 
 (id,e_name,e_department_id,e_salary,sysdate,e_manager_id ,e_commission,e_job_id); 
 p_id:=0; 
 p_id :=p_id+1; 
 (p_id,id,e_gender,e_date_of_birth,e_address,e_contact_number,e_email); 
 insert into bank_details(bank_name,employee_id,bank_account_number,bank_code,pf_account_number) values 
 EXCEPTION 
             -- Unique Constraint Violation 
         WHEN NO_DATA_FOUND THEN 
         WHEN OTHERS THEN 
 end; 
-----TESTING------ 
     insert_new_employeee_info('Lavanya ',103,7000,10,NULL,'AD_VP',TO_DATE('12-01-2002','DD-MM-YYYY'),'Gachibowli,Hyderabad',8464949476,'lavanya@gmail.com','Female', 
 END; 
------------------------------ 
 select * from personal_info order by employee_id; 





     e_employee_id in number, 
 ) 
 cannot_update exception; 
 BEGIN 
 SELECT employee_id into emp_id from employees where employee_id = e_employee_id; 
 raise cannot_update; 
     UPDATE employees 
     WHERE employee_id = e_employee_id; 
     WHEN NO_DATA_FOUND THEN 
     when cannot_update then 
     WHEN OTHERS THEN 
 END Update_Employee_Name; 
---------TESTING----------------- 
     Update_Employee_Name(21,21,'Lavanya N'); 
 ------------------ 

 CREATE OR REPLACE PROCEDURE Update_Employee_Address( 
     e_employee_id in number, 
 ) 
 cannot_update exception; 
 BEGIN 
 SELECT employee_id into emp_id from employees where employee_id = e_employee_id; 
 raise cannot_update; 
     UPDATE personal_info 
     WHERE employee_id = e_employee_id; 
     WHEN NO_DATA_FOUND THEN 
     when cannot_update then 
     WHEN OTHERS THEN 
 END Update_Employee_Address; 
------TESTING--------- 
     Update_Employee_Address(21,21,'Hitech City,Hyderabad'); 

 SELECT * FROM PERSONAL_INFO Order By employee_id; 
-------------------------------------------------------------------------- 
     updater_id in number, 
     e_contact_number in  number 
 IS 
 emp_id number; 
     SELECT employee_id into emp_id from employees where employee_id = updater_id; 
 if(updater_id != e_employee_id ) then  
 end if; 
     SET contact_number = e_contact_number 
 EXCEPTION 
         RAISE_APPLICATION_ERROR(-20001, 'Employee does not exist.'); 
         dbms_output.put_line('No permission allowed'); 
         RAISE_APPLICATION_ERROR(-20006, 'An error occurred: ' || SQLERRM); 

 BEGIN 
 END; 
------------------------- 


     updater_id in number, 
     e_email in varchar2 
 IS 
 emp_id number; 
     SELECT employee_id into emp_id from employees where employee_id = updater_id; 
 if(updater_id != e_employee_id ) then  
 end if; 
     SET email = e_email 
 EXCEPTION 
         RAISE_APPLICATION_ERROR(-20001, 'Employee does not exist.'); 
         dbms_output.put_line('No permission allowed'); 
         RAISE_APPLICATION_ERROR(-20006, 'An error occurred: ' || SQLERRM); 

 BEGIN 
 END; 
 SELECT * FROM PERSONAL_INFO Order By employee_id; 
-------------------------------------------------------------------------------------------------------------- 
     e_employee_id in number, 
     e_bank_account_number in number , 
     e_pf_account_number in varchar2 
 IS 
 emp_id number; 
     SELECT employee_id into emp_id from employees where employee_id = updater_id; 
 if(updater_id != e_employee_id ) then  
 end if; 
     SET bank_name = e_bank_name, 
         bank_code = e_bank_code, 
     WHERE employee_id = e_employee_id; 
     WHEN NO_DATA_FOUND THEN 
     when cannot_update then 
     WHEN OTHERS THEN 
 END Update_Employee_Bank_Details; 
-------------TESTING----------------- 
     Update_Employee_Bank_Details(21,21,'HSBC',325939845088,'HSB24605','PF5N986IND'); 

 SELECT * FROM Bank_Details Order By employee_id; 
--D3. Create a procedure to delete an employee in the employee table  
  
--------------DELETING-----------  
CREATE OR REPLACE PROCEDURE Delete_Employee( 
 ) 
 BEGIN 
     DELETE FROM bank_details WHERE employee_id = e_employee_id; 
 EXCEPTION 
         RAISE_APPLICATION_ERROR(-20001, 'Employee with specified ID does not exist.'); 
         RAISE_APPLICATION_ERROR(-20002, 'An unexpected error occurred: ' || SQLERRM); 
END Delete_Employee; 
------TESTING-------- 
     Delete_Employee(21); 

 SELECT * FROM Employees ORDER BY employee_id; 
SELECT * FROM Personal_Info ORDER BY employee_id; 
SELECT *  from Bank_Details ORDER BY employee_id; 
 
