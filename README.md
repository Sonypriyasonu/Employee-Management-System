# Employee Management System - Database Schema

## Tables and Schema

### 1. Employees Table
Contains information about employees.

| Column Name   | Data Type | Constraints |
|--------------|----------|-------------|
| Employee_ID  | INT      | PRIMARY KEY |
| Name         | VARCHAR  | NOT NULL    |
| Department_ID| INT      | FOREIGN KEY REFERENCES Departments(Department_ID) |
| Hourly_Rate  | DECIMAL  | NOT NULL    |
| Hours_Worked | DECIMAL  | NOT NULL    |
| Salary       | DECIMAL  | NOT NULL    |
| Hiredate     | DATE     | NOT NULL    |
| Manager_ID   | INT      | NULLABLE    |
| Commission   | DECIMAL  | NULLABLE    |
| Job_ID       | INT      | FOREIGN KEY REFERENCES Jobs(Job_ID) |

---

### 2. Jobs Table
Contains job information.

| Column Name | Data Type | Constraints |
|------------|----------|-------------|
| Job_ID     | INT      | PRIMARY KEY |
| Job_Title  | VARCHAR  | NOT NULL    |

---

### 3. Departments Table
Holds data related to departments.

| Column Name   | Data Type | Constraints |
|--------------|----------|-------------|
| Department_ID | INT      | PRIMARY KEY |
| DepartmentName | VARCHAR | NOT NULL    |
| Manager_ID   | INT      | NULLABLE    |
| Location_ID  | INT      | FOREIGN KEY REFERENCES Location(Location_ID) |

---

### 4. Attendance Table
Stores employee attendance records.

| Column Name     | Data Type | Constraints |
|----------------|----------|-------------|
| Attendance_ID  | INT      | PRIMARY KEY |
| Employee_ID    | INT      | FOREIGN KEY REFERENCES Employees(Employee_ID) |
| Attendance_Date | DATE    | NOT NULL    |
| Check_In      | TIME     | NOT NULL    |
| Check_Out     | TIME     | NOT NULL    |

---

### 5. LeaveRequests Table
Manages leave requests.

| Column Name  | Data Type | Constraints |
|-------------|----------|-------------|
| Request_ID  | INT      | PRIMARY KEY |
| Employee_ID | INT      | FOREIGN KEY REFERENCES Employees(Employee_ID) |
| StartDate   | DATE     | NOT NULL    |
| EndDate     | DATE     | NOT NULL    |
| Leave_type  | VARCHAR  | NOT NULL    |
| No_of_leaves | INT     | NOT NULL    |
| Status      | VARCHAR  | CHECK (Status IN ('Pending', 'Approved', 'Rejected')) |

---

### 6. Location Table
Contains location details.

| Column Name    | Data Type | Constraints |
|--------------|----------|-------------|
| Location_ID | INT      | PRIMARY KEY |
| Street_address | VARCHAR | NOT NULL    |
| Postal_code | VARCHAR  | NOT NULL    |
| City        | VARCHAR  | NOT NULL    |
| Country_name | VARCHAR | NOT NULL    |
| Region      | VARCHAR  | NOT NULL    |

---

### 7. Personal_Info Table
Stores employees' personal details.

| Column Name     | Data Type | Constraints |
|--------------|----------|-------------|
| Personal_Info_ID | INT      | PRIMARY KEY |
| Employee_ID  | INT      | FOREIGN KEY REFERENCES Employees(Employee_ID) |
| Date_of_Birth | DATE    | NOT NULL    |
| Address      | VARCHAR  | NOT NULL    |
| Contact_number | VARCHAR | NOT NULL    |
| Email        | VARCHAR  | UNIQUE, NOT NULL |

---

### 8. SalaryHistory Table
Tracks salary history changes.

| Column Name      | Data Type | Constraints |
|----------------|----------|-------------|
| SalaryHistory_ID | INT      | PRIMARY KEY |
| Employee_ID    | INT      | FOREIGN KEY REFERENCES Employees(Employee_ID) |
| Previous_Salary | DECIMAL  | NOT NULL    |
| New_Salary    | DECIMAL  | NOT NULL    |
| Change_Date   | DATE     | NOT NULL    |

---

### 9. Job_History Table
Maintains records of employee job history.

| Column Name   | Data Type | Constraints |
|--------------|----------|-------------|
| Job_History_ID | INT      | PRIMARY KEY |
| Employee_ID  | INT      | FOREIGN KEY REFERENCES Employees(Employee_ID) |
| StartDate    | DATE     | NOT NULL    |
| EndDate      | DATE     | NULLABLE    |
| Department_ID | INT      | FOREIGN KEY REFERENCES Departments(Department_ID) |

---

### 10. Bank_Details Table
Stores employee bank details.

| Column Name        | Data Type | Constraints |
|------------------|----------|-------------|
| Bank_Account_Number | VARCHAR | PRIMARY KEY |
| Employee_ID     | INT      | FOREIGN KEY REFERENCES Employees(Employee_ID) |
| Bank_Name      | VARCHAR  | NOT NULL    |
| Bank_Code      | VARCHAR  | NOT NULL    |
| PF_Account_Number | VARCHAR | NOT NULL    |

---

### Notes
- All `Employee_ID` fields serve as foreign keys linking respective tables.
- Referential integrity should be enforced between related tables.
- `Status` in `LeaveRequests` is constrained to ('Pending', 'Approved', 'Rejected').
- Salary, hourly rates, and commissions should be stored in `DECIMAL` format for precision.

## Usage
This schema can be used to implement an Employee Management System that tracks employees, attendance, salaries, job histories, leave requests, and other crucial employment details.


