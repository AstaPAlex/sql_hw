--Создать скрипт генерирующий схему application
CREATE SCHEMA IF NOT EXISTS application
    AUTHORIZATION postgres;
	
--Создать скрипт генерирующий сущность тип события (event_type): id, name. 	
create table application.event_type (id serial primary key, name varchar(100) unique);

--Создать скрипт добавляющий три типа событий в таблицу: museum, cinema, theather. (3 записи)
insert into application.event_type (name) values ('museum'),('cinema'),('theather');

--Создать скрипт генерирующий сущность место проведения (place): id, name, address, city
create table application.place (id serial primary key,
								name varchar(100),
								address varchar(100),
								city varchar(100)
							   );
							 
--Создать скрипт генерирующий сущность событие (event): id, name, event_type_id, event_date (дата + время), place_id. 
create table application.event (id serial primary key,
							    name varchar(100),
							    event_type_id int references application.event_type(id),
								event_date timestamp,
								place_id int references application.place(id)
							   );



--Создать скрипт герерирующий сущность билет (ticket): id, event_id, client_email, price, is_selled (продан)
create table application.ticket (id serial primary key,
								event_id int references application.event(id),
								client_mail varchar(100),
								price numeric(9,2),
								is_selled bool
								);	
								
								
								

								
									 
