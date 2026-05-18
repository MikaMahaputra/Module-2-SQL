USE employees;
SELECT d.dept_name, COUNT(de.emp_no) AS total_employees
FROM departments d
JOIN dept_emp de
ON d.dept_no = de.dept_no
WHERE d.dept_name IN ('Research', 'Production', 'Sales')
GROUP BY d.dept_name;