-- This generates a random password, defaulting to 10 characters
CREATE procedure [dbo].[GetPass]
 @passlen int = 10, @charset int = 2 -- 2 is alphanumeric + special characters,
,@MyPassword  varchar(8000) output	
 -- 1 is alphanumeric, 0 is alphabetical only
as
set nocount on
if (@passlen > 8000 or @passlen < 1) -- Let's not go crazy here
 select @passlen = 10

declare @password varchar(8000), @string varchar(256), @numbers varchar(10), @extra varchar(50),
 @stringlen int, @index int

-- no 1, l, I, 0, O which can cause confusion
select @string = 'ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz' -- same as @charset = 0
select @numbers = '23456789'
select @extra = '">_!@#$%&=?<>' -- add more special characters if you want


if @charset = 2
 select @string = @string + @numbers + @extra
else if @charset = 1
 select @string = @string + @numbers
-- else assume @extra is 0 and @string is just letters. Feel free to modify these criteria as you see fit

select @stringlen = len(@string)

select @password = ''

while (@passlen > 0)
begin
 -- For the random part here, use rand() or newid()
 select @index = (abs(checksum(newid())) % @stringlen) + 1
 select @password = @password + substring(@string, @index, 1)
 select @passlen = @passlen - 1
end
set @MyPassword=@password
select @password AS Clave
