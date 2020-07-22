Create table visitor_info_w(
	v_number int(5) auto_increment not null,
	Date date not null,
	entry_time time not null,
	exit_time time,
	Name varchar(10) not null,
	Birth_D int(6) not null,
	Tel int(11) not null,
	Visit_category varchar(10) not null,
	temperature float(10),
	Travel varchar(3),
	Other_hospital varchar(3),
	accept varchar(3),
	etc varchar(15),
	reference varchar(15),
	primary key(v_number)
);
Alter table visitor_info_w change column v_number list_id int auto_increment;
ALTER TABLE visitor_info_w MODIFY COLUMN list_id int auto_increment not null;
ALTER TABLE visitor_info_w CHANGE COLUMN Date createtime TIMESTAMP;
ALTER TABLE visitor_info_w MODIFY COLUMN createtime TIMESTAMP not NULL;
ALTER TABLE visitor_info_w CHANGE COLUMN entry_time cometime VARCHAR(50);
ALTER TABLE visitor_info_w CHANGE COLUMN exit_time gotime VARCHAR(50);
ALTER TABLE visitor_info_w CHANGE COLUMN Birth_D birth VARCHAR(50);
ALTER TABLE visitor_info_w CHANGE COLUMN Tel phone VARCHAR(50);
ALTER TABLE visitor_info_w CHANGE COLUMN Visit_category purpose VARCHAR(50);
ALTER TABLE visitor_info_w CHANGE COLUMN Travel ips_check_flag CHAR;
ALTER TABLE visitor_info_w CHANGE COLUMN Other_hospital admission_check_flag CHAR;
ALTER TABLE visitor_info_w CHANGE COLUMN accept is_sign VARCHAR(50);
ALTER TABLE visitor_info_w MODIFY COLUMN birth VARCHAR(50);
ALTER TABLE visitor_info_w ADD COLUMN fever_check_flag CHAR AFTER admission_check_flag;
ALTER TABLE visitor_info_w ADD COLUMN confirm_flag CHAR;
