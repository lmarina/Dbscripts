
DECLARE @columns VARCHAR(8000);
DECLARE @query VARCHAR(8000);
DECLARE @mes1 varchar(2);
DECLARE @ane1 varchar(4)
SET @mes1='03';
SET @ane1='2011'

SELECT @columns = COALESCE(@columns + ',[' + cast(codesud as varchar) + ']',
'[' + cast(codesud as varchar)+ ']')
FROM #Mytable3
GROUP BY codesud
ORDER BY codesud

SELECT @query = '
SELECT * FROM (SELECT CODESUD,ACCOUNT FROM #Mytable3
WHERE SEQUENCE >= 1 OR SEQUENCE <= 17 AND COVARNAME='''+CAST(@mes1 AS VARCHAR)+''' AND COVARYEAR='''+CAST(@ane1 AS VARCHAR)+''' AND FORMA=''F''
) AS P 
PIVOT
(
sum(ACCOUNT)
FOR [codesud]
IN (' + @columns + ')
)
AS p
'
FROM #Mytable3 as b

EXECUTE(@query)


SELECT top(10)*, 'SELECT '
      + QUOTENAME(codigosudeban,'''')+','
      + QUOTENAME(orden,'''')+','
      + QUOTENAME(forma,'''')+','
      + QUOTENAME(codigocontable,'''')+','
	  + QUOTENAME(descripcion,'''')+','
      + QUOTENAME(saldoreal,'''')+','
	  + QUOTENAME(covarname,'''')+','
      + QUOTENAME(covaryear,'''')
      + ' UNION ALL'
 FROM dbo.movimientoscaptura

SELECT  top 500  'SELECT '
      + QUOTENAME(codigosudeban,'''')+','
      + cast(orden as varchar)+','
      + QUOTENAME(forma,'''')+','
      + QUOTENAME(codigocontable,'''')+','
	  + cast(saldoreal as varchar)+','
	  + QUOTENAME(covarname,'''')+','
      + QUOTENAME(covaryear,'''')
      + ' UNION ALL'
 FROM dbo.movimientoscaptura where FORMA='F'

CREATE TABLE #Mytable22
(
  gcounter int not null,
  codesud varchar(10),
  sequence int,
  forms char(1),
  caccount varchar(10),
  account numeric(18,2),
  covarname varchar(10),
  covaryear varchar(10)
)

ALTER TABLE [dbo].[#Mytable22] ADD  CONSTRAINT [PK_T_PAG2] PRIMARY KEY CLUSTERED 
(
	[gcounter] ASC
)
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

CREATE TABLE #Mytable33
(
  gcounter int not null,
  codesud varchar(5),
  sequence int,
  forms char(1),
  caccount varchar(10),
  account numeric(18,2),
  covarname varchar(2),
  covaryear varchar(4)
)

ALTER TABLE [dbo].[#Mytable33] ADD  CONSTRAINT [PK_T_PAG3] PRIMARY KEY CLUSTERED 
(
	[gcounter] ASC
)
WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

Insert into #Mytable33
 (gcounter,codesud,sequence,forms,caccount,account,covarname,covaryear)
SELECT 76,'05961',cast('1' as int),'A','1200000000',cast('9000000.00' as numeric(18,2)),'03','2011' 


Insert into #Mytable33
 (gcounter,codesud,sequence,forms,caccount,account,covarname,covaryear)
SELECT 77,'05961',1,'A','1200000000',9000000.00,'03','2011' 

Insert into #Mytable33
 (gcounter,codesud,sequence,forms,caccount,account,covarname,covaryear)

SELECT 1,'05961',3,'F','5120000000',-246395.83,'03','2011' UNION ALL
SELECT 2,'03421',32,'F','4319910000',5987405.04,'03','2011' UNION ALL
SELECT 3,'03621',3,'F','5120000000',-8710527.17,'03','2011' UNION ALL
SELECT 4,'04721',3,'F','5120000000',-16825100.70,'03','2011' UNION ALL
SELECT 44,'04721',3,'F','5120000000',-16825100.70,'03','2011' UNION ALL
SELECT 45,'04721',3,'F','5120000000',-16825100.70,'03','2011' UNION ALL
SELECT 5,'04722',45,'F','4480910600',928.15,'03','2011' UNION ALL
SELECT 52,'04722',45,'F','4480910600',928.15,'03','2011' UNION ALL
SELECT 53,'04722',45,'F','4480910600',928.15,'03','2011' UNION ALL
SELECT 6,'04723',45,'F','4480910100',66064.50,'03','2011' 


Insert into #Mytable22
 (gcounter,codesud,sequence,forms,caccount,account,covarname,covaryear)

SELECT 1,'05961',3,'F','5120000000',-246395.83,'03','2011' UNION ALL
SELECT 2,'03421',32,'F','4319910000',5987405.04,'03','2011' UNION ALL
SELECT 3,'03621',3,'F','5120000000',-8710527.17,'03','2011' UNION ALL
SELECT 6,'04723',45,'F','4480910100',66064.50,'03','2011' 

SELECT  ROW_NUMBER() OVER (order by b.gcounter) as 'ROWNUMBER',b.codesud as 'ceda2', b.sequence, b.forms 
FROM #Mytable33 AS b
WHERE  (b.gcounter IN (SELECT d.gcounter FROM #Mytable22 AS d)) 

select * from #Mytable33
select * from #Mytable22
drop table #Mytable33
drop table #Mytable22
truncate table #Mytable33
truncate table #Mytable22