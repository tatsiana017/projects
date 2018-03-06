--------------------------------------------------------------
---------------------------“¿¡À»÷€----------------------------
--------------------------------------------------------------

create table CATEGORY(
id_category int primary key,
type_number varchar2(50),
state_number varchar2(20),
information varchar2(100)
);
 
create table ROOMS(
id_room int primary key,
id_category int, constraint fk_id_cat foreign key(id_category) references CATEGORY(id_category)
);

create table EMPLOYEES(
id_employees int primary key,
fio varchar2(200),
phone_number varchar2(20),
post varchar2(50)
);

create table MINIBAR(
id_product int primary key,
name varchar2(50),
price varchar2(10)
);


create table REGISTRATION(
id_registration int primary key,
id_room int, constraint fk_id_room foreign key(id_room) references ROOMS(id_room),
id_employees int, constraint fk_id_emp foreign key(id_employees) references EMPLOYEES(id_employees),
arrival_date date,
departure_date date,
prepayment varchar2(10)
);

create table ACCOUNT(
id_account int primary key,
id_registration int, constraint fk_id_regis foreign key(id_registration) references REGISTRATION(id_registration),
id_product  int, constraint fk_id_bar foreign key(id_product) references MINIBAR(id_product)
);

create table INDIVIDUAL(
id_client int primary key,
fio varchar2(200),
passport varchar2(100),
phone_number varchar2(20),
id_registration int, constraint fk_id_reg foreign key(id_registration) references REGISTRATION(id_registration)
);

create table ENTITY(
id_company int primary key,
company_name varchar2(100),
adress varchar2(100),
id_registration int, constraint fk_id_reg1 foreign key(id_registration) references REGISTRATION(id_registration)
);

--------------------------------------------------------------
-------------------------œŒÀ‹«Œ¬¿“≈À»-------------------------
--------------------------------------------------------------
create role userrole1;
grant all privileges to userrole1;
grant execute on package_room to userrole1;
grant execute on package_empl to userrole1;
grant execute on package_bar to userrole1;
grant execute on package_services to userrole1;
grant execute on package_entity to userrole1;
grant execute on package_individual to userrole1;
grant create any trigger to userrole1;
grant alter any trigger to userrole1;
drop role userrole1;

create role userrole2;
grant create session,
select any table to userrole2;

select *from dba_roles;

create profile userprof limit
password_life_time 30
sessions_per_user 10
failed_login_attempts 3
password_lock_time 1
password_grace_time default
password_reuse_time 5
connect_time 60
IDLE_time 30;

create profile adminprof limit
password_life_time 3
sessions_per_user 1
failed_login_attempts 3
password_lock_time 1
password_grace_time default
password_reuse_time 5
connect_time 180
IDLE_time 30;
drop profile userprof;

create user UserAdmin1 identified by a12345
profile adminprof;
grant userrole1 to UserAdmin1
grant execute on package_rooms to UserAdmin1;
grant execute on package_account to UserAdmin1;
grant execute on package_regist to UserAdmin1;

drop user UserAdmin1 cascade;
alter user UserAdmin1 identified by a1234;

create user UserN identified by 1234
profile userprof;
grant userrole2 to UserN

select *from all_users

alter table EMPLOYEES modify(fio encrypt using 'AES256');
alter table ENTITY modify(company_name encrypt using 'AES256');
alter table ENTITY modify(adress encrypt using 'AES256');
alter table INDIVIDUAL modify(fio encrypt using 'AES256');
alter table INDIVIDUAL modify(passport encrypt using 'AES256');
