--CHALLENGE QUERY
SELECT e.emp_no,
	e.first_name, 
	e.last_name,
	ti.title,
	ti.from_date,
	ti.to_date
INTO retirement_titles
FROM employees as e
RIGHT OUTER JOIN titles as ti
	ON (e.emp_no = ti.emp_no)
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- Number of employees by their most recent job title
SELECT COUNT(title), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count DESC

--Mentorship Eligibility
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name, 
	e.last_name,
	e.birth_date,
	emp.from_date,
	emp.to_date,
	ti.title
INTO mentorship_eligibilty
FROM employees as e
	FULL OUTER JOIN employment as emp
		ON (e.emp_no = emp.emp_no)
	FULL OUTER JOIN titles as ti
		ON (e.emp_no = ti.emp_no)
WHERE (birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (emp.to_date = '9999-01-01')
ORDER BY e.emp_no, emp.from_date ASC