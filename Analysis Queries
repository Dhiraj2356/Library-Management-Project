

-- CRUD OPERATIONS
--Create a New Book Record -- 

insert into book (isbn, book_title, category, rental_price, status, author, publisher)
values ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

---Update an Existing Member's Address

update members
set member_address = '125 Main St'
where member_id = 'C101'; 

--- Delete the record with issued_id = 'IS121' from the issued_status table.

delete from issued_status
where issued_id = 'IS121';

 
--- Select all books issued by the employee with emp_id = 'E101'.

select * from issued_status
where issued_emp_id = 'E101';

---DATA ANALYSIS

---Find list of Members Who Have Issued More Than One Book

select issued_emp_id, count(issued_id) as total_book_issued from issued_status
group by issued_emp_id
having count (issued_id) > 1;

---Use CTAS to generate new tables based on query results - each book and total book_issued 

create table book_count
as
Select b.isbn, b.book_title, count(ist.issued_id) as no_of_issued_books from book as b
join issued_status as ist 
on ist.issued_book_isbn = b.isbn
group by b.isbn, b.book_title;

--Retrieve All Books in a classic Category

Select * from book
where category = 'Classic'

---Find Total Rental Income by Category: 

Select b.category, 
       sum(b.rental_price) as total_income,
	   count(*) 
	   from book as b
join issued_status as ist on ist.issued_book_isbn = b.isbn
group by category;


---List of Members Who Registered in the Last 180 Days

select * from members
where reg_date >= current_date - interval '600 days'

---List of Employees with Their Branch Manager's Name and their branch details:

select 
   e.*,
   b.manager_id,
   e1.emp_name as manager
from employees as e
join branch as b
on e.branch_id = b.branch_id
join employees as e1
on b.manager_id = e1.emp_id 
order by manager asc;

--Create a Table of Books with Rental Price Above 5 usd:

create table expensive_books as
select book_title, rental_price from book
where rental_price >= 5
order by rental_price desc;

---Retrieve the List of Books Not Yet Returned

select  ist.issued_book_name, ist.issued_id from issued_status as ist
left join return_status as rst 
on ist.issued_id = rst.issued_id
where rst.return_id is null

/*
Write a query to identify members who have overdue books (assume a 30-day return period). 
Display the member's_id, member's name, book title, issue date, and days overdue.
*/

select  issued_member_id, member_name, issued_book_name, issued_date,   
        current_date - issued_date as days_overdue from (
select * from issued_status as ist
full join return_status as rst
On ist.issued_id = rst.issued_id
full join members as m
on ist.issued_member_id = m.member_id 
)
where return_date is null  and (current_date - issued_date) > 30
order by 1;

/*Create a query that generates a performance report for each branch, 
showing the number of books issued, the number of books returned, and the total revenue generated from book rentals. 
*/

create table branch_revenue as
select  b.branch_id,
		count(ist.issued_id) as books_issued, 
		count(rst.return_id) as books_return,
		sum(bk.rental_price) as total_revenue
		from issued_status as ist
join employees as e
on ist.issued_emp_id = e.emp_id
join branch as b
on e.branch_id = b.branch_id
full join return_status as rst
on rst.issued_id = ist.issued_id
join book as bk
on bk.isbn = ist.issued_book_isbn
group by 1;

