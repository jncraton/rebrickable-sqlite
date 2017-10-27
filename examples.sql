-- Show performance information
.timer on

-- Get all colors

select id, name 
from colors;

-- Get all parts in a set

select part_num, color_id, quantity
from inventory_parts 
where inventory_id = (
  select id from inventories 
  where set_num='10193-1' --<-- replace with your set number
  order by version desc
  limit 1
);

-- More succinctly, you can use the `set_parts` view to get parts in a set

select part_num, color_id, quantity
from set_parts
where set_num = '10193-1';

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

-- Count total parts

select sum(1) from parts;

-- List all sets containing a particular part

select sets.set_num, sets.name, quantity
from inventory_parts
join inventories on inventory_parts.inventory_id = inventories.id
join sets on inventories.set_num = sets.set_num
where part_num = 25128;-- List all sets containing a particular part

-- List all sets containing a particular part/color combo

select sets.set_num, sets.name, quantity
from inventory_parts
join inventories on inventory_parts.inventory_id = inventories.id
join sets on inventories.set_num = sets.set_num
where part_num = 3004 and color_id = 3;

-- Get years when a part was produced

select part_num, year_from, year_to, num_sets, num_set_parts
from part_info
where part_num = 3004;

-- Get part urls

select part_num, part_url, part_img_url
from part_info
where part_num = 3004;

-- Get years when a part/color combo was produced

select part_num, year_from, year_to, num_sets, num_set_parts, part_img_url
from part_color_info
where part_num = 3004 and color_id=10;
