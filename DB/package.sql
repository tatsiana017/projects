set serveroutput on;
--------------------------CATEGORY--------------------
create sequence seq_room start with 1 nomaxvalue;
create or replace trigger trigger_room
before insert on system.CATEGORY
for each row
begin
select seq_room.nextval into :new.id_category from dual;
end;

create or replace package package_room
is
procedure add_category(
type_number1 in system.CATEGORY.type_number%type,
state_number1 in system.CATEGORY.state_number%type,
information1 in system.CATEGORY.information%type);
procedure del_category(id_category1 int);
procedure upd_category(id_category_new in system.CATEGORY.id_category%type,
type_number_new in system.CATEGORY.type_number%type,
state_number_new in system.CATEGORY.state_number%type,
information_new in system.CATEGORY.information%type);
procedure get_room (num in system.CATEGORY.id_category%type);
procedure get_all_room (room_cursor out sys_refcursor);
end package_room;

create or replace package body package_room
is
procedure add_category
(
type_number1 in system.CATEGORY.type_number%type,
state_number1 in system.CATEGORY.state_number%type,
information1 in system.CATEGORY.information%type
)
is
begin
insert into system.CATEGORY(type_number, state_number, information)
values(type_number1, state_number1, information1);
commit;
end add_category;
procedure del_category(id_category1 int)
is
begin
  delete from system.CATEGORY where system.CATEGORY.id_category=id_category1;
  commit;
end del_category;
procedure upd_category
(
id_category_new in system.CATEGORY.id_category%type,
type_number_new in system.CATEGORY.type_number%type,
state_number_new in system.CATEGORY.state_number%type,
information_new in system.CATEGORY.information%type
)
is 
begin
update system.CATEGORY set system.CATEGORY.id_category=id_category_new, 
system.CATEGORY.type_number=type_number_new,
system.CATEGORY.state_number=state_number_new,
system.CATEGORY.information=information_new
where CATEGORY.id_category=id_category_new;
commit;
end upd_category;
procedure get_room(num in system.CATEGORY.id_category%type)
is
name_room varchar(50);
begin
select type_number into name_room from system.CATEGORY where system.CATEGORY.id_category=num;
dbms_output.put_line(name_room);
end get_room;
procedure get_all_room
(room_cursor out sys_refcursor)
is
begin
open room_cursor for
select *from system.CATEGORY;
commit;
end get_all_room;
end package_room;
--------------------------ROOMS--------------------
create sequence seq_rooms start with 1 nomaxvalue;
create or replace trigger trigger_rooms
before insert on system.ROOMS
for each row
begin
select seq_rooms.nextval into :new.id_room from dual;
end;

create or replace package package_rooms
is
procedure add_rooms(id_category in system.ROOMS.id_category%type);
procedure del_rooms(id1 int);
procedure get_rooms(num in system.ROOMS.id_room%type);
procedure get_all_rooms(rooms_cursor out sys_refcursor);
procedure upd_rooms(id_room_new in system.ROOMS.id_room%type,
id_category_new in system.ROOMS.id_category%type);
end package_rooms;

create or replace package body package_rooms
is
procedure add_rooms(id_category in system.ROOMS.id_category%type)
is
begin
insert into system.ROOMS(id_category)
values(id_category);
end add_rooms;
procedure del_rooms(id1 int)
is
begin
  delete from ROOMS where ROOMS.id_room=id1;
  commit;
end del_rooms;
procedure get_rooms(num in system.ROOMS.id_room%type)
is
id_cat int;
begin
select id_category into id_cat from system.ROOMS where system.ROOMS.id_room=num;
dbms_output.put_line(id_cat);
end get_rooms;
procedure get_all_rooms(rooms_cursor out sys_refcursor)
is
begin
open rooms_cursor for
select *from system.ROOMS;
commit;
end get_all_rooms;
procedure upd_rooms
(id_room_new in system.ROOMS.id_room%type,
id_category_new in system.ROOMS.id_category%type
)
is 
begin
update ROOMS set ROOMS.id_room=id_room_new, 
ROOMS.id_category=id_category_new where ROOMS.id_room=id_room_new;
commit;
end upd_rooms;
end package_rooms;
--------------------------EMPLOYEES--------------------
create sequence seq_empl start with 1 nomaxvalue;
create or replace trigger trigger_empl
before insert on system.EMPLOYEES
for each row
begin
select seq_empl.nextval into :new.id_employees from dual;
end;

create or replace package package_empl
is
procedure add_employees(
fio1 in system.EMPLOYEES.fio%type,
phone_number1 in system.EMPLOYEES.phone_number%type,
post1 in system.EMPLOYEES.post%type);
procedure del_employees(id_employees1 int);
procedure upd_employee(id_employees_new in system.EMPLOYEES.id_employees%type,
fio_new in system.EMPLOYEES.fio%type,
phone_number_new in system.EMPLOYEES.phone_number%type,
post_new in system.EMPLOYEES.post%type);
procedure get_employee(num in system.EMPLOYEES.id_employees%type);
procedure get_all_empl(num system.EMPLOYEES.id_employees%type, empl_cursor out sys_refcursor);
end package_empl;

create or replace package body package_empl
is
procedure add_employees
(
fio1 in system.EMPLOYEES.fio%type,
phone_number1 in system.EMPLOYEES.phone_number%type,
post1 in system.EMPLOYEES.post%type
)
is
begin
insert into system.EMPLOYEES(fio, phone_number, post)
values(fio1, phone_number1, post1);
end add_employees;
procedure del_employees(id_employees1 int)
is
begin
  delete from EMPLOYEES where EMPLOYEES.id_employees=id_employees1;
  commit;
end del_employees;
procedure upd_employee
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
EMPLOYEES.post=post_new
where EMPLOYEES.id_employees=id_employees_new;
commit;
end upd_employee;
procedure get_employee(num in system.EMPLOYEES.id_employees%type)
is
name_empl varchar(50);
begin
select fio into name_empl from system.EMPLOYEES where system.EMPLOYEES.id_employees=num;
dbms_output.put_line(name_empl);
end get_employee;
procedure get_all_empl
(num system.EMPLOYEES.id_employees%type,
empl_cursor out sys_refcursor)
is
begin
open empl_cursor for
select *from system.EMPLOYEES where system.EMPLOYEES.id_employees=num;
commit; 
end get_all_empl;
end package_empl;
--------------------------MINIBAR--------------------
create sequence seq_bar start with 1 nomaxvalue;
create or replace trigger trigger_bar
before insert on system.MINIBAR
for each row
begin
select seq_bar.nextval into :new.id_product from dual;
end;

create or replace package package_bar
is
procedure add_bar(
name1 in system.MINIBAR.name%type,
price1 in system.MINIBAR.price%type);
procedure del_bar(id_product1 int);
procedure upd_bar(id_product_new in system.MINIBAR.id_product%type,
name_new in system.MINIBAR.name%type,
price_new in system.MINIBAR.price%type);
procedure get_bar(num in system.MINIBAR.id_product%type);
procedure get_all_bar(bar_cursor out sys_refcursor);
end package_bar;

create or replace package body package_bar
is
procedure add_bar
(
name1 in system.MINIBAR.name%type,
price1 in system.MINIBAR.price%type
)
is
begin
insert into system.MINIBAR(name, price)
values(name1, price1);
end add_bar;
procedure del_bar(id_product1 int)
is
begin
  delete from MINIBAR where id_product=id_product1;
  commit;
end del_bar;
procedure upd_bar
(
id_product_new in system.MINIBAR.id_product%type,
name_new in system.MINIBAR.name%type,
price_new in system.MINIBAR.price%type
)
is 
begin
update MINIBAR set MINIBAR.id_product=id_product_new, 
MINIBAR.name=name_new,
MINIBAR.price=price_new
where MINIBAR.id_product=id_product_new;
commit;
end upd_bar;
procedure get_bar(num in system.MINIBAR.id_product%type)
is
name_bar varchar(50);
begin
select name into name_bar from system.MINIBAR where system.MINIBAR.id_product=num;
dbms_output.put_line(name_bar);
end get_bar;
procedure get_all_bar
(bar_cursor out sys_refcursor)
is
begin
open bar_cursor for
select *from system.MINIBAR;
commit; 
end get_all_bar;
end package_bar;
--------------------------ACCOUNT--------------------
create sequence seq_acc start with 1 nomaxvalue;
create or replace trigger trigger_acc
before insert on system.ACCOUNT
for each row
begin
select seq_acc.nextval into :new.id_account from dual;
end;

create or replace package package_account
is
procedure add_account(id_registration in system.ACCOUNT.id_registration%type,
id_product in system.ACCOUNT.id_product%type);
procedure del_acc(id1 int);
procedure get_acc(num in system.ACCOUNT.id_account%type);
procedure get_all_acc(acc_cursor out sys_refcursor);
procedure upd_acc(id_account_new in system.ACCOUNT.id_account%type,
id_registration_new in system.ACCOUNT.id_registration%type,
id_product_new in system.ACCOUNT.id_product%type);
end package_account;

create or replace package body package_account
is
procedure add_account(id_registration in system.ACCOUNT.id_registration%type,
id_product in system.ACCOUNT.id_product%type)
is
begin
insert into system.ACCOUNT(id_registration, id_product)
values(id_registration, id_product);
end add_account;
procedure del_acc(id1 int)
is
begin
  delete from ACCOUNT where ACCOUNT.id_account=id1;
  commit;
end del_acc;
procedure get_acc(num in system.ACCOUNT.id_account%type)
is
id_bar int;
begin
select id_product into id_bar from system.ACCOUNT where system.ACCOUNT.id_account=num;
dbms_output.put_line(id_bar);
end get_acc;
procedure get_all_acc
(acc_cursor out sys_refcursor)
is
begin
open acc_cursor for
select *from system.ACCOUNT;
commit;
end get_all_acc;
procedure upd_acc
(
id_account_new in system.ACCOUNT.id_account%type,
id_registration_new in system.ACCOUNT.id_registration%type,
id_product_new in system.ACCOUNT.id_product%type
)
is 
begin
update ACCOUNT set ACCOUNT.id_account=id_account_new, 
ACCOUNT.id_registration=id_registration_new, 
ACCOUNT.id_product=id_product_new where  ACCOUNT.id_account=id_account_new;
commit;
end upd_acc;
end package_account;

--------------------------REGISTRATION--------------------
create sequence seq_regist start with 1 nomaxvalue;
create or replace trigger trigger_regist
before insert on system.REGISTRATION
for each row
begin
select seq_regist.nextval into :new.id_registration from dual;
end;

create or replace package package_regist
is
procedure add_regist(id_room1 in system.REGISTRATION.id_room%type,
id_employees1 in system.REGISTRATION.id_employees%type,
arrival_date1 in system.REGISTRATION.arrival_date%type,
departure_date1 in system.REGISTRATION.departure_date%type,
prepayment1 in system.REGISTRATION.prepayment%type);
procedure del_regist(id_registration1 int);
procedure get_regist(num in system.REGISTRATION.id_registration%type);
procedure get_all_regist(regist_cursor out sys_refcursor);
procedure upd_regist(id_registration_new in system.REGISTRATION.id_registration%type,
id_room_new in system.REGISTRATION.id_room%type,
id_employees_new in system.REGISTRATION.id_employees%type,
arrival_date_new in system.REGISTRATION.arrival_date%type,
departure_date_new in system.REGISTRATION.departure_date%type,
prepayment_new in system.REGISTRATION.prepayment%type);
end package_regist;

create or replace package body package_regist
is
procedure add_regist
(
id_room1 in system.REGISTRATION.id_room%type,
id_employees1 in system.REGISTRATION.id_employees%type,
arrival_date1 in system.REGISTRATION.arrival_date%type,
departure_date1 in system.REGISTRATION.departure_date%type,
prepayment1 in system.REGISTRATION.prepayment%type
)
is
begin
insert into system.REGISTRATION(id_room, id_employees, arrival_date, departure_date, prepayment)
values(id_room1, id_employees1, arrival_date1, departure_date1, prepayment1);
end add_regist;
procedure del_regist(id_registration1 int)
is
begin
  delete from REGISTRATION where REGISTRATION.id_registration=id_registration1;
  commit;
end del_regist;
procedure get_regist(num in system.REGISTRATION.id_registration%type)
is
plata varchar(10);
begin
select prepayment into plata from system.REGISTRATION where system.REGISTRATION.id_registration=num;
dbms_output.put_line(plata);
end get_regist;
procedure get_all_regist
(regist_cursor out sys_refcursor)
is
begin
open regist_cursor for
select *from system.REGISTRATION;
commit;
end get_all_regist;
procedure upd_regist
(
id_registration_new in system.REGISTRATION.id_registration%type,
id_room_new in system.REGISTRATION.id_room%type,
id_employees_new in system.REGISTRATION.id_employees%type,
arrival_date_new in system.REGISTRATION.arrival_date%type,
departure_date_new in system.REGISTRATION.departure_date%type,
prepayment_new in system.REGISTRATION.prepayment%type
)
is 
begin
update REGISTRATION set REGISTRATION.id_registration=id_registration_new, 
REGISTRATION.id_room=id_room_new,
REGISTRATION.id_employees=id_employees_new,
REGISTRATION.arrival_date=arrival_date_new,
REGISTRATION.departure_date=departure_date_new,
REGISTRATION.prepayment=prepayment_new 
where REGISTRATION.id_registration=id_registration_new;
commit;
end upd_regist;
end package_regist;
--------------------------INDIVIDUAL--------------------
create sequence seq_individ start with 1 nomaxvalue;
create or replace trigger trigger_individ
before insert on system.INDIVIDUAL
for each row
begin
select seq_individ.nextval into :new.id_client from dual;
end;

create or replace package package_individual
is
procedure add_individual(
fio1 in system.INDIVIDUAL.fio%type,
passport1 in system.INDIVIDUAL.passport%type,
phone_number1 in system.INDIVIDUAL.phone_number%type,
id_registration1 in system.INDIVIDUAL.id_registration%type);
procedure del_individual(id_client1 int);
procedure upd_individual(id_client_new in system.INDIVIDUAL.id_client%type,
fio_new in system.INDIVIDUAL.fio%type,
passport_new in system.INDIVIDUAL.passport%type,
phone_number_new in system.INDIVIDUAL.phone_number%type,
id_registration_new in system.INDIVIDUAL.id_registration%type);
procedure get_client(num in system.INDIVIDUAL.id_client%type);
procedure get_all_client(num system.INDIVIDUAL.id_client%type,
client_cursor out sys_refcursor);
end package_individual;

create or replace package body package_individual
is
procedure add_individual
(
fio1 in system.INDIVIDUAL.fio%type,
passport1 in system.INDIVIDUAL.passport%type,
phone_number1 in system.INDIVIDUAL.phone_number%type,
id_registration1 in system.INDIVIDUAL.id_registration%type
)
is
begin
insert into system.INDIVIDUAL(fio, passport, phone_number, id_registration)
values(fio1, passport1, phone_number1, id_registration1);
end add_individual;
procedure del_individual(id_client1 int)
is
begin
  delete from INDIVIDUAL where INDIVIDUAL.id_client=id_client1;
  commit;
end del_individual;
procedure upd_individual
(
id_client_new in system.INDIVIDUAL.id_client%type,
fio_new in system.INDIVIDUAL.fio%type,
passport_new in system.INDIVIDUAL.passport%type,
phone_number_new in system.INDIVIDUAL.phone_number%type,
id_registration_new in system.INDIVIDUAL.id_registration%type
)
is 
begin
update system.INDIVIDUAL set system.INDIVIDUAL.id_client=id_client_new, 
system.INDIVIDUAL.fio=fio_new,
system.INDIVIDUAL.passport=passport_new,
system.INDIVIDUAL.phone_number=phone_number_new,
system.INDIVIDUAL.id_registration=id_registration_new
where INDIVIDUAL.id_client=id_client_new;
commit;
end upd_individual;
procedure get_client(num in system.INDIVIDUAL.id_client%type)
is
name_client varchar(50);
begin
select fio into name_client from system.INDIVIDUAL where system.INDIVIDUAL.id_client=num;
dbms_output.put_line(name_client);
end get_client;
procedure get_all_client
(num system.INDIVIDUAL.id_client%type,
client_cursor out sys_refcursor)
is
begin
open client_cursor for
select *from system.INDIVIDUAL where system.INDIVIDUAL.id_client=num;
commit; 
end get_all_client;
end package_individual;

--------------------------ENTITY--------------------
create sequence seq_entity start with 1 nomaxvalue;
create or replace trigger trigger_ent
before insert on system.ENTITY
for each row
begin
select seq_entity.nextval into :new.id_company from dual;
end;

create or replace package package_entity
is
procedure add_entity(
company_name1 in system.ENTITY.company_name%type,
adress1 in system.ENTITY.adress%type,
id_registration1 in system.ENTITY.id_registration%type);
procedure del_entity(id_company1 int);
procedure upd_entity(id_company_new in system.ENTITY.id_company%type,
company_name_new in system.ENTITY.company_name%type,
adress_new in system.ENTITY.adress%type,
id_registration_new in system.ENTITY.id_registration%type);
procedure get_client1(num in system.ENTITY.id_company%type);
procedure get_all_client1(client_cursor out sys_refcursor);
end package_entity;

create or replace package body package_entity
is
procedure add_entity
(
company_name1 in system.ENTITY.company_name%type,
adress1 in system.ENTITY.adress%type,
id_registration1 in system.ENTITY.id_registration%type
)
is
begin
insert into system.ENTITY(company_name, adress, id_registration)
values(company_name1, adress1, id_registration1);
end add_entity;
procedure del_entity(id_company1 int)
is
begin
  delete from ENTITY where ENTITY.id_company=id_company1;
  commit;
end del_entity;
procedure upd_entity
(
id_company_new in system.ENTITY.id_company%type,
company_name_new in system.ENTITY.company_name%type,
adress_new in system.ENTITY.adress%type,
id_registration_new in system.ENTITY.id_registration%type
)
is 
begin
update ENTITY set ENTITY.id_company=id_company_new, 
ENTITY.company_name=company_name_new,
ENTITY.adress=adress_new,
ENTITY.id_registration=id_registration_new where ENTITY.id_company=id_company_new;
commit;
end upd_entity;
procedure get_client1(num in system.ENTITY.id_company%type)
is
name_client varchar(50);
begin
select company_name into name_client from system.ENTITY where system.ENTITY.id_company=num;
dbms_output.put_line(name_client);
end get_client1;
procedure get_all_client1
(client_cursor out sys_refcursor)
is
begin
open client_cursor for
select *from system.ENTITY;
commit; 
end get_all_client1;
end package_entity;


drop package package_room;
drop package package_bar;
drop package package_services;
drop package package_entity;
drop package package_individual;
drop package package_empl;


set serveroutput on format wrapped;
declare qw sys_refcursor;
q1 number;
q2 varchar(100);
q3 varchar(100);
begin
system.package_bar.get_all_bar(qw);
loop
exit when qw%notfound;
fetch qw into q1, q2, q3;
dbms_output.enable;
dbms_output.put_line(to_char(q1)||' '||q2||' '||q3);
end loop;
close qw;
end;








create or replace trigger delete_registr
before delete on REGISTRATION
referencing old as oldrow
for each row
begin
delete from ENTITY where id_registration=:oldrow.id_registration;
delete from INDIVIDUAL where id_registration=:oldrow.id_registration;
delete from ACCOUNT where id_registration=:oldrow.id_registration;
end;
create or replace trigger delete_rooms
before delete on ROOMS
referencing old as oldrow
for each row
begin
delete from REGISTRATION where id_room=:oldrow.id_room;
end;
create or replace trigger delete_category
before delete on CATEGORY
referencing old as oldrow
for each row
begin
update ROOMS set id_category=null where id_category=:oldrow.id_category;
end;
create or replace trigger delete_employees
before delete on EMPLOYEES
referencing old as oldrow
for each row
begin
update REGISTRATION set id_employees=null where id_employees=:oldrow.id_employees;
end;
create or replace trigger delete_account
before delete on ACCOUNT
referencing old as oldrow
for each row
begin
delete from REGISTRATION where id_account=:oldrow.id_account;
end;
create or replace trigger delete_minibar
before delete on MINIBAR
referencing old as oldrow
for each row
begin
update  ACCOUNT set id_product=null where id_product=:oldrow.id_product;
end;









begin
system.package_room.add_category('Президентский номер', 'занято', 'info1');
system.package_room.add_category('Президентский номер', 'свободно', 'info2');
system.package_room.add_category('Дизайнерский люкс', 'занято', 'info3');
system.package_room.add_category('Дизайнерский люкс', 'свободно', 'info4');
system.package_room.add_category('Люкс', 'занято', 'info5');
system.package_room.add_category('Люкс', 'занято', 'info6');
system.package_room.add_category('Клубный номер', 'свободно', 'info7');
system.package_room.add_category('Клубный номер', 'занято', 'info8');
system.package_room.add_category('Стандарт одноместный', 'занято', 'info9');
system.package_room.add_category('Стандарт одноместный', 'свободно', 'info10');
system.package_room.add_category('Стандарт двухместный с 1 кроватью', 'свободно', 'info11');
system.package_room.add_category('Стандарт двухместный с 1 кроватью', 'свободно', 'info12');
system.package_room.add_category('Стандарт двухместный с 2 кроватью', 'занято', 'info13');
system.package_room.add_category('Стандарт двухместный с 2 кроватью', 'свободно', 'info14');
end;
select *from system.CATEGORY;
begin
system.package_room.del_category(12);
end;

begin
system.package_empl.add_employees('Бакиев А.Р.', '123456', 'post1');
system.package_empl.add_employees('Бажежа Е.Д.', '465123', 'post2');
system.package_empl.add_employees('Буц Е.Ю.', '451236', 'post3');
system.package_empl.add_employees('Гуцу П.В.', '235689', 'post4');
system.package_empl.add_employees('Котельников А.С.', '124565', 'post5');
system.package_empl.add_employees('Ли В.В.', '785644', 'post6');
system.package_empl.add_employees('Михнюк А.В.', '111111', 'post8');
system.package_empl.add_employees('Михоленко О.С.', '222222', 'post9');
system.package_empl.add_employees('Сущеня А.В.', '333333', 'post10');
system.package_empl.add_employees('Яблонин А.Н.', '444444', 'post11');
system.package_empl.add_employees('Ярмошук А.С.', '555555', 'post12');
end;
select *from system.EMPLOYEES;
begin
system.package_empl.del_employees(9);
end;

begin
system.package_bar.add_bar('Шотландский виски', '150$');
system.package_bar.add_bar('Ирландский виски "Kilbeggan Distillery"', '250$');
system.package_bar.add_bar('Коньяк "Hennessy"', '250$');
system.package_bar.add_bar('Бурбон "Jim Beam"', '150$');
system.package_bar.add_bar('Вермут "Bacardi" ', '100$');
system.package_bar.add_bar('Красное вино "Pinot noir"', '150$');
system.package_bar.add_bar('Красное вино "Cabernet Sauvignon"', '150$');
system.package_bar.add_bar('Белое вино "Sauvignon blanc"', '100$');
system.package_bar.add_bar('Белое вино "Chenin blanc"', '150$');
system.package_bar.add_bar('Ром "Ron Barcel?"', '150$');
end;
select *from system.MINIBAR;
begin
system.package_bar.del_bar(12);
end;

begin
system.package_rooms.add_rooms(1);
system.package_rooms.add_rooms(3);
system.package_rooms.add_rooms(5);
system.package_rooms.add_rooms(6);
system.package_rooms.add_rooms(8);
system.package_rooms.add_rooms(9);
system.package_rooms.add_rooms(13);
end;
select *from system.ROOMS;
begin
system.package_rooms.del_rooms(3);
end;

begin
system.package_regist.add_regist(1, 2, '01.01.2017', '10.01.2017', 'sum1');
system.package_regist.add_regist(2, 3, '01.01.2017', '10.01.2017', 'sum2');
system.package_regist.add_regist(3, 11, '01.01.2017', '10.01.2017', 'sum3');
system.package_regist.add_regist(4, 2, '01.01.2017', '10.01.2017', 'sum4');
system.package_regist.add_regist(5, 10, '01.01.2017', '10.01.2017', 'sum5');
system.package_regist.add_regist(6, 9, '01.01.2017', '10.01.2017', 'sum6');
system.package_regist.add_regist(7, 9, '01.01.2017', '10.01.2017', 'sum7');
end;
select *from system.REGISTRATION;
begin
system.package_regist.del_regist(7);
end;

begin
system.package_individual.add_individual('fio1', 'passport1', 'phone1',1);
system.package_individual.add_individual('fio2', 'passport2', 'phone2',2);
system.package_individual.add_individual('fio3', 'passport3', 'phone3',3);
system.package_individual.add_individual('fio4', 'passport4', 'phone4',4);
end;
select *from system.INDIVIDUAL;

begin
system.package_entity.add_entity('company name1', 'adress1', 5);
system.package_entity.add_entity('company name2', 'adress2', 6);
system.package_entity.add_entity('company name3', 'adress3', 7);
end;
select *from system.ENTITY;

begin
system.package_account.add_account(1, 6);
system.package_account.add_account(1, 12);
system.package_account.add_account(1, 8);
system.package_account.add_account(2, 6);
system.package_account.add_account(3, 15);
system.package_account.add_account(4, 12);
system.package_account.add_account(5, 6);
system.package_account.add_account(5, 10);
system.package_account.add_account(6, 7);
system.package_account.add_account(7, 10);
end;
select *from system.ACCOUNT;
begin
system.package_account.del_acc(12);
end;