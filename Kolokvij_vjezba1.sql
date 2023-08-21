use master;
drop database if exists Vjezba1;
go
create database Vjezba1 collate Croatian_CI_AS;
go
use Vjezba1;

create table mladic
(
	sifra int not null primary key identity(1,1),
	suknja varchar(50) not null,
	kuna decimal(16,8) not null,
	drugiputa datetime,
	asocijalno bit,
	ekstrovertno bit not null,
	dukserica varchar(48) not null,
	muskarac int
)

create table muskarac
(
	sifra int not null primary key identity(1,1),
	bojaociju varchar(50) not null,
	hlace varchar(30),
	modelnaocala varchar(43),
	maraka decimal(14,5) not null,
	zena int not null
)

create table zena
(
	sifra int not null primary key identity(1,1),
	treciputa datetime,
	hlace varchar(46),
	kratkamajica varchar(31) not null,
	jmbag char(11) not null,
	bojaociju varchar(39) not null,
	haljina varchar(44),
	sestra int not null
)

create table sestra
(
	sifra int not null primary key identity(1,1),
	introvertno bit,
	haljina varchar(31) not null,
	maraka decimal(16,6),
	hlace varchar(46) not null,
	narukvica int not null
)

create table sestra_svekar
(
	sifra int not null primary key identity(1,1),
	sestra int not null,
	svekar int not null
)

create table svekar
(
	sifra int not null primary key identity(1,1),
	bojaociju varchar(40) not null,
	prstena int,
	dukserica varchar(41),
	lipa decimal(13,8),
	eura decimal(12,7),
	majica varchar(35)
)

create table punac
(
	sifra int not null primary key identity(1,1),
	ogrlica int,
	gustoca decimal(14,9),
	hlace varchar(41) not null
)

create table cura
(
	sifra int not null primary key identity(1,1),
	novcica decimal(16,5) not null,
	gustoca decimal(18,6) not null,
	lipa decimal(13,10),
	ogrlica int not null,
	bojakose varchar(38),
	suknja varchar(36),
	punac int
)

alter table mladic add foreign key (muskarac) references muskarac(sifra);
alter table muskarac add foreign key (zena) references zena(sifra);
alter table zena add foreign key (sestra) references sestra(sifra);
alter table sestra_svekar add foreign key (sestra) references sestra(sifra);
alter table sestra_svekar add foreign key (svekar) references svekar(sifra);
alter table cura add foreign key (punac) references punac(sifra);


insert into svekar(bojaociju,prstena,dukserica,lipa,eura,majica)
values
('zelena',1,'H&M',121.76,12.45,'NKD'),
('plava',2,'Champion',231.45,34.27,'Adidas'),
('smeđa',3,'Puma',345.21,61.93,'Nike');


insert into sestra(introvertno,haljina,maraka,hlace,narukvica)
values
(0,'Zaba',213.34,'C&A',1),
(1,'H&M',521.76,'Nike',2),
(0,'Babolat',321.45,'Mango',3),
(1,'Benneton',127.49,'Levis',2),
(0,'Zara',414.32,'Champion',1);


insert into sestra_svekar(sestra,svekar)
values
(1,2),
(2,3),
(3,1);


insert into zena(treciputa,hlace,kratkamajica,jmbag,bojaociju,haljina,sestra)
values
('2023-05-02 15:13:34','Anammaria','Orsay','21089761234','smeđa','Orsay',2),
('2023-06-15 19:24:51','Anubis','Mango','13099815436','plava','Mako',1),
('2023-07-21 14:32:24','Amadeus','Zara','12109871237','zelena','Mango',3);


insert into muskarac(bojaociju, hlace, modelnaocala, maraka, zena)
values
('plava','Levis','Police',45.23,1),
('smeđa','Denim','Gucci',56.12,2),
('zelena','Gas','Anda',34.12,3);


insert into mladic(suknja,kuna,drugiputa,asocijalno,ekstrovertno,dukserica,muskarac)
values
('Benneton',23.76,'2023-05-21 18:33:54',1,0,'Puma',1),
('Mango',9.45,'2023-06-17 15:41:13',0,1,'C&A',3),
('Mako',14.53,'2023-07-08 11:34:27',0,0,'New Yorker',2);


insert into punac(ogrlica,gustoca,hlace)
values
(1,45.56,'Varteks'),
(2,67.12,'Galileo'),
(3,54.38,'Mana');


insert into cura(novcica,gustoca,lipa,ogrlica,bojakose,suknja,punac)
values
(56.57,73.64,81.35,5,'smeđa','Zara',2),
(48.82,82.31,97.24,3,'crvena','Benneton',1),
(24.37,69.47,54.42,1,'ljubičasta','Mango',3);


update cura set gustoca = 15.77;

select * from cura;

delete from mladic where kuna>15.78;

select * from mladic;

select kratkamajica from zena where hlace like '%ana%';


select a.dukserica, f.asocijalno, e.hlace   
from svekar a inner join sestra_svekar b
on a.sifra=b.svekar
inner join sestra c
on c.sifra=b.sestra
inner join zena d
on c.sifra=d.sestra
inner join muskarac e
on d.sifra=e.zena
inner join mladic f
on e.sifra=f.muskarac
where d.hlace like 'A%' and c.haljina like '%ba%'
order by 3 desc;


select a.haljina, a.maraka 
from sestra a left join sestra_svekar b
on a.sifra = b.sestra
where b.sifra is null;