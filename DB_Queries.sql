SET foreign_key_checks =0;
GO

IF OBJECT_ID('dbo.Roles', 'U') IS NOT NULL 
  DROP TABLE dbo.Roles; 
CREATE TABLE [dbo].[Roles]
(
	RoleID INT Constraint PK_Roles PRIMARY KEY,
	Role VARCHAR NOT NULL
)
GO

IF OBJECT_ID('dbo.LoginDetails', 'U') IS NOT NULL 
  DROP TABLE dbo.LoginDetails; 
CREATE TABLE [dbo].[LoginDetails]
(
	Email VARCHAR(100)  Constraint PK_LoginDetails PRIMARY KEY,
	Password VARCHAR(50) NOT NULL,
	RoleID INT Constraint FK_LoginDetails_Roles REFERENCES Roles(RoleID)
)
GO

IF OBJECT_ID('dbo.Customers', 'U') IS NOT NULL 
  DROP TABLE dbo.Customers; 
CREATE TABLE [dbo].[Customers]
(
	CustID INT IDENTITY(100,1) Constraint PK_Customers PRIMARY KEY,
	Email VARCHAR(100) NOT NULL Constraint FK_Customers_LoginDetails REFERENCES LoginDetails(Email),
	Name VARCHAR(150) NOT NULL,
	ContactNumber INT
)
GO

IF OBJECT_ID('dbo.Address', 'U') IS NOT NULL 
  DROP TABLE dbo.Address; 
CREATE TABLE [dbo].[Address]
(
	AddressID INT IDENTITY(1000,1) Constraint PK_Address PRIMARY KEY,
	CustID INT NOT NULL Constraint FK_Address_Customers REFERENCES Customers(CustID),
	Address VARCHAR(250), 
	City VARCHAR(50),
	State VARCHAR(50),
	Country VARCHAR(50),
	Pincode DECIMAL(6,0),
	Landmark VARCHAR(50),
	IsPrimary BIT CONSTRAINT Check_Customers_IsPrimary  CHECK(IsPrimary IN (1,0))
)
GO

IF OBJECT_ID('dbo.Categories', 'U') IS NOT NULL 
  DROP TABLE dbo.Categories; 
CREATE TABLE [dbo].[Categories]
(
	CatID INT IDENTITY(1,1) Constraint PK_Categories PRIMARY KEY,
	CategoryName VARCHAR(150) NOT NULL,
	Description VARCHAR(1000)
)
GO

IF OBJECT_ID('dbo.SubCategories', 'U') IS NOT NULL 
  DROP TABLE dbo.SubCategories; 
CREATE TABLE [dbo].[SubCategories]
(
	SubCatID INT IDENTITY(1,1) Constraint PK_SubCategories PRIMARY KEY,
	SubCategoryName VARCHAR(150) NOT NULL,
	Description VARCHAR(1000)
)
GO

IF OBJECT_ID('dbo.CategoriesSubCategories', 'U') IS NOT NULL 
  DROP TABLE dbo.CategoriesSubCategories; 
CREATE TABLE [dbo].[CategoriesSubCategories]
(
	CatID INT  Constraint FK_CategoriesSubCategories_Categories REFERENCES Categories(CatID),
	SubCatID INT Constraint  FK_CategoriesSubCategories_SubCategories REFERENCES SubCategories(SubCatID)
	Constraint PK_CategoriesSubCategories Primary Key(CatID,SubCatID)
)
GO

IF OBJECT_ID('dbo.Items', 'U') IS NOT NULL 
  DROP TABLE dbo.Items; 
CREATE TABLE [dbo].[Items]
(
	ItemID INT IDENTITY(1,1) Constraint PK_Items PRIMARY KEY,
	CategoryID VARCHAR(100) NOT NULL Constraint FK_Items_LoginDetails REFERENCES LoginDetails(Email),
	Name VARCHAR(150) NOT NULL,
	ContactNumber INT
)
GO










