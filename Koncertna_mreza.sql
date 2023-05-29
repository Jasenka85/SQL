use master;
drop database if exists Koncertna_mreza;
go
create database Koncertna_mreza collate Croatian_CI_AS;
go
use Koncertna_mreza;

create table korisnik(
	sifra int not null primary key identity(1,1),
	posluzitelj bit not null,   -- samo posluzitelj moze objavljivati, ostali korisnici mogu rezervirati ili kontaktirati 
	ime varchar(30) not null,
	prezime varchar(30) not null,
	lozinka varchar(30) not null,
	email varchar(30),
	mobitel varchar(20),
	mjesto varchar(30),
	ulica_broj varchar(50)
)

create table objava(
	sifra int not null primary key identity(1,1),
	korisnik int not null,
	naslov varchar(50) not null,
	tekst varchar(1000) not null,
	datum_objave datetime not null
)

create table fotografija(
	sifra int not null primary key identity(1,1),
	objava int not null,
	link varchar(100) not null
)

create table koncert(
	sifra int not null primary key identity(1,1),
	izvodjac varchar(30) not null,
	drzava varchar(30),
	mjesto varchar(30) not null,
	dvorana varchar(50),
	datum_odrzavanja datetime not null,
	cijena decimal(18,2) not null,
	ima_karata bit,
	aktivan bit
)

create table rezervacija(
	sifra int not null primary key identity(1,1),
	korisnik int not null,
	koncert int not null,
	datum_rezervacije datetime not null,
	nacin_placanja int not null,
	placeno bit
)

create table kontakt(
	sifra int not null primary key identity(1,1),
	korisnik int not null,
	naslov varchar(50) not null,
	poruka varchar(500) not null,
	datum datetime not null
)


alter table objava add foreign key (korisnik) references korisnik(sifra);
alter table fotografija add foreign key (objava) references objava(sifra);

alter table rezervacija add foreign key (korisnik) references korisnik(sifra);
alter table rezervacija add foreign key (koncert) references koncert(sifra);

alter table kontakt add foreign key (korisnik) references korisnik(sifra);