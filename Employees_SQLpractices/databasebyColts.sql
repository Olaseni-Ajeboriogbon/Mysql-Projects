create database mydatabase;
show databases;
drop database mydatabase;
drop DATABASE babyname;
show databases;
use hashlock;
show tables;
select * from student_info;
create database cat_app;
show databases;
use cat_app;
create table cats (
Name VARCHAR(100),
Age Int (10)
);
drop table cats;
create table cats (
Name VARCHAR(100),
Age Int
);
show columns from cats;
Desc cats;
show COLUMNS from CATS;
SELECT * from cats;
INSERT INTO Cats( Name, Age ) values( 'numbri', 2 ); 
show columns from cats;
SELECT 
    *
FROM
    cats;
INSERT INTO Cats( Name, Age ) 
values( 'blue', 2),('george', 3),
('manuel', 2), ('close', 4);

-- ToSET DEFAULTS VALUES AND NULL OR NOT NULL
CREATE TABLE Cats2 (
    Name VARCHAR(50) NOT NULL DEFAULT 'Un-Named',
    Age INT NOT NULL DEFAULT 0,
    Location VARCHAR(20) NULL DEFAULT 'Suckor'
);
insert into cats2 (Name, Age, Location) 
values ('sydney', 3, 'cape town'),
('dora' ,2, 'suncity'),
('anastacia', 2, 'monrovia'),
('Olivia', 3, 'congo'),
('auchi',3, 'auckland');

select * from cats2;
insert into cats2 (Name, Age, Location) 
values ('sydney', 3, 'cape town'),
('flora' ,2, ''),
('tucks', 2, ''),
('Olive', 3, 'conjlaw'),
('tuchy',3, 'NULL');
drop table cats2;
insert into cats2 (Name, Age, Location) 
values ('sydney', 3, '' ),
('dora' ,2, 'suncity'),
('anastacia', 2, 'monrovia'),
('Olivia','congo'),
('auchi','auckland'),
('sydney', 3, 'cape town'),
('flora' ,2, ''),
('tucks', 2, ''),
('Olive', 3, 'conjlaw'),
('tuchy',3, 'NULL');
show warnings;
drop table cats2;
DESC cats2;
insert into cats2 (Name, Age, Location) 
values ('sherra', 3, '' ),
('sydney', 3, 'cape town'),
('flora' ,2,''),
('tucks', 2,''),
('Olive', 3, 'conjlaw'),
('tuchy',3,'' );
select * from cats2;
CREATE TABLE Unique_cats (
    cats_id INT NOT NULL AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL,
    Age INT NULL,
    location VARCHAR(20) DEFAULT 'No location',
    PRIMARY KEY (cats_id)
);
desc unique_cats;

insert INTO unique_cats(Name, Age, Location)
 values ('tuchi', 3, '' ),
('duessy', 3, 'cape-town'),
('oddessy' ,2,''),
('kucks', 2,''),
('Oliveria', 3, 'ijaw'),
('toshow',3,'' );

select * from unique_cats;
drop TABLE cats2;
select * from cats;
alter table cats 
add column breed varchar(20) null;

insert into cats(breed)
values('british shorthair'),
('maine coon'),
('persian'),
('short hair'),
('raddoll');

UPDATE cats 
SET 
    breed = 'british shorthair'
WHERE
    name = 'numbri';
    
    UPDATE cats 
SET 
    breed = 'maine coon'
WHERE
    name = 'blue';
    
    UPDATE cats 
SET 
    breed = 'rag doll'
WHERE
    name = 'george';
    
    UPDATE cats 
SET 
    breed = 'persian'
WHERE
    name = 'manuel';
    
    UPDATE cats 
SET 
    breed = 'short hair'
WHERE
    name = 'close';
    
    select * from cats;
    drop table cats;
    drop database cat_app;
    -- /////////////////////////////////////////////////////
    -- exercise CRUD (create,Read,update and delete) shirts_db
    Create database shirts_db;
 show databases;
 use shirts_db;
 
    



