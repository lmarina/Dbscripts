/*Manipulacion de Rowset en formato XML
con las opciones RAW,AUTO,EXPLICIT
*/

SELECT TOP 5 SalesOrderID, UnitPrice 
FROM Sales.SalesOrderDetail 
FOR XML AUTO

use AdventureWorks
GO
SELECT ProductModelID, Name
FROM Production.ProductModel
WHERE ProductModelID=122 or ProductModelID=119
FOR XML RAW;
GO


SELECT 1    as Tag,
       NULL as Parent,
       EmployeeID as [Employee!1!EmpID],
       NULL       as [Name!2!FName],
       NULL       as [Name!2!LName]
FROM   HumanResources.Employee E, Person.Contact C
WHERE  E.ContactID = C.ContactID
UNION ALL
SELECT 2 as Tag,
       1 as Parent,
       EmployeeID,
       FirstName, 
       LastName 
FROM   HumanResources.Employee E, Person.Contact C
WHERE  E.ContactID = C.ContactID
ORDER BY [Employee!1!EmpID],[Name!2!FName]
FOR XML EXPLICIT



