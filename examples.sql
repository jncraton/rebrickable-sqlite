-- Show performance information
.timer on

-- Get colors

select id, name 
from colors
limit 5;

-- Get parts in a set

select part_num, color_id, quantity
from inventory_parts 
where inventory_id = (
  select id from inventories 
  where set_num='10193-1' --<-- replace with your set number
  order by version desc
  limit 1
)
limit 5;

-- More succinctly, you can use the `set_parts` view to get parts in a set

select part_num, color_id, quantity
from set_parts
where set_num = '10193-1'
limit 5;

-- List top 5 parts based on the number of inventories they are in

select 
  part_num,
  sum(quantity) as total_quantity 
from inventory_parts
group by part_num
order by total_quantity desc
limit 5;

-- Same as above, but including part names

select 
  parts.part_num, 
  name, 
  sum(quantity) as total_quantity 
from inventory_parts
join parts on parts.part_num = inventory_parts.part_num
group by inventory_parts.part_num
order by total_quantity desc
limit 5;

-- Count total parts

select sum(1) from parts;

-- List sets containing a particular part

select sets.set_num, sets.name, quantity
from inventory_parts
join inventories on inventory_parts.inventory_id = inventories.id
join sets on inventories.set_num = sets.set_num
where part_num = 25128
limit 5;

-- List sets containing a particular part/color combo

select sets.set_num, sets.name, quantity
from inventory_parts
join inventories on inventory_parts.inventory_id = inventories.id
join sets on inventories.set_num = sets.set_num
where part_num = 3004 and color_id = 3
limit 5;

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

-- List the part ids for 1 x 1 Clip Vertical

select child_part_num
from part_relationships
where parent_part_num = 4085;

-- List canoncial parent part id

select part_num, canonical_part_num
from canonical_parts
where part_num = '4085';

select part_num, canonical_part_num
from canonical_parts
where part_num = '4085a';

select part_num, canonical_part_num
from canonical_parts
where part_num = '4085b';