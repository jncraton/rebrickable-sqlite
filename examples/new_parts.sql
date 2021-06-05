select part_num, name, num_sets, num_set_parts, year_from, part_url, part_img_url
from part_info
natural join parts
where year_from >= 2021 
  and part_num not like '%p%' -- skip printed parts
  and name not like 'Sticker%' -- skip sticker sheets
