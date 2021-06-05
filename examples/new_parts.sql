select part_num, parts.name, num_sets, num_set_parts, year_from, part_url, part_img_url
from part_info
natural join parts
where year_from >= 2021 
  and part_num not like '%p%' -- skip printed parts
  and part_cat_id != 4 -- Duplo
  and part_cat_id != 17 -- Non-LEGO (posters, etc)
  and part_cat_id != 24 -- Other
  and part_cat_id != 27 -- Minifig accessories
  and part_cat_id != 28 -- Plants and Animals
  and part_cat_id != 31 -- String, bands, and reels
  and part_cat_id != 38 -- Flags, Signs, Plastic, Cloth
  and part_cat_id != 56 -- Tools
  and part_cat_id != 57 -- Duplo Figure
  and part_cat_id != 58 -- Stickers
  and part_cat_id != 59 -- Minifig heads
  and part_cat_id != 60 -- Minifig upper body
  and part_cat_id != 65 -- Minifig Headwear
