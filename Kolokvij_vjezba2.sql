use master;
drop database if exists Vjezba2;
go
create database Vjezba2 collate Croatian_CI_AS;
go
use Vjezba2;

create table zarucnica
(
	sifra int not null primary key identity(1,1),
	narukvica int,
	bojakose varchar(37) not null,
	novcica decimal(15,9),
	lipa decimal(15,8) not null,
	indiferentno bit not null
)

create table decko_zarucnica
(
	sifra int not null primary key identity(1,1),
	decko int not null,
	zarucnica int not null
)

create table decko
(
	sifra int not null primary key identity(1,1),
	indiferentno bit,
	vesta varchar(34),
	asocijalno bit not null
)

create table cura
(
	sifra int not null primary key identity(1,1),
	haljina varchar(33) not null,
	drugiputa datetime,
	suknja varchar(38),
	narukvica int,
	introvertno bit,
	majica varchar(40) not null,
	decko int
)

create table neprijatelj
(
	sifra int not null primary key identity(1,1),
	majica varchar(32),
	haljina varchar(43) not null,
	lipa decimal(16,8),
	modelnaocala varchar(49) not null,
	kuna decimal(12,6) not null,
	jmbag char(11),
	cura int
)


create table brat
(
sifra int not null primary key identity(1,1),
suknja varchar(47),
ogrlica int not null,
asocijalno bit not null,
neprijatelj int not null
)

create table svekar
(
	sifra int not null primary key identity(1,1),
	stilfrizura varchar(48),
	ogrlica int not null,
	asocijalno bit not null
)

create table prijatelj
(
	sifra int not null primary key identity(1,1),
	modelnaocala varchar(37),
	treciputa datetime not null,
	ekstrovertno bit not null,
	prviputa datetime,
	svekar int not null
)

alter table decko_zarucnica add foreign key (zarucnica) references zarucnica(sifra);
alter table decko_zarucnica add foreign key (decko) references decko(sifra);
alter table cura add foreign key (decko) references decko(sifra);
alter table neprijatelj add foreign key (cura) references cura(sifra);
alter table brat add foreign key (neprijatelj) references neprijatelj(sifra);
alter table prijatelj add foreign key (svekar) references svekar(sifra);

insert into zarucnica(narukvica,bojakose,novcica,lipa,indiferentno)
values
(7,'crna',64.36,243.87,1),
(5,'smeđa',24.145,763.43,0),
(3,'crvena',123.7,123.231,1);


insert into decko(indiferentno,vesta,asocijalno)
values
(1,'Babolat',0),
(0,'Morobo',1),
(1,'Mamba',1),
(0,'Bambi',0),
(0,'Boss',1);


insert into decko_zarucnica(decko,zarucnica)
values
(1,3),
(2,1),
(3,2);


insert into cura(haljina,drugiputa,suknja,narukvica,introvertno,majica,decko)
values
('Zara','2023-06-05 14:23:46','Benneton',5,1,'Mango',2),
('Mango','2023-06-23 16:12:55','Mako',4,0,'C&A',3),
('Orsay',null,'Zara',7,1,'Champion',1),
('Mana','2023-07-05 18:45:12','Zara',5,1,'Adidas',5),
('SOliver',null,'Orsay',4,0,'Mako',4),
('New Yorker','2023-08-03 12:32:15','Mango',7,1,'Puma',1);

insert into neprijatelj(majica,haljina,lipa,modelnaocala,kuna,jmbag,cura)
values
('Nike','Orsay',342.56,'Police',234.23,'23059871231',1),
('Champion','Benneton',523.123,'Denim',54.62,'1308981342',6),
('Puma','New Yorker',234.54,'Gucci',107.34,'1807989234',2);


insert into brat(suknja,ogrlica,asocijalno,neprijatelj)
values
('Benneton',10,1,3),
('Zara',14,0,1),
('Orsay',7,1,2),
('Mango',14,1,2),
('New Yorker',5,0,1),
('H&M',14,0,3);

insert into svekar(stilfrizura,ogrlica,asocijalno)
values
('kratka',4,1),
('jež',5,0),
('ćelav',3,1);


insert into prijatelj(modelnaocala,treciputa,ekstrovertno,prviputa,svekar)
values
('Anda','2023-07-12 15:23:45',1,'2023-05-12 17:14:28',2),
('Ghetaldus','2023-07-25 16:47:28',0,'2023-04-24 12:14:35',1),
('Oculus','2023-07-30 13:24:15',1,'2023-06-11 15:12:45',3);


update prijatelj set treciputa='2020-04-30';

select * from prijatelj;

delete from brat where ogrlica!=14;

select * from brat;

select suknja from cura where drugiputa is null;

select a.novcica, c.vesta, d.drugiputa, f.neprijatelj, e.haljina
from zarucnica a inner join decko_zarucnica b
on a.sifra=b.zarucnica
inner join decko c
on c.sifra=b.decko
inner join cura d
on c.sifra=d.decko
inner join neprijatelj e
on d.sifra=e.cura
inner join brat f
on e.sifra=f.neprijatelj
where d.drugiputa is not null; 


select a.novcica, c.vesta, d.drugiputa, f.neprijatelj, e.haljina
from zarucnica a inner join decko_zarucnica b
on a.sifra=b.zarucnica
inner join decko c
on c.sifra=b.decko
inner join cura d
on c.sifra=d.decko
inner join neprijatelj e
on d.sifra=e.cura
inner join brat f
on e.sifra=f.neprijatelj
where d.drugiputa is not null and c.vesta like '%ba%'; 




select a.novcica, f.neprijatelj, e.haljina
from zarucnica a inner join decko_zarucnica b
on a.sifra=b.zarucnica
inner join decko c
on c.sifra=b.decko
inner join cura d
on c.sifra=d.decko
inner join neprijatelj e
on d.sifra=e.cura
inner join brat f
on e.sifra=f.neprijatelj
where d.drugiputa is not null and c.vesta like '%ba%'
order by 3 desc;


select a.vesta, a.asocijalno
from decko a left join decko_zarucnica b
on a.sifra = b.decko
where b.sifra is null;