use master;
drop database if exists Zooloski;
go
create database Zooloski;
go
use Zooloski;

create table zivotinja(
	sifra int not null primary key identity(1,1),
	vrsta varchar(50) not null,
	ime varchar(50) not null,
	djelatnik int,
	prostorija int,
	datum int
)

create table djelatnik(
	sifra int not null primary key identity(1,1),
	ime varchar(50) not null,
	prezime varchar(50) not null,
	iban varchar(50)
)

create table prostorija(
	sifra int not null primary key identity(1,1),
	dimenzije varchar(30) not null,
	maxbroj int not null,
	mjesto varchar(30)
)

create table datum(
	sifra int not null primary key identity(1,1),
	datum_rodenja datetime,
	datum_dolaska datetime not null, 
	datum_smrti datetime
)

alter table zivotinja add foreign key (djelatnik) references djelatnik(sifra);
alter table zivotinja add foreign key (prostorija) references prostorija(sifra);
alter table zivotinja add foreign key (datum) references datum(sifra);

insert into djelatnik (ime, prezime, iban)
values 
('Ivan','Jurkezi','HR65240200613156720'),
('Marija','Filkovac','HR65240200625381921'),
('Marko','Turkalj','HR65240200682547182'),
('Kristina','Barton','HR65240200662719812'),
('Darko','Novak','HR65240200692914321');

-- select * from djelatnik;

insert into prostorija (dimenzije, maxbroj, mjesto)
values 
('7x6x3',5,'Red1_1'),
('6x5x3',4,'Red1_2'),
('5x4x3',3,'Red1_3'),
('8x6x2',5,'Red2_1'),
('6x4x2',4,'Red2_2'),
('4x4x2',3,'Red2_3');

-- select * from prostorija;


insert into datum (datum_rodenja, datum_dolaska, datum_smrti)
values 
('2018-04-16 13:24:56','2019-06-11 17:00:00', '2022-12-16 06:15:00'),
('2018-10-05 08:14:32','2020-09-15 13:00:00', null),
('2019-05-23 17:18:16','2021-10-02 08:30:00', null),
('2019-08-04 12:13:34','2022-02-13 14:15:00', null),
('2020-07-03 15:18:22','2023-01-19 19:05:00', null);

-- select * from datum;

insert into zivotinja (vrsta, ime, djelatnik, prostorija, datum)
values
('krokodil','Jure',3,5,1),
('slon','Duje',2,1,2),
('vuk','Miro',1,4,3),
('medvjed','Mate',4,2,4),
('majmun','Luka',5,3,5);

-- select * from zivotinja;


update djelatnik set prezime='Boras'
where sifra=2;

-- select * from djelatnik;

update datum set datum_smrti='2023-02-03 04:16:00'
where sifra=4;

-- select * from datum;

update zivotinja set djelatnik=4
where sifra=3;

-- select * from zivotinja;


delete from zivotinja where djelatnik=3;

-- select * from zivotinja;

delete from zivotinja where datum=4;

-- select * from zivotinja;

delete from datum where sifra=1;

-- select * from datum;