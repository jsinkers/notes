SELECT *
FROM department;

SELECT Name, Floor
FROM department
WHERE Floor != 5
ORDER BY Floor;

SELECT CONCAT(firstname, ' ', lastname) AS name
FROM employee;

# What is the maximum salary for each department
SELECT departmentID, MAX(Salary)
FROM employee
GROUP BY employeeID;

# highest average salary
SELECT departmentID, AVG(Salary)
FROM employee
GROUP BY employeeID
ORDER BY AVG(Salary) DESC
LIMIT 1;

# find did of departments with only 1 employee
SELECT departmentID, COUNT(DISTINCT employeeID)
FROM employee
GROUP BY departmentID
HAVING COUNT(DISTINCT employeeID) = 1;

# formatting: format outputs a pretty STRING
SELECT FORMAT(AVG(Salary), 2) as AVG_SAL
FROM employee;

# round
SELECT ROUND(AVG(Salary), 2) as AVG_SAL
FROm employee;


CREATE TABLE Course (
                        CourseID INT,
                        CourseName VARCHAR(100),
                        CourseAddress VARCHAR(100),
                        CourseSuburb VARCHAR(40),
                        CoursePhone VARCHAR(10),
                        PRIMARY KEY (CourseID)
);

CREATE TABLE Hole (
                      CourseID INT,
                      HoleNumber INT,
                      Distance DECIMAL(5, 1),
                      Par INT,
                      PRIMARY KEY (CourseID, HoleNumber),
                      FOREIGN KEY (CourseID) REFERENCES Course (CourseID)
);

CREATE TABLE Tournament (
                            TournamentID INT,
                            TournamentName VARCHAR(100),
                            CourseID INT,
                            StartDate DATE,
                            EndDate DATE,
                            AgeLimit INT,
                            PRIMARY KEY (TournamentID),
                            FOREIGN KEY (CourseID) REFERENCES Course (CourseID)
);

# find names and salaries of employees who earn more than any employee in
# the marketing department

# 1. get max salary of marketing department
SELECT MAX(employee.salary)
FROM employee NATURAL JOIN department AS d
WHERE d.Name = 'Marketing';

SELECT FirstName, LastName, Salary
FROM employee
WHERE salary > (SELECT MAX(employee.salary)
                FROM employee NATURAL JOIN department AS d
                WHERE d.Name = 'Marketing');

# name and salary of clare underwood's manager
# find boss of clare underwood
SELECT BossID
FROM employee
WHERE FirstName = 'Clare' AND LastName = 'Underwood';

# find manager id of this department
SELECT FirstName, LastName, Salary
FROM employee
WHERE employeeID = (SELECT BossID
                    FROM employee
                    WHERE FirstName = 'Clare' AND LastName = 'Underwood');

# list first/last names of bosses who supervise > 2 staff and who also manage a department
SELECT employee.FirstName, employee.LastName
FROM employee INNER JOIN department
    ON employee.employeeID = department.ManagerID;

SELECT boss.FirstName, boss.LastName
FROM employee as emp INNER JOIN employee as boss
 ON emp.BossID = Boss.employeeID
WHERE boss.employeeID IN (SELECT managerID FROM department)
GROUP BY boss.employeeID
HAVING COUNT(emp.employeeID) > 2;

# list names, salaries, department names of employees who manage more than 2 employees
# first get bossIDs who manage more than 2 employees
SELECT BossID, COUNT(*)
FROM employee
GROUP BY BossID
HAVING COUNT(*) > 2;

# now full result
SELECT FirstName, LastName, Salary, Name
FROM employee NATURAL JOIN department
WHERE employeeID IN (SELECT BossID
                     FROM employee
                     GROUP BY BossID
                     HAVING COUNT(*) > 2);

# list suppliers that have delivered at least 10 distinct items.
SELECT supplier.Name
FROM supplier NATURAL JOIN delivery INNER JOIN deliveryitem d on delivery.DeliveryID = d.DeliveryId
GROUP BY supplier.SupplierID
HAVING COUNT(DISTINCT d.itemId) >= 10;

# list item names delivered by nepalese corp and sold in navigation department
SELECT DISTINCT item.Name, s.Name, department.Name
FROM item INNER JOIN deliveryitem d on item.itemID = d.itemId
    INNER JOIN department on d.departmentID = department.departmentID
    INNER JOIN delivery d2 on d.DeliveryId = d2.DeliveryID
    INNER JOIN supplier s on d2.SupplierID = s.SupplierID
WHERE s.Name = 'Nepalese Corp.' AND department.Name = 'Navigation';

# item ids of items sold on second floor
SELECT DISTINCT saleitem.itemId
FROM saleitem NATURAL JOIN sale NATURAL JOIN department
WHERE department.Floor = 2
ORDER BY saleitem.itemId ASC;

# find id and name of suppliers that deliver both compasses and an item other than compasses
# find supplier IDs of suppliers who deliver compasses
SELECT delivery.SupplierID
FROM delivery natural join deliveryitem NATURAL join item
WHERE item.Name LIKE '%ompass%';

# find supplier IDs of suppliers who deliver compasses and one other item not like compass
SELECT DISTINCT delivery.supplierID, supplier.Name
FROM supplier INNER JOIN delivery ON supplier.SupplierID = delivery.SupplierID
    inner join deliveryitem ON delivery.DeliveryID = deliveryitem.DeliveryId
    inner join item ON deliveryitem.itemId = item.itemID
WHERE item.Name NOT LIKE '%ompass%'
  AND delivery.SupplierID IN (SELECT delivery.SupplierID
                              FROM delivery natural join deliveryitem NATURAL join item
                              WHERE item.Name LIKE '%ompass%');

SELECT DISTINCT delivery.supplierID, supplier.Name
FROM supplier INNER JOIN delivery ON supplier.SupplierID = delivery.SupplierID
              inner join deliveryitem ON delivery.DeliveryID = deliveryitem.DeliveryId
              inner join item ON deliveryitem.itemId = item.itemID
WHERE delivery.SupplierID IN (SELECT delivery.SupplierID
                              FROM delivery natural join deliveryitem NATURAL join item
                              WHERE item.Name LIKE '%ompass%')
GROUP BY delivery.supplierID
HAVING COUNT(DISTINCT item.itemID) > 1
ORDER BY delivery.SupplierID;

SELECT DISTINCT item.Name, item.Type, department.Name, department.Floor
FROM item INNER JOIN saleitem ON item.itemID = saleitem.itemId
    INNER JOIN sale ON saleitem.SaleId = sale.SaleID
    INNER JOIN department ON sale.departmentID = department.departmentID
ORDER BY item.Name;

# find items not solve by departments on the second floor, but sold within other floors
# first find items sold by departments on 2nd floor
SELECT saleitem.itemID
FROM saleitem NATURAL JOIN sale NATURAL JOIN department
WHERE department.floor = 2;

SELECT DISTINCT saleitem.itemID, department.floor
FROM saleitem NATURAL JOIN sale NATURAL JOIN department
WHERE saleitem.itemId NOT IN (
    SELECT saleitem.itemID
    FROM saleitem NATURAL JOIN sale NATURAL JOIN department
    WHERE department.floor = 2)
ORDER BY saleitem.itemId;

# average quantity of each item of type N delivered by each company
SELECT  delivery.supplierID, item.itemID, item.Name, AVG(Quantity)
FROM item INNER JOIN deliveryitem d on item.itemID = d.itemId
    INNER JOIN delivery ON d.DeliveryId = delivery.DeliveryID
WHERE item.Type = 'N'
GROUP BY item.itemID, delivery.SupplierID
ORDER BY SupplierID;

# list suppliers that have delivered more than 40 items of types C and N
SELECT  delivery.supplierID, item.itemID, item.Name, SUM(d.Quantity)
FROM item INNER JOIN deliveryitem d on item.itemID = d.itemId
          INNER JOIN delivery ON d.DeliveryId = delivery.DeliveryID
WHERE item.Type IN ('C', 'N')
GROUP BY delivery.SupplierID
HAVING SUM(d.Quantity) > 40;

# find ids of items sold by at least 2 departments on 2nd floor
SELECT saleitem.itemID
FROM saleitem INNER JOIN sale ON saleitem.SaleId = sale.SaleID
    INNER JOIN department d on sale.departmentID = d.departmentID
WHERE d.floor = 2
GROUP BY saleitem.itemID
HAVING COUNT(DISTINCT d.departmentID) > 2;

SELECT saleitem.itemID
FROM saleitem INNER JOIN sale ON saleitem.SaleId = sale.SaleID
              INNER JOIN department d on sale.departmentID = d.departmentID
WHERE d.floor = 2
GROUP BY saleitem.itemID
HAVING COUNT(DISTINCT d.departmentID) >= 2;

# name items delivered by exactly one supplier
SELECT item.Name
FROM delivery INNER JOIN deliveryitem d on delivery.DeliveryID = d.DeliveryId
    INNER JOIN item ON d.itemId = item.itemID
GROUP BY item.itemID
HAVING COUNT(DISTINCT delivery.SupplierID) = 1
ORDER BY item.Name;

#
CREATE TABLE B (
                   bid INT NOT NULL,
                   PRIMARY KEY (bid)
);

CREATE TABLE C (
                   cid INT NOT NULL,
                   PRIMARY KEY (cid)
);

CREATE TABLE A (
                   aid INT NOT NULL,
                   bid INT NOT NULL,
                   cid INT NOT NULL,
                   PRIMARY KEY (aid),
                   FOREIGN KEY (bid) REFERENCES B (bid),
                   FOREIGN KEY (cid) REFERENCES C (cid)
);

SELECT COUNT(distinct itemID)
From item
GROUP BY Type
HAVING Type = 'C';
# 13
SELECT Suburb.SName
FROM CensusRecord NATURAL JOIN Residency NATURAL JOIN Suburb
WHERE Residency.PID IN (SELECT COUNT(DISTINCT PreferredTransportation.PID)
                        FROM PreferredTransportation NATURAL JOIN TransportMeans
                        WHERE TransportMeans.TName = 'Public Transport'
GROUP BY Suburb.SID
ORDER BY COUNT(DISTINCT Residency.PID) DESC
LIMIT 1;
