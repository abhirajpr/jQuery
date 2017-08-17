CREATE TABLE employees (
    id INT identity(1,1) PRIMARY KEY,
    employeeNumber INT NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    changedat DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);
------------------------------

CREATE TRIGGER before_employee_update
on employees    
FOR insert
as
BEGIN
    select * from inserted
	select * from deleted
END
---------------------------
CREATE TRIGGER before_employee_delete
on employees    
FOR delete
as
BEGIN
    select * from inserted
	select * from deleted
END
------------------------------------------------------------------
insert into employees(employeeNumber,lastname) values(1,'hi')

delete  from employees where employeeNumber=12

select * from  employees

drop trigger  before_employee_delete

--------------------------------------
create TRIGGER before_employee
on employees    
FOR insert
as
BEGIN
	declare @empid int;
	declare @empname varchar(100);

	select @empid=i.employeeNumber from inserted i;	
	select @empname=i.lastname from inserted i;	
	

	insert into employees_audit(employeeNumber,lastname,action1) values(@empid,@empname);

END


insert into employees(employeeNumber,lastname) values(5,'arjun')

select * from  employees_audit

select * from  employees

---------------------------------------------
ALTER TRIGGER before_employee
on employees    
FOR insert
as
BEGIN
	declare @empid int;
	declare @empname varchar(100);

	select @empid=i.employeeNumber from inserted i;	
	select @empname=i.lastname from inserted i;	
	

	insert into employees_audit(employeeNumber,lastname,action1) values(@empid,@empname,'inserted id '+cast(@empid as varchar));

END
-----------------------------------
INSTED OF
---------------------------------
alter trigger insteadof_trigger
on [employee].[dbo].[details]
instead of delete
as
begin
	update [employee].[dbo].[details] set isactive=0 where ID in (select ID from deleted);
	select * from deleted;
	select* from inserted;
end

delete from [employee].[dbo].[details] where ID=4
------------------------------------------------------------------------------------------------------

DATE Function
------------------------------------------------------------------------------------------------------

select isdate('2017-08-17');

select top 1 day(getdate()) as Day,month(getdate()) as Month ,year(getdate()) as Year from Sales.Store

select datename(year,'2017-08-17') as  year
select datename(month,'2017-08-17') as  month
select datename(WEEKDAY,'0001-01-01') as  day


select datename(year,'2000-08-17 12:10:15.123') as  year

select datepart(nanosecond,'12:10:15.123456789') as  month

select dateadd(year,22,'1995-11-02 10:10:10.100') as  new_date

select datediff(day,'1995-11-02' ,'2017-08-17') as difference

-------------------------------------------------------------------------------------------------------