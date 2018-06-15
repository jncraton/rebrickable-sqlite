-- List sets that have a high percentage of studded Technic elements

.timer on
.mode csv
.output technic.csv 

create temp view studded as
select set_num,sum(quantity) as quantity from set_parts
where 
  part_num in (
    select part_num from parts 
    where 
      (
        name like 'technic brick%' or
        name like 'technic plate%' or
        part_num like '6143%' or --brick 2x2 round
        part_num like '92947%' or --brick 2x2 round profile
        part_num like '4032%' -- plate 2x2 round
      )
      and part_num not like '32064%' -- technic brick 1x2 with cross hole
  ) 
group by inventory_id;

create temp view studless as
select set_num,sum(quantity) as quantity from set_parts
where 
  part_num in (
    select part_num from parts 
    where 
      name like 'technic beam%'
  ) 
group by inventory_id;

select studded.set_num, year, num_parts, 1.0*studded.quantity/num_parts as percent from studded
  join sets on sets.set_num = studded.set_num
where percent > .08 and num_parts > 100
order by year desc, percent desc;