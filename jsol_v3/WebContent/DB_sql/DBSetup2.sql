Create table member  (company_id int not null,
name varchar(12) not null,
 birth varchar(13) not null,
 phone varchar(20) not null,
 purpose varchar(10) not null,
 is_sign varchar(5) not null,
 Createtime timestamp not null,
 primary key(phone));

Create table companys(
c_number int not null,
c_name varchar(20) not null,
c_id varchar(15) not null,
c_pw varchar(15) not null,
primary key(c_number)
);

Create table visitor_info(
list_id int not null auto_increment,
Cometime varchar(50),
Name varchar(12) not null,
Birth varchar(13) not null,
Phone varchar(20),
Purpose varchar(20),
Temperature float,
admission_check_flag char(1),
fever_check_flage char(1),
is_sign varchar(10),
Etc varchar(50),
confirm_flag char(1),
company_id int not null,
Primary key(list_id)
);

Insert into companys values(1,"j_solution","wodus1035","1234")


Alter table member add foreign key(company_id) references companys(c_number);
Alter table visitor_info add foreign key(company_id) references companys(c_number);

ALTER TABLE visitor_info ADD COLUMN createtime timestamp;
ALTER TABLE visitor_info ADD COLUMN ips_check_flag char;
ALTER TABLE visitor_info CHANGE COLUMN fever_check_flage fever_check_flag char;
ALTER TABLE visitor_info MODIFY COLUMN birth varchar(13);
ALTER TABLE member MODIFY COLUMN Birth varchar(13);
ALTER TABLE companys ADD COLUMN c_type char;
ALTER TABLE companys ADD COLUMN c_createtime timestamp;
ALTER TABLE companys MODIFY COLUMN c_number int not null;
ALTER TABLE companys drop primary key;
ALTER TABLE companys MODIFY COLUMN c_id varchar(15) primary key;


alter table member add m_number int not null;
alter table member drop primary key;
alter table member add primary key(m_number,phone);
alter table member modify column m_number int auto_increment;


alter table member modify column m_number bigint;

alter table visitor_info add column go_time timestamp;

alter table member drop primary key;
alter table member add primary key(phone);
alter table member add unique key(m_number);

alter table member add column (purposeA varchar(20),purposeB varchar(20),purposeC varchar(20),purposeD varchar(20));
alter table member modify purpose varchar(20) default null;