
SELECT * FROM sys.symmetric_keys 
SELECT * FROM sys.certificates 
SELECT * FROM sys.database_principals


USE B_MIG10
GO

CREATE MASTER KEY ENCRYPTION BY PASSWORD = '$EncryptionPassword12'
GO


CREATE CERTIFICATE CertificateTest1
     ENCRYPTION BY PASSWORD = 'CERTP@ssw0d'
     WITH SUBJECT ='Test certificate 1',
     START_DATE = '19/09/2011',
     EXPIRY_DATE = '21/09/2011'
GO

CREATE SYMMETRIC KEY PasswordFieldSymmetricKey
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE CertificateTest1;

USE B_ACREENCIAS
go
SELECT * FROM sys.symmetric_keys 


INSERT INTO dbo.T_CHEQUES_v2 (ID,CEDULA,BENEFICIARIO,MONTO) VALUES
(1,'V123456789','PEDRO PEREZ', 1.00);
GO

select * from dbo.T_CHEQUES_v2

DECLARE @cipherText varbinary(1000)
SET @cipherText = EncryptByCert(Cert_ID('CertificateTest1'), 'Pedro Perez')
SELECT @cipherText, datalength(@cipherText)
SELECT CONVERT(varchar, DecryptByCert(Cert_ID('CertificateTest1'), @cipherText,N'CERTP@ssw0d'))


CREATE CERTIFICATE CertificateTest2 AUTHORIZATION dbo
     ENCRYPTION BY PASSWORD = 'CERTP@ssw0d'
     WITH SUBJECT ='Test certificate 2',
     START_DATE = '20/09/2011',
     EXPIRY_DATE = '21/09/2011'
GO


CREATE SYMMETRIC KEY PasswordSymmetricKey
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE CertificateTest2;

OPEN SYMMETRIC KEY PasswordSymmetricKey
DECRYPTION  BY CERTIFICATE CertificateTest1;
UPDATE dbo.T_CHEQUES_v2 SET ENCRYPTEDBENEFICIARIO = EncryptByKey(Key_GUID('PasswordSymmetricKey'), BENEFICIARIO);
GO
CLOSE ALL SYMMETRIC KEYS



SELECT * FROM sys.symmetric_keys 
SELECT * FROM sys.certificates

USE master
GO
CREATE DATABASE EncryptTest ON  PRIMARY
( NAME = N'EncryptTest', FILENAME = N'C:\USR\EncryptTest.mdf')
 LOG ON
(NAME = N'EncryptTest_log', FILENAME = N'C:\USR\EncryptTest_log.ldf')
GO

USE EncryptTest
GO
CREATE TABLE TestTable (FirstCol INT, SecondCol VARCHAR(50))
GO
INSERT INTO TestTable (FirstCol, SecondCol)
SELECT 1,'First'
UNION ALL
SELECT 2,'Second'
UNION ALL
SELECT 3,'Third'
UNION ALL
SELECT 4,'Fourth'
UNION ALL
SELECT 5,'Fifth'
GO
-- Check the content of the TestTable
USE EncryptTest
GO
SELECT *
FROM TestTable
GO

USE EncryptTest
GO
CREATE MASTER KEY ENCRYPTION BY
PASSWORD = 'SQLAuthority'
GO


USE EncryptTest
GO
CREATE CERTIFICATE EncryptTestCert
   WITH SUBJECT = 'SQLAuthority'
GO


CREATE CERTIFICATE CertificateTest1
     ENCRYPTION BY PASSWORD = 'CERTP@ssw0d'
     WITH SUBJECT ='Test certificate 1',
     START_DATE = '19/09/2011',
     EXPIRY_DATE = '21/09/2011'
GO

USE EncryptTest
GO
CREATE SYMMETRIC KEY TestTableKey
   WITH ALGORITHM = TRIPLE_DES
    ENCRYPTION BY CERTIFICATE EncryptTestCert
GO


CREATE SYMMETRIC KEY PasswordSymmetricKey
WITH ALGORITHM = TRIPLE_DES
ENCRYPTION BY CERTIFICATE CertificateTest1;


USE EncryptTest
GO
ALTER TABLE TestTable
ADD EncryptFourCol VARBINARY(256)
GO


USE EncryptTest
GO
ALTER TABLE TestTable
ADD EncryptFifthcol VARBINARY(256)
GO


USE EncryptTest
GO
OPEN SYMMETRIC KEY TestTableKey
DECRYPTION BY CERTIFICATE EncryptTestCert
UPDATE TestTable
SET EncryptSecondCol = ENCRYPTBYKEY(KEY_GUID('TestTableKey'),SecondCol)
GO

USE EncryptTest
GO
SELECT *
FROM TestTable
GO


USE EncryptTest
GO
OPEN SYMMETRIC KEY TestTableKey
DECRYPTION BY CERTIFICATE EncryptTestCert
UPDATE TestTable
SET EncryptThirdCol = ENCRYPTBYKEY(KEY_GUID('TestTableKey'),SecondCol)
GO

USE EncryptTest
GO
OPEN SYMMETRIC KEY TestTableKey
DECRYPTION BY CERTIFICATE EncryptTestCert
SELECT FirstCol, SecondCol,CONVERT(VARCHAR(50),DECRYPTBYKEY(EncryptThirdCol)) AS DecryptThirdCol,
CONVERT(VARCHAR(50),DECRYPTBYKEY(EncryptSecondCol)) AS DecryptSecondCol,
CONVERT(VARCHAR(50),DECRYPTBYKEY(EncryptFourCol)) AS DecryptFourdCol
FROM TestTable
GO

OPEN SYMMETRIC KEY PasswordSymmetricKey
DECRYPTION BY CERTIFICATE CertificateTest1 WITH PASSWORD='CERTP@ssw0d'
UPDATE TestTable
SET EncryptFourCol = ENCRYPTBYKEY(KEY_GUID('PasswordSymmetricKey'),SecondCol)
GO
CLOSE ALL SYMMETRIC KEYS

OPEN SYMMETRIC KEY PasswordSymmetricKey
DECRYPTION BY CERTIFICATE CertificateTest1 WITH PASSWORD='CERTP@ssw0d'
SELECT FirstCol, SecondCol, EncryptFourCol,CONVERT(VARCHAR(50),DECRYPTBYKEY(EncryptFourCol)) AS DecrypttFourCol,
CONVERT(VARCHAR(50),DECRYPTBYKEY(EncryptSecondCol)) AS DecrypttSecondCol,
CONVERT(VARCHAR(50),DECRYPTBYKEY(EncryptThirdCol)) AS DecryptThirdCol
FROM TestTable
GO
CLOSE ALL SYMMETRIC KEYS


USE EncryptTest
GO
OPEN SYMMETRIC KEY yidaSymKeyPwd 
DECRYPTION BY PASSWORD='mami'
UPDATE TestTable
SET EncryptFifthcol = ENCRYPTBYKEY(KEY_GUID('yidaSymKeyPwd'),SecondCol)
GO


OPEN SYMMETRIC KEY yidaSymKeyPwd
DECRYPTION BY PASSWORD='mami'
SELECT FirstCol, SecondCol, EncryptFourCol,EncryptFifthcol ,CONVERT(VARCHAR(50),DECRYPTBYKEY(EncryptFourCol)) AS DecrypttFourCol,
CONVERT(VARCHAR(50),DECRYPTBYKEY(EncryptSecondCol)) AS DecrypttSecondCol,
CONVERT(VARCHAR(50),DECRYPTBYKEY(EncryptThirdCol)) AS DecryptThirdCol,
CONVERT(VARCHAR(50),DECRYPTBYKEY(EncryptFifthcol)) AS DecryptFifthCol
FROM TestTable
GO
CLOSE ALL SYMMETRIC KEYS

USE EncryptTest
GO
CLOSE SYMMETRIC KEY TestTableKey
GO
DROP SYMMETRIC KEY TestTableKey
GO
DROP CERTIFICATE EncryptTestCert
GO

CLOSE SYMMETRIC KEY User2SymKeyPwd
GO
DROP SYMMETRIC KEY User2SymKeyPwd