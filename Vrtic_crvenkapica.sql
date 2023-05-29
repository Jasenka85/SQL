use master;
drop database if exists Vrtic_Crvenkapica;
go
create database Vrtic_Crvenkapica collate Croatian_CI_AS;
go
use Vrtic_Crvenkapica;

create table roditelj(
	sifra int not null primary key identity(1,1),
	ime varchar(30) not null,
	prezime varchar(30) not null,
	oib varchar(15), 
	mjesto varchar(30),
	ulica_broj varchar(50),
	email varchar(30),
	mobitel varchar(20),
	zanimanje varchar(50),
	zaposlen bit,
	samohran bit
)


create table dijete(
	sifra int not null primary key identity(1,1),
	roditelj int,
	ime_d varchar(30) not null,
	prezime_d varchar(30) not null,
	oib_d varchar(15),
	datum_rodjenja datetime,
	cijepljen bit,
	teskoce varchar(500)
)


create table kontakt(
	sifra int not null primary key identity(1,1),
	roditelj int,
	naslov varchar(50) not null,
	poruka varchar(500) not null,
	datum datetime not null
)


create table prijava(
	sifra int not null primary key identity(1,1),
	dijete int,
	vrsta_boravka varchar(50) not null,
	datum_prijave datetime not null
)


alter table dijete add foreign key (roditelj) references roditelj(sifra);

alter table kontakt add foreign key (roditelj) references roditelj(sifra);

alter table prijava add foreign key (dijete) references dijete(sifra);

