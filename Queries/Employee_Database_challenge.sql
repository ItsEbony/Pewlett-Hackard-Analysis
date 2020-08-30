-- Create Retirement Employees by Title Chart
SELECT emp.emp_no,
emp.first_name,
emp.last_name,
emp.birth_date,
ti.title,
ti.from_date,
ti.to_date
INTO retirement_titles
FROM employees AS emp
LEFT JOIN titles AS ti
ON emp.emp_no = ti.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retirement_titles AS rt
ORDER BY rt.emp_no, rt.to_date DESC;

-- Create chart to count each title that is retiring 
SELECT COUNT(emp_no), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC;

-- Create Mentorship Eligibility table 
SELECT DISTINCT ON (emp.emp_no) emp.emp_no,
emp.first_name,
emp.last_name,
emp.birth_date,
de.from_date,
de.to_date,
ti.title
FROM employees AS emp
INNER JOIN dept_employees AS de
ON (emp.emp_no = de.emp_no)
INNER JOIN titles AS ti
ON (emp.emp_no = ti.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp.emp_no, de.to_date;


