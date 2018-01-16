-- drop table scott.control_list;

create table scott.control_list
(filename varchar2(30 byte));

insert into control_list(filename) values ('Payments_20130101.csv');
commit;