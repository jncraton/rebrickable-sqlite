select
  set_parts.part_num,
  parts.name,
  count(distinct set_parts.set_num) as num_sets,
  sum(quantity) as num_set_parts,
  max(year) as year_to,
  min(year) as year_from,
  "https://rebrickable.com/parts/" || set_parts.part_num as part_url
from set_parts
join sets on sets.set_num = set_parts.set_num
join parts on set_parts.part_num = parts.part_num
natural join elements
where sets.year >= 2015
group by set_parts.part_num
having year_from=2015
order by num_sets desc
limit 100;
