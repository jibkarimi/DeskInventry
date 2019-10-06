
/*******************************************************************/
/*	JIB Karimi													   */
/*	10/05/19													   */
/*	Project 2													   */
/*																   */
/*******************************************************************/


use master
go

IF DB_ID ('disk_inventoryjk') IS NOT NULL 
	DROP DATABASE disk_inventoryjk
GO

CREATE DATABASE disk_inventoryjk
go

use disk_inventoryjk
go



--create genre table
CREATE TABLE Genre (
	genre_ID int not null identity primary key,
	description varchar(255) not null 
);

--create status table
create table Status (
	status_ID int not null identity primary key,
	description varchar(255) not null 
);



--create type table
create table disk_type (
	disk_type_id int not null identity primary key,
	description varchar(255) not null 
);


--create artist type table
create table artist_type (
	artist_type_id int not null identity primary key,
	description varchar(255) not null 
);


--create borrower table
create table borrower (
	borrower_id int not null identity primary key,
	fname		nvarchar(100) not null,
	lname		nvarchar(100) not null,
	phone_num	nvarchar(50) not null
);

--create artist table
create table artist (
	artist_id int not null identity primary key,
	fname			nvarchar(100) not null,
	lname			nvarchar(100) null,
	artist_type_id 	int not null references artist_type(artist_type_id)
);

--create disk table 
create table disk (
	disk_id 		int not null identity primary key,
	disk_name		nvarchar(100) not null,
	realse_date		date not null,
	genre_id		int not null references genre(genre_id),
	status_id		int not null references status(status_id),
	disk_type_id	int not null references disk_type(disk_type_id)
);

--create diskHasBorrower table
	create table diskHasborrower (
	borrower_id		int not null references borrower(borrower_id),
	disk_id			int not null references disk(disk_id),
	borrowed_date	smalldatetime not null,
	returned_date	smalldatetime null,
	primary key (borrower_id, disk_id, borrowed_date)
	);

-- create diskHasArtist table
create table diskHasArtist (
	--diskHasArtist		int identity not null,
	disk_id				int not null references disk(disk_id),
	artist_id			int not null references artist(artist_id),
);

--create index PK_diskHasArtist on diskHasArtist2(diskHasArtist2);
create index ix_diskHasArtist on diskHasArtist(disk_id, artist_id);


--create login for disk
IF SUSER_ID('diskjk') is null
	create login diskjk WITH PASSWORD = 'MSPress#1',
	DEFAULT_DATABASE = disk_inventoryjk;
--create user for disk
if USER_ID('diskjk') is null
	create user diskjk;
--add permission to user
alter role db_datareader add member diskjk;
go


