For running the project you must have MySQL and STS/Eclipse downloaded on your PC. Also your PC must have jdk 1.8 installed and setup.

Link for MySQL:
https://www.microsoft.com/en-us/sql-server/sql-server-downloads

Link for STS:
https://spring.io/tools3/sts/all

Link for Eclipse:
https://www.eclipse.org/downloads/

Steps for installation:
https://www.ics.uci.edu/~pattis/common/handouts/pythoneclipsejava/eclipsejava.html

setting up the jdk:
https://docs.oracle.com/cd/E19182-01/820-7851/inst_cli_jdk_javahome_t/

setting up jdk with eclipse:
https://stackoverflow.com/questions/13635563/setting-jdk-in-eclipse

Once you are done with the installations, you must setup the MySql username/password for the project.
Run the below query in your MySQL workspace:
============================================================

SELECT * FROM dbo.spt_monitor;

SELECT * FROM dbo.FGTransaction;

CREATE TABLE dbo.FGTransaction(
Seq bigint IDENTITY(1,1) NOT NULL,
Warehouse varchar(50) NOT NULL,
ModelNo varchar(50) NOT NULL,
SN varchar(50) NOT NULL,
Quantity int NOT NULL, --positive means in stock; negative means out of stock
TrnTime datetime NOT NULL, --transaction happening timestamp
CONSTRAINT PK_FGTransaction_1 PRIMARY KEY CLUSTERED
(
Seq ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY =
OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY];


SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[FGTransaction] ADD CONSTRAINT [DF_FGTransaction_TrnTime]
DEFAULT (getdate()) FOR [TrnTime]


SELECT Warehouse,ModelNo,SUM(Quantity) 
FROM dbo.FGTransaction 
WHERE Warehouse = 'W1' GROUP by Warehouse,ModelNo;


SELECT 'All' AS Warehouse,ModelNo,SUM(Quantity) 
FROM dbo.FGTransaction GROUP by ModelNo;

==========================================================================

After these are setup:
Go to the application.properties file in the project files and change the following lines by providing your credentials:

server.port = 8090
server.servlet.context-path = /system

=========change the below lines after the "="sign in your application.properties file.==================

spring.datasource.url = jdbc:sqlserver://localhost:1433
spring.datasource.username = SA
spring.datasource.password = Nish2018!

==========================================================================
spring.datasource.driver-class-name = com.microsoft.sqlserver.jdbc.SQLServerDriver
spring.jpa.properties.hibernate.dialect = org.hibernate.dialect.SQLServerDialect

spring.mvc.view.prefix = /WEB-INF/jsp
spring.mvc.view.suffix = .jsp
spring.mvc.static-path-pattern = /**

You are all setup to run the project. Right click on the project and select runas and then select the springbootapplication option.