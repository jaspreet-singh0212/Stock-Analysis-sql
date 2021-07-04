create database Assignment;
use Assignment;
select * from bajaj_auto;
select * from eicher_motors;
select * from hero_motocorp;
select * from infosys;
select * from tcs;
select * from tvs_motors;
update bajaj_auto set Date=str_to_date(date, '%d-%M-%Y');
update eicher_motors set Date=str_to_date(date, '%d-%M-%Y');
update hero_motocorp set Date=str_to_date(date, '%d-%M-%Y');
update infosys set Date=str_to_date(date, '%d-%M-%Y');
update tcs set Date=str_to_date(date, '%d-%M-%Y');
update tvs_motors set Date=str_to_date(date, '%d-%M-%Y');

#1
create table bajaj1 (
	`date` date,
	`close price` decimal(10,2),
    `20 day ma` decimal(10,2),
    `50 day ma` decimal(10,2)  );
create table eicher1 like bajaj1;
create table hero1 like bajaj1;	
create table infosys1 like bajaj1;
create table tcs1 like bajaj1;
create table tvs1 like bajaj1;	

insert into bajaj1 (date, `close price`, `20 day ma`,`50 day ma`)
select date, `close price`,
case
when row_number() OVER (ORDER BY Date) > 19
then avg(`close price`) OVER (ORDER BY Date ROWS BETWEEN 19 PRECEDING AND CURRENT ROW)
else null end,
case
when row_number() OVER (ORDER BY Date) > 49
then avg(`close price`) OVER (ORDER BY Date ROWS BETWEEN 49 PRECEDING AND CURRENT ROW)
else null end from bajaj_auto order by date;

insert into eicher1 (date, `close price`, `20 day ma`,`50 day ma`)
select date, `close price`,
case
when row_number() OVER (ORDER BY Date) > 19
then avg(`close price`) OVER (ORDER BY Date ROWS BETWEEN 19 PRECEDING AND CURRENT ROW)
else null end,
case
when row_number() OVER (ORDER BY Date) > 49
then avg(`close price`) OVER (ORDER BY Date ROWS BETWEEN 49 PRECEDING AND CURRENT ROW)
else null end from eicher_motors order by date;
  
insert into hero1 (date, `close price`, `20 day ma`,`50 day ma`)
select date, `close price`,
case
when row_number() OVER (ORDER BY Date) > 19
then avg(`close price`) OVER (ORDER BY Date ROWS BETWEEN 19 PRECEDING AND CURRENT ROW)
else null end,
case
when row_number() OVER (ORDER BY Date) > 49
then avg(`close price`) OVER (ORDER BY Date ROWS BETWEEN 49 PRECEDING AND CURRENT ROW)
else null end from hero_motocorp order by date;

insert into infosys1 (date, `close price`, `20 day ma`,`50 day ma`)
select date, `close price`,
case
when row_number() OVER (ORDER BY Date) > 19
then avg(`close price`) OVER (ORDER BY Date ROWS BETWEEN 19 PRECEDING AND CURRENT ROW)
else null end,
case
when row_number() OVER (ORDER BY Date) > 49
then avg(`close price`) OVER (ORDER BY Date ROWS BETWEEN 49 PRECEDING AND CURRENT ROW)
else null end from infosys order by date;

insert into tcs1 (date, `close price`, `20 day ma`,`50 day ma`)
select date, `close price`,
case
when row_number() OVER (ORDER BY Date) > 19
then avg(`close price`) OVER (ORDER BY Date ROWS BETWEEN 19 PRECEDING AND CURRENT ROW)
else null end,
case
when row_number() OVER (ORDER BY Date) > 49
then avg(`close price`) OVER (ORDER BY Date ROWS BETWEEN 49 PRECEDING AND CURRENT ROW)
else null end from tcs order by date;

insert into tvs1 (date, `close price`, `20 day ma`,`50 day ma`)
select date, `close price`,
case
when row_number() OVER (ORDER BY Date) > 19
then avg(`close price`) OVER (ORDER BY Date ROWS BETWEEN 19 PRECEDING AND CURRENT ROW)
else null end,
case
when row_number() OVER (ORDER BY Date) > 49
then avg(`close price`) OVER (ORDER BY Date ROWS BETWEEN 49 PRECEDING AND CURRENT ROW)
else null end from tvs_motors order by date;

select * from bajaj1;
select * from eicher1;
select * from hero1;
select * from infosys1;
select * from tcs1;
select * from tvs1;

#2
create table master_table as
select b.`date`, 
		b.`close price`     as Bajaj, 
		tc.`close price`	as TCS, 
		tv.`close price`	as TVS, 
		i.`close price`		as Infosys, 
		e.`close price` 	as Eicher, 
		h.`close price`		as Hero
from bajaj1 b INNER JOIN tcs1 tc    ON 	b.`date` = tc.`date`
			  INNER JOIN tvs1 tv    ON 	b.`date` = tv.`date`
			  INNER JOIN infosys1 i ON  b.`date` = i.`date`
			  INNER JOIN eicher1 e  ON	b.`date` = e.`date`
			  INNER JOIN hero1 h    ON  b.`date` = h.`date` ;
select * from master_table;   

#3
create table bajaj2 (
	`date` date,
	`close price` decimal(10,2),
    `signal` varchar(15)  );
create table eicher2 like bajaj2;
create table hero2 like bajaj2;
create table infosys2 like bajaj2;
create table tcs2 like bajaj2;
create table tvs2 like bajaj2;   

insert into bajaj2 (date,`close price`,`signal`) 
select date, `close price`,	 
case
when (`20 Day MA` > `50 Day MA`)   then 'Buy'
when (`20 Day MA` < `50 Day MA`)   then 'Sell'
else 'Hold'
end from bajaj1 order by date;

insert into eicher2 (date,`close price`,`signal`) 
select date, `close price`,	 
case
when (`20 Day MA` > `50 Day MA`)   then 'Buy'
when (`20 Day MA` < `50 Day MA`)   then 'Sell'
else 'Hold'
end from eicher1 order by date;

insert into hero2 (date,`close price`,`signal`) 
select date, `close price`,	 
case
when (`20 Day MA` > `50 Day MA`)   then 'Buy'
when (`20 Day MA` < `50 Day MA`)   then 'Sell'
else 'Hold'
end from hero1 order by date;

insert into infosys2 (date,`close price`,`signal`) 
select date, `close price`,	 
case
when (`20 Day MA` > `50 Day MA`)   then 'Buy'
when (`20 Day MA` < `50 Day MA`)   then 'Sell'
else 'Hold'
end from infosys1 order by date;

insert into tcs2 (date,`close price`,`signal`) 
select date, `close price`,	 
case
when (`20 Day MA` > `50 Day MA`)   then 'Buy'
when (`20 Day MA` < `50 Day MA`)   then 'Sell'
else 'Hold'
end from tcs1 order by date;

insert into tvs2 (date,`close price`,`signal`) 
select date, `close price`,	 
case
when (`20 Day MA` > `50 Day MA`)   then 'Buy'
when (`20 Day MA` < `50 Day MA`)   then 'Sell'
else 'Hold'
end from tvs1 order by date;

select * from bajaj2;
select * from eicher2;
select * from hero2;
select * from infosys2;
select * from tcs2;
select * from tvs2;

#4
delimiter $$
create function Signal_Bajaj(input date) 
returns varchar(15) 
deterministic
begin   
declare output varchar(15);
select `signal` into output from bajaj2 where date = input;
return output ;
end
$$ delimiter ;
select Signal_Bajaj('2015-01-01') as `signal`;

#5
select `date`,`close price`
from bajaj2
where `signal` = 'Buy'
order by 'close price'
limit 1;
select `date`,`close price`
from bajaj2
where `signal` = 'sell'
order by 'close price' desc
limit 1;
select `date`,`close price`
from eicher2
where `signal` = 'Buy'
order by 'close price'
limit 1;
select `date`,`close price`
from eicher2
where `signal` = 'sell'
order by 'close price' desc
limit 1;
select `date`,`close price`
from hero2
where `signal` = 'Buy'
order by 'close price'
limit 1;
select `date`,`close price`
from hero2
where `signal` = 'sell'
order by 'close price' desc
limit 1;
select `date`,`close price`
from infosys2
where `signal` = 'Buy'
order by 'close price'
limit 1;
select `date`,`close price`
from infosys2
where `signal` = 'sell'
order by 'close price' desc
limit 1;
select `date`,`close price`
from tcs2
where `signal` = 'Buy'
order by 'close price'
limit 1;
select `date`,`close price`
from tcs2
where `signal` = 'sell'
order by 'close price' desc
limit 1;
select `date`,`close price`
from tvs2
where `signal` = 'Buy'
order by 'close price' 
limit 1;
select `date`,`close price`
from tvs2
where `signal` = 'sell'
order by 'close price' desc
limit 1;