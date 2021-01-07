--if table exists drop and create a new table
If (Exists (Select *
			From INFORMATION_SCHEMA.tables
			Where TABLE_NAME = 'tblProductSales'))
Begin
	Drop Table tblProductSales
End

If (Exists (Select *
			From INFORMATION_SCHEMA.tables
			Where TABLE_NAME = 'tblProducts'))
Begin
	Drop Table tblProducts
End

Create Table tblProducts
(
	Id int Identity Primary Key,
	Name nvarchar(50),
	Descriptions nvarchar(250)
)

Create Table tblProductSales
(
	Id int Identity Primary Key,
	ProductId int Foreign Key References tblProducts(Id),
	UnitPrice int,
	QuantitySold int,
)

--inserting the Sample data into tblProducts table

Declare @Id int
Set @Id = 1

While (@Id <= 10000)
Begin
	Insert into tblProducts values('Product - ' + CAST(@Id as nvarchar(50)),
	'Product - ' + CAST(@Id as nvarchar(20)) + ' Description')
	
	Print @Id
	Set @Id = @Id + 1
End

-- Declare variables to hold a randon ProductId, Unitprice and QuantitySold

Declare @RandomProductId int
Declare @RandomUnitPrice int
Declare @RandomQuantitySold int

--Declare and set variables to generate a random ProductId between 1 and 10000

Declare @UpperLimitForPID int
Declare @LowerLimitForPID int

Set @LowerLimitForPID = 1
Set @UpperLimitForPID = 9000

--Declare and set variables to generate a random UnitPrice between 1 and 100

Declare @UpperLimitForUP int
Declare @LowerLimitForUP int

Set @LowerLimitForUP = 1
Set @UpperLimitForUP = 100

--Declare and set variables to generate a random QuantitySold between 1 to 10

Declare @UpperLimitForQS int
Declare @LowerLimitForQS int

Set @LowerLimitForQS = 1
Set @UpperLimitForQS = 10

--Inserting Sample Data into tblProductSales table 

Declare @Counter int 
Set @Counter = 1

While (@Counter <= 15000)
Begin
	Select @RandomProductId = Round(((@UpperLimitForPID - @LowerLimitForPID) * Rand() + @LowerLimitForPID), 0)
	Select @RandomUnitPrice = Round(((@UpperLimitForUP - @LowerLimitForUP) * Rand() + @LowerLimitForUP), 0)
	Select @RandomQuantitySold = Round(((@UpperLimitForQS - @LowerLimitForQS) * Rand() + @LowerLimitForQS), 0)

	Insert into tblProductSales
	Values(@RandomProductId, @RandomUnitPrice, @RandomQuantitySold)

	Print @Counter
	Set @Counter = @Counter + 1
End

Select * From tblProducts
Select * From tblProductSales
