-- List all elements with the years they were first available

.timer on
.mode csv
.output elements.csv 

select "Year", "Set Count", "Color", "Part", "Part ID", "Color ID";

select min(year), sum(1), colors.name, parts.name, parts.part_num, colors.id from sets
  join inventories 
    on inventories.set_num = sets.set_num
   and inventories.version = 1
  left join inventory_parts
    on inventory_parts.inventory_id = inventories.id
  join parts
    on parts.part_num = inventory_parts.part_num
  join colors
    on colors.id = inventory_parts.color_id
 where (
        sets.set_num glob '[0-9][0-9][0-9][0-9][0-9]-[0-9]'
        or sets.set_num glob '[0-9][0-9][0-9][0-9]-[0-9]'
        or sets.set_num glob '[0-9][0-9][0-9]-[0-9]'
       )
 group by colors.name, parts.name, parts.part_num, colors.id
 order by year desc, colors.name asc
