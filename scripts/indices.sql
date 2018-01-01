-- Creates indices on several hot columns
--
-- Note that SQLite create an index on a primary key by default, so these are
-- not included here.

.timer on

create index if not exists inventories_set_num_idx on inventories (set_num);
create index if not exists inventory_parts_part_num_idx on inventory_parts (part_num);
create index if not exists inventory_parts_color_id_idx on inventory_parts (color_id);
create index if not exists inventory_parts_part_num_color_id_idx on inventory_parts (part_num, color_id);
