--Start of deliverable one
-- Create retirement titles
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees AS e
	INNER JOIN titles AS t
		ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')	
ORDER BY e.emp_no ASC;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
    rt.first_name,
    rt.last_name,
    rt.title
INTO unique_titles
FROM retirement_titles AS rt
ORDER BY rt.emp_no, rt.to_date DESC;

-- Create list and count of titles that are retiring
SELECT COUNT (ut.title), ut.title
INTO retiring_titles
FROM unique_titles AS ut
GROUP BY ut.title
ORDER BY count Desc;


-- Deliverable 2 mentorship table
SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
    e.last_name,
    e.birth_date,
    de.from_date,
    de.to_date,
    t.title
INTO mentorship_eligibility
FROM employees AS e
    INNER JOIN dept_emp AS de
        ON (e.emp_no = de.emp_no)
    INNER JOIN titles AS t
        ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01')
    AND (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

-- Two additional Queries

--Total count of current employees
SELECT COUNT (e.emp_no), de.dept_no 
INTO total_employee_count
FROM employees as e
	INNER JOIN dept_emp as de
		ON (e.emp_no = de.emp_no)
WHERE (de.to_date = '9999-01-01')
GROUP BY de.dept_no;

--Look at expanding mentorship program
DROP TABLE mentorship_eligibility_new;

SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
    e.last_name,
    e.birth_date,
    de.from_date,
    de.to_date,
    t.title
INTO mentorship_eligibility_new
FROM employees AS e
    INNER JOIN dept_emp AS de
        ON (e.emp_no = de.emp_no)
    INNER JOIN titles AS t
        ON (e.emp_no = t.emp_no)
WHERE (de.to_date = '9999-01-01')
    AND (e.birth_date BETWEEN '1956-01-01' AND '1965-12-31')
ORDER BY e.emp_no;

SELECT COUNT (me.title), me.title
FROM mentorship_eligibility_new AS me
GROUP BY me.title
ORDER BY count Desc;