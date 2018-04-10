create database inventory;
use inventory;
CREATE TABLE inventory (host VARCHAR(50), web CHAR(1), app CHAR(1), db CHAR(1), other CHAR(1));
insert into inventory values ('webaza', '1','0','0','0');
insert into inventory values ('webazb', '1','0','0','0');

insert into inventory values ('appaza', '0','1','0','0');
insert into inventory values ('appazb', '0','1','0','0');

insert into inventory values ('dbaza', '0','0','1','0');
insert into inventory values ('dbazb', '0','0','1','0');

insert into inventory values ('zabbix', '0','0','0','1');
