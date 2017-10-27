-- Show performance information
.timer on

-- Get all parts in a set

select part_num, color_id, quantity
from inventory_parts 
where inventory_id = (
  select id from inventories 
  where set_num='10193-1' --<-- replace with your set number
  order by version desc
  limit 1
);

-- List top 10 parts based on the number of inventories they are in

select 
  part_num,
  sum(quantity) as total_quantity 
from inventory_parts
group by part_num
order by total_quantity desc
limit 10;

-- Same as above, but including part names

select 
  parts.part_num, 
  name, 
  sum(quantity) as total_quantity 
from inventory_parts
join parts on parts.part_num = inventory_parts.part_num
group by inventory_parts.part_num
order by total_quantity desc
limit 10;
