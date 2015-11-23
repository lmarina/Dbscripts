
USE B_ACREENCIAS
go
-- Paso 1 Crear el Master Key en la B.D.

CREATE MASTER KEY ENCRYPTION BY PASSWORD = '$EncryptionPassword12'
GO

-- Paso 2 Crear Certificados

CREATE CERTIFICATE CertificateTest1
     ENCRYPTION BY PASSWORD = 'CERTP@ssw0d'
     WITH SUBJECT ='Test certificate 1',
     START_DATE = '19/09/2011',
     EXPIRY_DATE = '21/09/2011'
GO

-- Paso 3 Crear Clave Simetrica

CREATE SYMMETRIC KEY PasswordFieldSymmetricKey
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE CertificateTest1;

-- Paso Opcional verificar las claves simetricas creadas
USE B_ACREENCIAS
go
SELECT * FROM sys.symmetric_keys 

SELECT * FROM  sys.certificates

SELECT * FROM  sys.triggers


select * from dbo.T_CHEQUES_v2

-- Abrir la clave simetricas para actualizar columna
OPEN SYMMETRIC KEY PasswordFieldSymmetricKey
DECRYPTION BY CERTIFICATE CertificateTest1 WITH PASSWORD='CERTP@ssw0d'
UPDATE dbo.T_CHEQUES_v2 SET ENCRYPTEDBENEFICIARIO = EncryptByKey(Key_GUID('PasswordFieldSymmetricKey'), BENEFICIARIO)
WHERE ID=5
GO

-- Abrir la clave simetrica para hacer un select
OPEN SYMMETRIC KEY PasswordFieldSymmetricKey
DECRYPTION BY CERTIFICATE CertificateTest1 WITH PASSWORD='CERTP@ssw0d'
SELECT ID, CEDULA, MONTO,CONVERT(VARCHAR(50),DECRYPTBYKEY(ENCRYPTEDBENEFICIARIO)) AS BENEFICIARIO
FROM dbo.T_CHEQUES_v2
GO
CLOSE ALL SYMMETRIC KEYS

select * from dbo.T_CHEQUES_v2

--Manipulacion de Datos
INSERT INTO dbo.T_CHEQUES_v2 (ID,CEDULA,BENEFICIARIO,MONTO) VALUES
(1,'V11888888','LUIS MARIN', 1.00);
GO

INSERT INTO dbo.T_CHEQUES_v2 (ID,CEDULA,BENEFICIARIO,MONTO) VALUES
(2,'V88888888','PEDRO ERRE', 1.00);
GO

INSERT INTO dbo.T_CHEQUES_v2 (ID,CEDULA,BENEFICIARIO,MONTO) VALUES
(3,'V88888','ALFA OMEGA', 1.00);
GO

INSERT INTO dbo.T_CHEQUES_v2 (ID,CEDULA,BENEFICIARIO,MONTO) VALUES
(4,'V88888','OMAR VARGAS', 1.00);
GO

INSERT INTO dbo.T_CHEQUES_v2 (ID,CEDULA,BENEFICIARIO,MONTO) VALUES
(5,'V88888','ZORAIDA BARRIOS', 1.00);
GO

INSERT INTO dbo.T_CHEQUES_v2 (ID,CEDULA,BENEFICIARIO,MONTO) VALUES
(6,'V2232312','IRAMA ABELLO', 1.00);
GO

INSERT INTO dbo.T_CHEQUES_v2 (ID,CEDULA,BENEFICIARIO,MONTO) VALUES
(7,'V2232312','RANDY MONTILLA', 1.00);
GO

create trigger rbtchequesv2
 on dbo.T_CHEQUES_v2
 for  update, delete
as
rollback transaction
go

disable trigger rbtchequesv2 on dbo.T_CHEQUES_v2

enable trigger rbtchequesv2 on dbo.T_CHEQUES_v2

Create Role Cheque

truncate table dbo.T_CHEQUES_v2