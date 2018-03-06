--view

create view reg_client as 
select REGISTRATION.id_room, INDIVIDUAL.fio from REGISTRATION inner join  INDIVIDUAL on REGISTRATION.id_registration = INDIVIDUAL.id_registration;
select *from system.reg_client;

create view empl_client as 
select EMPLOYEES.fio, ENTITY.company_name from EMPLOYEES inner join REGISTRATION on EMPLOYEES.id_employees = REGISTRATION.id_employees
inner join  ENTITY on REGISTRATION.id_registration = ENTITY.id_registration;
select *from system.empl_client;

create view bar_client as
select MINIBAR.name, INDIVIDUAL.fio from MINIBAR inner join ACCOUNT on MINIBAR.id_product = ACCOUNT.id_product
inner join REGISTRATION on ACCOUNT.id_registration = REGISTRATION.id_registration
inner join INDIVIDUAL on REGISTRATION.id_registration = INDIVIDUAL.id_registration;
select *from system.bar_client;

create view acc_room as
select ACCOUNT.id_account, CATEGORY.id_category, CATEGORY.type_number, CATEGORY.state_number from ACCOUNT 
inner join REGISTRATION on  ACCOUNT.id_registration = REGISTRATION.id_registration
inner join ROOMS on REGISTRATION.id_room = ROOMS.id_room
inner join CATEGORY on ROOMS.id_category = CATEGORY.id_category;
select *from system.acc_room;

create view acc_client as
select ACCOUNT.id_account, ENTITY.company_name from ACCOUNT 
inner join REGISTRATION on ACCOUNT.id_registration = REGISTRATION.id_registration
inner join  ENTITY on REGISTRATION.id_registration = ENTITY.id_registration;
select *from system.acc_client;

create view room_individ as
select CATEGORY.type_number, INDIVIDUAL.fio from CATEGORY inner join ROOMS on CATEGORY.id_category = ROOMS.id_category
inner join REGISTRATION on ROOMS.id_room = REGISTRATION.id_room
inner join INDIVIDUAL on REGISTRATION.id_registration = INDIVIDUAL.id_registration;
select *from system.room_individ;

--procedure
--------------------------------------------------------------
---------------------------INSERT-----------------------------
--------------------------------------------------------------
create or replace procedure add_category
(
id_category1 in system.CATEGORY.id_category%type,
type_number1 in system.CATEGORY.type_number%type,
state_number1 in system.CATEGORY.state_number%type,
information1 in system.CATEGORY.information%type
)
is
begin
insert into system.CATEGORY
values(id_category1, type_number1, state_number1, information1);
end add_category;

begin
add_category(013, 'Дизайнерский люкс', 'свободно', 'info13');
end;

create or replace procedure add_room
(
id_room in system.ROOMS.id_room%type,
id_category in system.ROOMS.id_category%type
)
is
begin
insert into system.ROOMS
values(id_room, id_category);
end add_room;

begin
add_room(009, 009);
end;

create or replace procedure add_employees
(
id_employees in system.EMPLOYEES.id_employees%type,
fio in system.EMPLOYEES.fio%type,
phone_number in system.EMPLOYEES.phone_number%type,
post in system.EMPLOYEES.post%type
)
is
begin
insert into system.EMPLOYEES
values(id_employees, fio, phone_number, post);
end add_employees;

begin
add_employees(009, 'fio9', 'phone9', 'post9');
end;

create or replace procedure add_bar
(
id_product in system.MINIBAR.id_product%type,
name in system.MINIBAR.name%type,
price in system.MINIBAR.price%type
)
is
begin
insert into system.MINIBAR
values(id_product, name, price);
end add_bar;

begin
add_bar(009, 'name9', 'price9');
end;

create or replace procedure add_account
(
id_account in system.ACCOUNT.id_account%type,
id_product in system.ACCOUNT.id_product%type
)
is
begin
insert into system.ACCOUNT
values(id_account, id_product);
end add_account;

create or replace procedure add_regist
(
id_registration in system.REGISTRATION.id_registration%type,
id_room in system.REGISTRATION.id_room%type,
id_employees in system.REGISTRATION.id_employees%type,
arrival_date in system.REGISTRATION.arrival_date%type,
departure_date in system.REGISTRATION.departure_date%type,
prepayment in system.REGISTRATION.prepayment%type,
id_account in system.REGISTRATION.id_account%type
)
is
begin
insert into system.REGISTRATION
values(id_registration, id_room, id_employees, arrival_date, departure_date, prepayment, id_account);
end add_regist;

begin
add_regist(007, 006, 006, '01.03.2017', '10.03.2017', 'sum6', 007);
end;

create or replace procedure add_client
(
id_client in system.CLIENTS.id_client%type,
id_registration in system.CLIENTS.id_registration%type
)
is
begin
insert into system.CLIENTS
values(id_client, id_registration);
end add_client;

begin
add_client(007, 007);
end;

create or replace procedure add_entity
(
id_company in system.ENTITY.id_company%type,
company_name in system.ENTITY.company_name%type,
adress in system.ENTITY.adress%type
)
is
begin
insert into system.ENTITY
values(id_company, company_name, adress);
end add_entity;

begin
add_entity(007, 'company7', 'adress7');
end;

create or replace procedure add_individual
(
id_client in system.INDIVIDUAL.id_client%type,
fio in system.INDIVIDUAL.fio%type,
passport in system.INDIVIDUAL.passport%type,
phone_number in system.INDIVIDUAL.phone_number%type
)
is
begin
insert into system.INDIVIDUAL
values(id_client, fio, passport, phone_number);
end add_individual;
--------------------------------------------------------------
---------------------------DELETE-----------------------------
--------------------------------------------------------------
create or replace procedure del_category(id_category int)
is
begin
  delete from CATEGORY where CATEGORY.id_category=id_category;
  commit;
end del_category;

create or replace procedure del_room(id_room int)
is
begin
  delete from ROOMS where ROOMS.id_room=id_room;
  commit;
end del_room;

create or replace procedure del_employees(id_employees int)
is
begin
  delete from EMPLOYEES where EMPLOYEES.id_employees=id_employees;
  commit;
end del_employees;

create or replace procedure del_bar(id1 int)
is
begin
  delete from MINIBAR where MINIBAR.id_product=id1;
  commit;
end del_bar;

create or replace procedure del_acc(id1 int)
is
begin
  delete from ACCOUNT where ACCOUNT.id_account=id1;
  commit;
end del_acc;

create or replace procedure del_regist(id_registration int)
is
begin
  delete from REGISTRATION where REGISTRATION.id_registration=id_registration;
  commit;
end del_regist;

create or replace procedure del_client(id_client int)
is
begin
  delete from CLIENTS where CLIENTS.id_client=id_client;
  commit;
end del_client;

create or replace procedure del_individual(fio varchar2)
is
begin
  delete from INDIVIDUAL where INDIVIDUAL.fio=fio;
  commit;
end del_individual;

create or replace procedure del_entity(company_name varchar2)
is
begin
  delete from ENTITY where ENTITY.company_name=company_name;
  commit;
end del_entity;


set SERVEROUTPUT ON

--список свободных номеров
declare
procedure get_room(pcode SYSTEM.CATEGORY.state_number%type)
is
cursor gett is select * from SYSTEM.CATEGORY where state_number=pcode;
begin
for xxx in gett
loop
dbms_output.put_line(xxx.id_category||' '||xxx.type_number);
end loop;
end get_room;
begin
get_room('свободно');
end;
--имя клиента
--------------------------------------------------------------
---------------------------SELECT-----------------------------
--------------------------------------------------------------
create or replace procedure get_client(num in system.INDIVIDUAL.id_client%type)
is
name_client varchar(50);
begin
select fio into name_client from system.INDIVIDUAL where system.INDIVIDUAL.id_client=num;
dbms_output.put_line(name_client);
end get_client;
begin 
get_client(3);
end;

create or replace procedure get_client1(num in system.ENTITY.id_company%type)
is
name_client varchar(50);
begin
select company_name into name_client from system.ENTITY where system.ENTITY.id_company=num;
dbms_output.put_line(name_client);
end get_client1;
begin 
get_client1(5);
end get_client1;

create or replace procedure get_employee(num in system.EMPLOYEES.id_employees%type)
is
name_empl varchar(50);
begin
select fio into name_empl from system.EMPLOYEES where system.EMPLOYEES.id_employees=num;
dbms_output.put_line(name_empl);
end get_employee;
begin 
get_employee(5);
end;

create or replace procedure get_bar(num in system.MINIBAR.id_product%type)
is
name_bar varchar(50);
begin
select name into name_bar from system.MINIBAR where system.MINIBAR.id_product=num;
dbms_output.put_line(name_bar);
end get_bar;
begin 
get_bar(5);
end;

create or replace procedure get_room(num in system.CATEGORY.id_category%type)
is
name_room varchar(50);
begin
select type_number into name_room from system.CATEGORY where system.CATEGORY.id_category=num;
dbms_output.put_line(name_room);
end get_room;

--------------------------------------------------------------
-------------------------SELECT ALL---------------------------
--------------------------------------------------------------
create or replace procedure get_all_room
(room_cursor out sys_refcursor)
is
begin
open room_cursor for
select *from system.CATEGORY;
commit;
end get_all_room;

create or replace procedure get_all_bar
(bar_cursor out sys_refcursor)
is
begin
open bar_cursor for
select *from system.MINIBAR;
commit; 
end get_all_bar;

create or replace procedure get_all_empl
(num system.EMPLOYEES.id_employees%type,
empl_cursor out sys_refcursor)
is
begin
open empl_cursor for
select *from system.EMPLOYEES where system.EMPLOYEES.id_employees=num;
commit; 
end get_all_empl;

create or replace procedure get_all_client
(num system.INDIVIDUAL.id_client%type,
client_cursor out sys_refcursor)
is
begin
open client_cursor for
select *from system.INDIVIDUAL where system.INDIVIDUAL.id_client=num;
commit; 
end get_all_client;

create or replace procedure get_all_client1
(client_cursor out sys_refcursor)
is
begin
open client_cursor for
select *from system.ENTITY;
commit; 
end get_all_client1;
set serveroutput on format wrapped;

declare qw sys_refcursor;
q1 number;
q2 varchar(100);
q3 varchar(100);
begin
system.get_all_client1(qw);
loop
exit when qw%notfound;
fetch qw into q1, q2, q3;
dbms_output.enable;
dbms_output.put_line(to_char(q1)||' '||q2||' '||q3);
end loop;
close qw;
end;

--------------------------------------------------------------
---------------------------UPDATE-----------------------------
--------------------------------------------------------------
create or replace procedure upd_category
(
id_category_new in system.CATEGORY.id_category%type,
type_number_new in system.CATEGORY.type_number%type,
state_number_new in system.CATEGORY.state_number%type,
information_new in system.CATEGORY.information%type
)
is 
begin
update CATEGORY set CATEGORY.id_category=id_category_new, 
CATEGORY.type_number=type_number_new,
CATEGORY.state_number=state_number_new,
CATEGORY.information=information_new;
commit;
end upd_category;

create or replace procedure upd_employee
(
id_employees_new in system.EMPLOYEES.id_employees%type,
fio_new in system.EMPLOYEES.fio%type,
phone_number_new in system.EMPLOYEES.phone_number%type,
post_new in system.EMPLOYEES.post%type
)
is 
begin
update EMPLOYEES set EMPLOYEES.id_employees=id_employees_new, 
EMPLOYEES.fio=fio_new,
EMPLOYEES.phone_number=phone_number_new,
EMPLOYEES.post=post_new;
commit;
end upd_employee;

create or replace procedure upd_bar
(
id_product_new in system.MINIBAR.id_product%type,
name_new in system.MINIBAR.name%type,
price_new in system.MINIBAR.price%type
)
is 
begin
update MINIBAR set MINIBAR.id_product=id_product_new, 
MINIBAR.name=name_new,
MINIBAR.price=price_new;
commit;
end upd_bar;

create or replace procedure upd_individual
(
id_client_new in system.INDIVIDUAL.id_client%type,
fio_new in system.INDIVIDUAL.fio%type,
passport_new in system.INDIVIDUAL.passport%type,
phone_number_new in system.INDIVIDUAL.phone_number%type
)
is 
begin
update INDIVIDUAL set INDIVIDUAL.id_client=id_client_new, 
INDIVIDUAL.fio=fio_new,
INDIVIDUAL.passport=passport_new,
INDIVIDUAL.phone_number=phone_number_new;
commit;
end upd_individual;

create or replace procedure upd_entity
(
id_company_new in system.ENTITY.id_company%type,
company_name_new in system.ENTITY.company_name%type,
adress_new in system.ENTITY.adress%type
) 
is 
begin
update ENTITY set ENTITY.id_company=id_company_new, 
ENTITY.company_name=company_name_new,
ENTITY.adress=adress_new;
commit;
end upd_entity;

--------------------------------------------------------------
---------------------------TRIGGER----------------------------
--------------------------------------------------------------
create table TRIGGER_INFO(
user_name varchar2(50),
table_name varchar2(50),
state varchar2(50),
tdt date);
drop table TRIGGER_INFO
select *from system.TRIGGER_INFO;

create or replace trigger TRIGGER_CATEGORY
after insert or delete or update on CATEGORY
declare
begin
if inserting then
insert into TRIGGER_INFO(user_name, table_name, state, tdt)
values(USER, 'CATEGORY', 'insert', SYSDATE);
elsif updating then
insert into TRIGGER_INFO(user_name, table_name, state, tdt)
values(USER, 'CATEGORY', 'update', SYSDATE);
elsif deleting then
insert into TRIGGER_INFO(user_name, table_name, state, tdt)
values(USER, 'CATEGORY', 'delete', SYSDATE);
end if;
end TRIGGER_CATEGORY;

create or replace trigger TRIGGER_ROOM1
after insert or delete or update on ROOMS
declare
begin
if inserting then
insert into TRIGGER_INFO(user_name, table_name, state, tdt)
values(USER, 'ROOMS', 'insert', SYSDATE);
elsif updating then
insert into TRIGGER_INFO(user_name, table_name, state, tdt)
values(USER, 'ROOMS', 'update', SYSDATE);
elsif deleting then
insert into TRIGGER_INFO(user_name, table_name, state, tdt)
values(USER, 'ROOMS', 'delete', SYSDATE);
end if;
end TRIGGER_ROOM1;

create or replace trigger TRIGGER_EMPLOYEES
after insert or delete or update on EMPLOYEES
declare
begin
if inserting then
insert into TRIGGER_INFO(user_name, table_name, state, tdt)
values(USER, 'EMPLOYEES', 'insert', SYSDATE);
elsif updating then
insert into TRIGGER_INFO(user_name, table_name, state, tdt)
values(USER, 'EMPLOYEES', 'update', SYSDATE);
elsif deleting then
insert into TRIGGER_INFO(user_name, table_name, state, tdt)
values(USER, 'EMPLOYEES', 'delete', SYSDATE);
end if;
end TRIGGER_EMPLOYEES;

create or replace trigger TRIGGER_MINIBAR
after insert or delete or update on MINIBAR
declare
begin
if inserting then
insert into TRIGGER_INFO(user_name, table_name, state, tdt)
values(USER, 'MINIBAR', 'insert', SYSDATE);
elsif updating then
insert into TRIGGER_INFO(user_name, table_name, state, tdt)
values(USER, 'MINIBAR', 'update', SYSDATE);
elsif deleting then
insert into TRIGGER_INFO(user_name, table_name, state, tdt)
values(USER, 'MINIBAR', 'delete', SYSDATE);
end if;
end TRIGGER_MINIBAR;

create or replace trigger TRIGGER_ACCOUNT
after insert or delete or update on ACCOUNT
declare
begin
if inserting then
insert into TRIGGER_INFO(user_name, table_name, state, tdt)
values(USER, 'ACCOUNT', 'insert', SYSDATE);
elsif updating then
insert into TRIGGER_INFO(user_name, table_name, state, tdt)
values(USER, 'ACCOUNT', 'update', SYSDATE);
elsif deleting then
insert into TRIGGER_INFO(user_name, table_name, state, tdt)
values(USER, 'ACCOUNT', 'delete', SYSDATE);
end if;
end TRIGGER_ACCOUNT;

create or replace trigger TRIGGER_REGISTRATION
after insert or delete or update on REGISTRATION
declare
begin
if inserting then
insert into TRIGGER_INFO(user_name, table_name, state, tdt)
values(USER, 'REGISTRATION', 'insert', SYSDATE);
elsif updating then
insert into TRIGGER_INFO(user_name, table_name, state, tdt)
values(USER, 'REGISTRATION', 'update', SYSDATE);
elsif deleting then
insert into TRIGGER_INFO(user_name, table_name, state, tdt)
values(USER, 'REGISTRATION', 'delete', SYSDATE);
end if;
end TRIGGER_REGISTRATION;

create or replace trigger TRIGGER_INDIVIDUAL
after insert or delete or update on INDIVIDUAL
declare
begin
if inserting then
insert into TRIGGER_INFO(user_name, table_name, state, tdt)
values(USER, 'INDIVIDUAL', 'insert', SYSDATE);
elsif updating then
insert into TRIGGER_INFO(user_name, table_name, state, tdt)
values(USER, 'INDIVIDUAL', 'update', SYSDATE);
elsif deleting then
insert into TRIGGER_INFO(user_name, table_name, state, tdt)
values(USER, 'INDIVIDUAL', 'delete', SYSDATE);
end if;
end TRIGGER_INDIVIDUAL;

create or replace trigger TRIGGER_ENTITY
after insert or delete or update on system.ENTITY
declare
begin
if inserting then
insert into TRIGGER_INFO(user_name, table_name, state, tdt)
values(USER, 'ENTITY', 'insert', SYSDATE);
elsif updating then
insert into TRIGGER_INFO(user_name, table_name, state, tdt)
values(USER, 'ENTITY', 'update', SYSDATE);
elsif deleting then
insert into TRIGGER_INFO(user_name, table_name, state, tdt)
values(USER, 'ENTITY', 'delete', SYSDATE);
end if;
end TRIGGER_ENTITY;



begin
system.del_bar(10);
end;

begin
system.upd_entity(7, 'name', 'adress7');
end;

select *from system.TRIGGER_INFO;
select *from MINIBAR
delete from table TRIGGER_INFO where user_name='SYSTEM'







