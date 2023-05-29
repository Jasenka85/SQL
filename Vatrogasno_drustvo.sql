use master;
drop database if exists Vatrogasno_drustvo;
go
create database Vatrogasno_drustvo collate Croatian_CI_AS;
go
use Vatrogasno_drustvo;

create table korisnik(
	sifra int not null primary key identity(1,1),
	posluzitelj bit not null,   -- samo posluzitelj moze objavljivati, ostali korisnici mogu kontaktirati ili se prijaviti 
	ime varchar(30) not null,
	prezime varchar(30) not null,
	lozinka varchar(30) not null,
	email varchar(30),
	mobitel varchar(20),
	oib varchar(15),            -- oib, datum rodjenja i adresa treba samo ako ispunjavaju prijavnicu
	datum_rodjenja datetime,
	mjesto varchar(30),
	ulica_broj varchar(50)
)

create table objava(
	sifra int not null primary key identity(1,1),
	korisnik int,
	naslov varchar(50) not null,
	tekst varchar(1000) not null,
	fotografija varchar(100),
	datum_objave datetime not null
)

create table prijava(
	sifra int not null primary key identity(1,1),
	korisnik int,
	vatrog_drustvo varchar(50) not null,
	datum_prijave datetime not null
)


create table kontakt(
	sifra int not null primary key identity(1,1),
	korisnik int,
	naslov varchar(50) not null,
	poruka varchar(500) not null,
	datum datetime not null
)

alter table objava add foreign key (korisnik) references korisnik(sifra);

alter table prijava add foreign key (korisnik) references korisnik(sifra);

alter table kontakt add foreign key (korisnik) references korisnik(sifra);

