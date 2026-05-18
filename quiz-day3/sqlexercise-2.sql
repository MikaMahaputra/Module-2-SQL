-- Task 1
USE employees;
SELECT
d.dept_name AS department,
COUNT(e.emp_no) AS total_employees
FROM employees e
JOIN dept_emp de ON e.emp_no   = de.emp_no
JOIN departments d ON de.dept_no  = d.dept_no
WHERE d.dept_name IN ('Research', 'Production', 'Sales')
GROUP BY d.dept_name;

-- Task 2
USE employees;
SELECT COUNT(*) AS total_employees
FROM salaries
WHERE salary > (
SELECT AVG(salary)
FROM salaries
WHERE YEAR(from_date) = 1986
OR  YEAR(to_date) = 1986
)
AND (
YEAR(from_date) = 1986
OR YEAR(to_date) = 1986
);

-- Task 3
USE employees;
SELECT
d.dept_name AS department,
SUM(s.salary) AS total_payroll
FROM salaries s
JOIN dept_emp de ON s.emp_no   = de.emp_no
JOIN departments d ON de.dept_no  = d.dept_no
GROUP BY d.dept_name
HAVING SUM(s.salary) > 500000
ORDER BY total_payroll DESC
LIMIT 1;

-- Task 4
USE employees;
SELECT
d.dept_name AS department,
SUM(s.salary) AS gross_payroll,
SUM(s.salary) * 0.9 AS after_tax
FROM salaries s
JOIN dept_emp de   ON s.emp_no   = de.emp_no
JOIN departments d ON de.dept_no  = d.dept_no
WHERE YEAR(s.from_date) = YEAR(CURDATE())
OR  YEAR(s.to_date)   = YEAR(CURDATE())
GROUP BY d.dept_name
ORDER BY after_tax DESC;

-- Task 5
USE classicmodels;
SELECT
p.productName,
SUM(od.quantityOrdered) AS total_quantity
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productName
ORDER BY total_quantity DESC
LIMIT 5;

-- Task 6
SELECT
c.customerName,
SUM(od.quantityOrdered * od.priceEach) AS total_order_value
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.customerName
HAVING total_order_value > (
SELECT AVG(order_total)
FROM (
SELECT SUM(quantityOrdered * priceEach) AS order_total
FROM orderdetails
GROUP BY orderNumber
) AS sub
)
ORDER BY total_order_value DESC;

-- Task 7
SELECT
p.productLine,
SUM(od.quantityOrdered * od.priceEach) AS total_revenue
FROM orderdetails od
JOIN products p ON od.productCode = p.productCode
GROUP BY p.productLine
ORDER BY total_revenue DESC
LIMIT 1;

-- Task 8
SELECT
e.employeeNumber,
e.firstName,
e.lastName,
SUM(p.amount) AS total_payments
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY e.employeeNumber, e.firstName, e.lastName
HAVING SUM(p.amount) > 100000;

-- Task 9
SELECT
c.customerNumber,
c.customerName,
SUM(od.quantityOrdered * od.priceEach) AS total_revenue,
CASE
WHEN SUM(od.quantityOrdered * od.priceEach) > 100000  THEN 'VIP'
WHEN SUM(od.quantityOrdered * od.priceEach) BETWEEN 50000 AND 100000 THEN 'Premium'
ELSE 'Regular'
END AS tier
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.customerNumber, c.customerName
ORDER BY total_revenue DESC;

-- Task 10
SELECT
e.employeeNumber,
e.firstName,
e.lastName,
SUM(od.quantityOrdered * od.priceEach) AS total_revenue
FROM employees e
JOIN customers c ON e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY e.employeeNumber, e.firstName, e.lastName
ORDER BY total_revenue DESC
LIMIT 3;