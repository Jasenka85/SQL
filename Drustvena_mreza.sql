use master;
drop database if exists Drustvena_mreza;
go
create database Drustvena_mreza collate Croatian_CI_AS;
go
use Drustvena_mreza;

create table osoba(
	sifra int not null primary key identity(1,1),
	ime varchar(25) not null,
	prezime varchar(25) not null,
	datum_rodjenja datetime,
	email varchar(50) not null,
	lozinka varchar(60) not null,
	brojtel varchar(12),
	slika varchar(100),
	administrator bit not null,
	stanje bit not null,
	aktivan bit not null,
	uniqueid varchar(255)
)

create table objava(
	sifra int not null primary key identity(1,1),
	naslov varchar(50) not null,
	upis varchar(250) not null,
	vrijemeizrade datetime not null,
	ipadresa varchar(20),
	osoba int
)

create table komentar(
	sifra int not null primary key identity(1,1),
	vrijemekomentiranja datetime not null,
	opis varchar(250),
	objava int,
	osoba int
)

create table svidjamise(
	sifra int not null primary key identity(1,1),
	vrijemesvidjanja datetime not null,
	objava int,
	osoba int
)

create table svidjamise_komentar(
	sifra int not null primary key identity(1,1),
	osoba int,
	komentar int
)

alter table objava add foreign key (osoba) references osoba(sifra);

alter table komentar add foreign key (objava) references objava(sifra);
alter table komentar add foreign key (osoba) references osoba(sifra);

alter table svidjamise add foreign key (objava) references objava(sifra);
alter table svidjamise add foreign key (osoba) references osoba(sifra);

alter table svidjamise_komentar add foreign key (osoba) references osoba(sifra);
alter table svidjamise_komentar add foreign key (komentar) references komentar(sifra);


-- select * from osoba;

insert into osoba (ime, prezime, datum_rodjenja, email, lozinka, brojtel, slika, administrator, stanje, aktivan, uniqueid)
values 
('Ivan','Jelić','1995-04-13 00:00:00','ivan.jelic@gmail.com','danijela20071996','091532997',null,0,0,1,null),
('Boris','Olujić','1992-06-03 00:00:00','boris.oluja@gmail.com','krokodil1234','0985632561',null,0,0,1,null),
('Krešo','Pintar','1998-12-05 00:00:00','kresopintar@net.hr','petielement1997','0954328110',null,0,0,1,null);

-- select * from osoba;

-- select * from objava;

insert into objava (naslov, upis, vrijemeizrade, ipadresa, osoba)
values 
('Posjet Jankovcu','Na povratku iz Zagreba odlučili smo malo stati i prošetati.','2023-04-11 16:34:17',null,1),
('Novi mobitel','Stari pao na beton, klasika...','2023-04-28 11:14:27',null,3),
('Položio vozački!','Čuvajte se crvene Škode. ;)','2023-05-08 17:28:47',null,2);

-- select * from objava;


-- select * from komentar;

insert into komentar (vrijemekomentiranja, opis, objava, osoba)
values 
('2023-04-11 17:05:28','Svaka čast! Baš vam zavidim!',1,3),
('2023-04-28 12:15:17','Ma to si ga namjerno bacio, da možeš kupiti novi. ;)',2,1),
('2023-05-08 18:14:33','Čestitam! Čuvaj se kamera! ;)',3,2);

-- select * from komentar;

-- select * from svidjamise;

insert into svidjamise (vrijemesvidjanja, objava, osoba)
values 
('2023-04-11 17:03:43',1,3),
('2023-04-28 12:13:05',2,1),
('2023-05-08 18:12:23',3,2);

-- select * from svidjamise;

-- select * from svidjamise_komentar;

insert into svidjamise_komentar(osoba,komentar)
values 
(1,1),
(3,2),
(2,3);

-- select * from svidjamise_komentar;

update osoba set email='kreso.pintar@gmail.com'
where sifra=3;

-- select * from osoba;

update objava set naslov='Evo nas malo na Jankovcu...'
where sifra=1;

-- select * from objava;

update komentar set opis='Svaka čast! Čuvaj se biciklista. ;)'
where sifra=3;

-- select * from komentar;


delete from svidjamise where objava=2;

-- select * from svidjamise;

delete from svidjamise_komentar where komentar=3;

-- select * from svidjamise_komentar;

delete from komentar where sifra=3;

-- select * from komentar;