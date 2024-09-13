--B1)Allow managers to approve leave requests and track attendance.  
--B2)Implement role-based access control for sensitive employee data. 
--Creating Package : 
drop package psa
CREATE OR REPLACE PACKAGE psa IS  
    TYPE rec is table OF VARCHAR2(100) index by   VARCHAR2(100); 
    TYPE leave_row IS TABLE OF leaverequests%rowtype; 
    procedure check_out(emp_id number); 
    procedure check_in(emp_id number); --completed 
    procedure attendance_tracking (emp_id number,r_month in number default null, r_year in number default null); --completed 
    FUNCTION total_leaves_emp(emp_id IN NUMBER, start_year in date, end_year in date) RETURN rec;--completed 
    procedure leave_request (emp_id IN NUMBER, e_leave_type IN VARCHAR2, e_no_of_leaves IN NUMBER, start_date IN DATE, end_date IN DATE) ; 
    procedure manager_leave_request (leave_id number,emp_id number,man_id number);  --	completed 
    procedure update_employee_info(updated_person_id in number , 
        		e_employee_id in number, 
        		e_department_id in number , 
        		e_job_id in varchar2, 
       		e_salary in number, 
    e_commission in number); 
    procedure  all_employee_attendance_tracking(mana_id in number); --completed  
END; 
  
--drop package psa 
  
CREATE OR REPLACE PACKAGE BODY psa is 
  
    --procedure for check_out 
    procedure check_out (emp_id number) is 
        	begin 
       		update attendance set check_out = systimestamp where employee_id =emp_id and check_out is null; 
        	end; 
  
    --procedure for check_in 
    procedure check_in(emp_id number) 
    is 
    id number; 
    begin 
        select count(attendance_id) into id from attendance ; 
        id:=id+1; 
       	insert into attendance (attendance_id,employee_id,attendance_date,check_in)values(id,emp_id,sysdate,systimestamp); 
    end; 
      
    --attendance traking 
    procedure attendance_tracking (emp_id number,r_month in number default null, r_year in number default null) is
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
        leave_list := total_leaves_emp(emp_id,TO_DATE('2024-04-01', 'YYYY-MM-DD'), TO_DATE('2024-05-31', 'YYYY-MM-DD'));  
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
        procedure update_employee_info(updated_person_id in number , 
        e_employee_id in number, 
        e_department_id in number , 
        e_job_id in varchar2, 
        e_salary in number, 
        e_commission in number) 
    is 
        d_id number; 
        cannot_update exception; 
        begin 
        select department_id into d_id from employees where employee_id = updated_person_id; 
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
END psa; 
 
--testing 
--calling attendance tracking 
begin 
psa.attendance_tracking(2,null,2024); 
end; 
  
--calling all_employee_attendance_tracking for particular manager  
begin 
psa.all_employee_attendance_tracking(7); 
end; 
 
--calling procedure to apply leave 
begin 
psa.leave_request (4, 'Earned', 1, to_date('07-06-2024','dd-mm-yyyy'),to_date('07-06-2024','dd-mm-yyyy') ) ; 
end; 
  
begin 
psa.leave_request (7, 'sick', 1, to_date('07-06-2024','dd-mm-yyyy'),to_date('07-06-2024','dd-mm-yyyy') ) ; 
end;  

select * from leaverequests
--calling procedures for  manager to approve leave request 
begin 
manager_leave_request(12,7,12); 
end; 
   
begin 
psa.leave_request (7, 'sick', 1, to_date('08-06-2024','dd-mm-yyyy'),to_date('08-06-2024','dd-mm-yyyy')) ; 
end; 
--C1. Assigning employees to different departments.  

 create or replace procedure update_employee_department(p_employee_id in employees.employee_id%type,p_new_department_id in employees.department_id%type)  
 is 
     v_previous_department_id employees.department_id%type; 
     v_previous_department_name departments.department_name%type; 
     v_new_department_name departments.department_name%type; 
     v_employeename employees.name%type; 
 begin 
     select e.department_id,e.name,d.department_name 
     into v_previous_department_id,v_employeename,v_previous_department_name 
     from employees e join departments d on e.department_id=d.department_id where e.employee_id=p_employee_id; 

    update employees 
     set department_id = p_new_department_id 
     where employee_id = p_employee_id; 

    select department_name 
     into v_new_department_name 
     from departments 
     where department_id = p_new_department_id; 

    dbms_output.put_line('employee id: ' || p_employee_id ||chr(10)||'Employee name: '||v_employeename||chr(10)||'previous department id: ' || v_previous_department_id ||chr(10)||'previous_department name:  '||v_previous_department_name||chr(10)|| 'new department id: ' || p_new_department_id||chr(10)||'new departmentname: '||v_new_department_name); 
 
 exception 
     when no_data_found then 
         dbms_output.put_line('employee with id ' || p_employee_id || ' not found.'); 
     when others then 
         dbms_output.put_line('an error occurred: ' || sqlerrm); 
 end update_employee_department; 
 

select * from employees order by employee_id 

begin 
 update_employee_department(1,102); 
end; 
  

--D1. Create a procedure to insert new employee to the employee table 

------ADDING-------- 
 create or replace procedure insert_new_employeee_info ( 
             e_name IN VARCHAR2, 
             e_department_id IN NUMBER, 
             e_salary IN NUMBER, 
             e_manager_id IN NUMBER, 
             e_commission IN NUMBER, 
             e_job_id IN VARCHAR2, 
             e_date_of_birth in  date, 
             e_address in varchar2, 
             e_contact_number in  number, 
             e_email in varchar2, 
             e_gender in varchar2, 
             e_bank_name in  varchar2, 
             e_bank_account_number in number , 
             e_bank_code in varchar2, 
             e_pf_account_number in varchar2 
 ) is 
     id number; 
     p_id number; 
 begin 
     -----EMPLOYEES------------ 
     select count(employee_id) into id from employees; 
     id:=id+1; 
     insert into employees(employee_id,name,department_id,salary,hiredate,manager_id,commission,job_id) values 
     (id,e_name,e_department_id,e_salary,sysdate,e_manager_id ,e_commission,e_job_id); 
     ------PERSONAL_INFO---------- 
     p_id:=0; 
     select count(personal_info_id) into p_id from personal_info; 
     p_id :=p_id+1; 
     insert into personal_info ( personal_info_id,employee_id,gender,date_of_birth,Address,contact_number,email) values 
     (p_id,id,e_gender,e_date_of_birth,e_address,e_contact_number,e_email); 
     ------BANK_DETAILS--------- 
     insert into bank_details(bank_name,employee_id,bank_account_number,bank_code,pf_account_number) values 
     (e_bank_name,id,e_bank_account_number,e_bank_code,e_pf_account_number); 
 EXCEPTION 
     WHEN DUP_VAL_ON_INDEX THEN 
             -- Unique Constraint Violation 
        DBMS_OUTPUT.PUT_LINE('Employee ID already exists.'); 
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('No data found.'); 
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM); 
 end; 

SELECT * FROM EMPLOYEES order by employee_id; 
select * from personal_info order by employee_id 
select * from bank_details order by employee_id 


-----CALLING------ 
 BEGIN 
     insert_new_employeee_info('Lavanya Nakka',103,6500,10,NULL,'AD_VP',TO_DATE('12-01-2003','DD-MM-YYYY'),'Gachibowli,Hyderabad',8463949476,'lavanyanakka@gmail.com','Female', 
     'ICICI',317539708006,'ICI23005','PF5L986IND'); 
 END; 

  
--D2. Create a procedure to update employee details in the employee table 

-----------UPDATING---------------- 
 CREATE OR REPLACE PROCEDURE Update_Employee_Personal_Info(updateder_id in number, 
     e_employee_id in number, 
     e_name in varchar2, 
     e_gender in varchar2, 
     e_date_of_birth in  date, 
     e_address in varchar2, 
     e_contact_number in  number, 
     e_email in varchar2, 
     e_bank_name in  varchar2, 
     e_bank_account_number in number , 
     e_bank_code in varchar2, 
     e_pf_account_number in varchar2 
 ) 
 IS 
    cannot_update exception; 
 BEGIN 
     if(updateder_id != e_employee_id ) then  
        raise cannot_update; 
     end if; 
     --EMPLOYEES---- 
     UPDATE employees 
     SET name = e_name   
     WHERE employee_id = e_employee_id; 
     --PERSONAL_INFO----- 
     UPDATE personal_info 
     SET gender = e_gender, 
         date_of_birth = e_date_of_birth, 
         address = e_address, 
         contact_number = e_contact_number, 
         email = e_email 
     WHERE employee_id = e_employee_id; 
     --bank_details 
     UPDATE bank_details 
     SET bank_name = e_bank_name, 
         bank_account_number = e_bank_account_number, 
         bank_code = e_bank_code, 
         pf_account_number = e_pf_account_number 
     WHERE employee_id = e_employee_id; 
 EXCEPTION 
     WHEN NO_DATA_FOUND THEN 
         RAISE_APPLICATION_ERROR(-20001, 'Employee does not exist.'); 
     when cannot_update then 
         dbms_output.put_line('No permission allowed'); 
     WHEN OTHERS THEN 
         RAISE_APPLICATION_ERROR(-20006, 'An error occurred: ' || SQLERRM); 
 END Update_Employee_Personal_Info; 

 
SELECT * FROM bank_details; 

-------------CALLING----------------- 
 BEGIN 
     Update_Employee_Personal_Info(21,21,'Lavanya','Female',TO_DATE('12-01-2003','DD-MM-YYYY'),'Gachibowli,Hyderabad',8463949476,'lavanyanakka@gmail.com', 
     'ICICI',317539708006,'ICI23005','PF5L986IND'); 
 END; 

  
--D3. Create a procedure to delete  an employee in the employee table 

-----DELETING------- 
 CREATE OR REPLACE PROCEDURE Delete_Employee( 
     e_employee_id IN NUMBER 
 ) 
 IS 
 BEGIN 
     DELETE FROM personal_info WHERE employee_id = e_employee_id; 
     DELETE FROM bank_details WHERE employee_id = e_employee_id; 
     DELETE FROM employees WHERE employee_id = e_employee_id; 
 EXCEPTION 
     WHEN NO_DATA_FOUND THEN 
         RAISE_APPLICATION_ERROR(-20001, 'Employee with specified ID does not exist.'); 
     WHEN OTHERS THEN 
         RAISE_APPLICATION_ERROR(-20002, 'An unexpected error occurred: ' || SQLERRM); 
END Delete_Employee; 

--------CALLING-------- 
 BEGIN 
     Delete_Employee(21); 
 END; 
