drop table if exists transactions;

drop table if exists customers;

drop table if exists artworks;

drop table if exists artists;

drop table if exists ngo;



create table ngo
(
ngo_id int auto_increment,
name varchar(50),
email varchar(50) check (email like '%@%'),
goal varchar(100),
address varchar(50),
donation decimal(10,2) default 0,
constraint ngoid_pk primary key(ngo_id)
);


create table artists
(
artist_id int auto_increment,
name varchar(50) not null,
email varchar(50) check (email like '%@%'),
address varchar(50) not null,
constraint pk_a_id primary key(artist_id)
);


create table artworks
(
artwork_id int auto_increment,
artist_id int,
title varchar(50),
price decimal(10,2),
type varchar(50),
available int default true, 
constraint pk_awid primary key(artwork_id),
constraint fk_aid foreign key(artist_id) references artists(artist_id) on delete set null
);


create table customers
(
  customer_id int auto_Increment,
  name varchar(50),
  email varchar(50),
  address varchar(50),
  constraint pk_cid PRIMARY KEY(customer_id)
);


create table transactions
(
transaction_id int auto_increment,
customer_id int,
ngo_id int,
artwork_id int,
transaction_date date,
constraint pk_tid primary key(transaction_id),
constraint fk_cid foreign key(customer_id) references customers(customer_id),
constraint fk_n_id foreign key(ngo_id) references ngo(ngo_id),
constraint fk_aw_id foreign key(artwork_id) references artworks(artwork_id)
);
