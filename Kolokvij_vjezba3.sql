use master;
drop database if exists Vjezba3;
go
create database Vjezba3 collate Croatian_CI_AS;
go
use Vjezba3;

create table brat
(
	sifra int not null primary key identity(1,1),
	jmbag char(11),
	ogrlica int not null,
	ekstrovertno bit not null
)

create table prijatelj_brat
(
	sifra int not null primary key identity(1,1),
	prijatelj int not null,
	brat int not null
)

create table prijatelj
(
	sifra int not null primary key identity(1,1),
	kuna decimal(16,10),
	haljina varchar(37),
	lipa decimal (13,10),
	dukserica varchar(31),
	indiferentno bit not null
)

create table ostavljena
(
	sifra int not null primary key identity(1,1),
	kuna decimal(17,5),
	lipa decimal (15,6),
	majica varchar(36),
	modelnaocala varchar(31) not null,
	prijatelj int
)

create table snasa
(
	sifra int not null primary key identity(1,1),
	introvertno bit,
	kuna decimal(15,6) not null,
	eura decimal(12,9) not null,
	treciputa datetime,
	ostavljena int not null
)

create table punica
(
	sifra int not null primary key identity(1,1),
	asocijalno bit,
	kratkamajica varchar(44),
	kuna decimal(13,8) not null,
	vesta varchar(32) not null,
	snasa int
)

create table cura
(
	sifra int not null primary key identity(1,1),
	dukserica varchar(49),
	maraka decimal(13,7),
	drugiputa datetime,
	majica varchar(49),
	novcica decimal(15,8),
	ogrlica int not null
)

create table svekar
(
	sifra int not null primary key identity(1,1),
	novcica decimal(16,8) not null,
	suknja varchar(44) not null,
	bojakose varchar(36),
	prstena int,
	narukvica int not null,
	cura int not null
)

alter table prijatelj_brat add foreign key (brat) references brat(sifra);
alter table prijatelj_brat add foreign key (prijatelj) references prijatelj(sifra);
alter table ostavljena add foreign key (prijatelj) references prijatelj(sifra);
alter table snasa add foreign key (ostavljena) references ostavljena(sifra);
alter table punica add foreign key (snasa) references snasa(sifra);
alter table svekar add foreign key (cura) references cura(sifra);


insert into snasa(introvertno,kuna,eura,treciputa,ostavljena)
values
(1,143.23,21.56,'2023-04-12 13:43:21',1),
(0,321.21,56.27,'2023-07-13 21:45:12',3),
(1,245.12,64.12,'2023-08-01 18:45:34',2);

insert into ostavljena(kuna,lipa,majica,modelnaocala,prijatelj)
values
(243.12,5432.23,'Mako','Anda',3),
(432.45,2466.53,'Mango','Ghetaldus',1),
(315.56,125.65,'Zara','Oculus',2);

insert into prijatelj_brat(prijatelj,brat)
values
(1,3),
(2,1),
(3,2);

update svekar set suknja='Osijek';

delete from punica where kratkamajica='AB';

select majica from ostavljena where lipa not in (9,10,20,30,35);


select a.ekstrovertno, f.vesta, e.kuna
from brat a inner join prijatelj_brat b
on a.sifra=b.brat
inner join prijatelj c
on c.sifra=b.prijatelj
inner join ostavljena d
on c.sifra=d.prijatelj
inner join snasa e
on d.sifra=e.ostavljena
inner join punica f
on e.sifra=f.snasa
where d.lipa !=91 and c.haljina like '%ba%'
order by e.kuna desc;


select a.haljina, a.lipa
from prijatelj a left join prijatelj_brat b
on a.sifra=b.prijatelj
where b.sifra is null;
