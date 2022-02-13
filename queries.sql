-- ADD AND REMOVE FOREIGN KEY:
ALTER TABLE credit_card ADD CONSTRAINT `FK_EMPLOYEE_ID` FOREIGN KEY credit_card(employeeID) REFERENCES employees(ID);
ALTER TABLE credit_card DROP FOREIGN KEY `FK_EMPLOYEE_ID`;
DROP INDEX `FK_EMPLOYEE_ID` ON credit_card;

-- JOIN QUERIES:
ANALYZE TABLE employees;
ANALYZE TABLE credit_card;
ANALYZE TABLE bonus;

SELECT * FROM employees e JOIN credit_card cc ON e.ID = cc.employeeID AND e.ID = "fffd0ef2-ce0c-44cf-bf6f-3383626e2985";

SELECT ID, fullName, city, salary, creditCards FROM employees e INNER JOIN (SELECT cc.employeeID, JSON_ARRAYAGG(JSON_OBJECT('ID', cc.ID, 'active', cc.active, 'number', cc.`number`)) AS creditCards FROM credit_card cc WHERE cc.employeeID = "fffd0ef2-ce0c-44cf-bf6f-3383626e2985") aggregatedCreditCard ON (e.ID = aggregatedCreditCard.employeeID) AND e.ID = "fffd0ef2-ce0c-44cf-bf6f-3383626e2985";

SELECT ID, fullName, city, salary, creditCards, bonuses FROM employees e INNER JOIN (SELECT cc.employeeID, JSON_ARRAYAGG(JSON_OBJECT('ID', cc.ID, 'active', cc.active, 'number', cc.`number`)) AS creditCards FROM credit_card cc WHERE cc.employeeID = "fffd0ef2-ce0c-44cf-bf6f-3383626e2985") aggregatedCreditCard ON (e.ID = aggregatedCreditCard.employeeID) INNER JOIN (SELECT b.employeeID, JSON_ARRAYAGG(JSON_OBJECT('ID', b.ID, 'amount', b.amount)) AS bonuses FROM bonus b WHERE b.employeeID = "fffd0ef2-ce0c-44cf-bf6f-3383626e2985") aggregatedBonus  ON (aggregatedBonus.employeeID = e.ID) AND e.ID = "fffd0ef2-ce0c-44cf-bf6f-3383626e2985";