select
  set_parts.part_num,
  parts.name,
  part_categories.name as category,
  count(distinct set_parts.set_num) as num_sets,
  sum(quantity) as num_set_parts,
  min(48, floor(sum(quantity) / 15000) * 12) as count,
  max(year) as year_to,
  min(year) as year_from,
  "https://rebrickable.com/parts/" || set_parts.part_num as part_url
from set_parts
join sets on sets.set_num = set_parts.set_num
join parts on set_parts.part_num = parts.part_num
join part_categories on parts.part_cat_id = part_categories.id
natural join elements
where sets.year >= 2015
group by set_parts.part_num
having year_from=2015 and num_set_parts > 15000
order by category asc, num_sets desc;
