Create table branch(
     branch_id    varchar(50) primary key,
	 manager_id	  varchar(50),
	 branch_address	 varchar(50),
	 contact_no varchar(50)

);

Create table employees(
     emp_id	 varchar(50) primary key,     
	 emp_name varchar(50),				
	 position varchar(50),				
	 salary	int,									
	 branch_id varchar(50)
	 
);

create table book(
		
	isbn	varchar(50) primary key, 
	book_title 	varchar(65),
	category	varchar(50),
	rental_price	float,
	status	varchar(20),
	author	varchar(50),
	publisher varchar(50)

);


create table issued_status(

	issued_id	varchar(50) primary key,
	issued_member_id varchar(50),	
	issued_book_name	varchar(70),
	issued_date	date,
	issued_book_isbn varchar(50),	
	issued_emp_id varchar(50)

);

create table return_status(

	return_id	varchar(50) primary key,
	issued_id	varchar(50),
	return_book_name	 varchar(70),
	return_date	 date,
	return_book_isbn varchar(50)

);

create table members(

	member_id	varchar(50) primary key,
	member_name	varchar(50),
	member_address	varchar(50),
	reg_date date

);

----foreign key implementation----

alter table issued_status
add constraint fk_members
foreign key (issued_member_id)
references members(member_id);

alter table issued_status
add constraint fk_employees
foreign key (issued_emp_id)
references employees(emp_id);

alter table issued_status
add constraint fk_book
foreign key (issued_book_isbn)
references book(isbn);

alter table return_status
add constraint fk_issued_status
foreign key (issued_id)
references issued_status(issued_id);

alter table employees
add constraint fk_branch
foreign key (branch_id)
references branch(branch_id);
