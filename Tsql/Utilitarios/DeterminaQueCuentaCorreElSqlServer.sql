
declare @sqlser varchar(20)

EXEC master..xp_regread @rootkey='HKEY_LOCAL_MACHINE', @key='SYSTEM\CurrentControlSet\Services\MSSQLSERVER',

@value_name='objectname', @value=@sqlser OUTPUT

PRINT 'Account Starting SQL Server Service:' +convert(varchar(30),@sqlser) 