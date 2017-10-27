.timer on

pragma foreign_keys = 1;

create table if not exists themes (
  id numeric primary key,
  name text,
  parent_id numeric
);

create table if not exists colors (
  id numeric primary key,
  name text,
  rgb text,
  is_trans text
);

create table if not exists part_categories (
  id numeric primary key,
  name text
);

create table if not exists parts (
  part_num text primary key,
  name text,
  part_cat_id text,
  foreign key(part_cat_id) references part_categories(id)
);

create table if not exists inventories (
  id int primary key,
  version int,
  set_num text,
  foreign key(set_num) references sets(set_num)
);

create table if not exists sets (
  set_num numeric primary key,
  name text,
  year text,
  theme_id int,
  num_parts int,
  foreign key(theme_id) references themes(id)
);

create table if not exists inventory_parts (
  inventory_id numeric,
  part_num text,
  color_id numeric,
  quantity int,
  is_spare int,
  foreign key(color_id) references colors(id)
);

create table if not exists inventory_sets (
  inventory_id numeric,
  set_num text,
  quantity int,
  foreign key(inventory_id) references inventories(id),
  foreign key(set_num) references sets(set_num)
);

create view if not exists set_parts
as 
select 
  set_num,
  inventory_id, 
  part_num, 
  color_id, 
  quantity, 
  is_spare
from inventory_parts 
join inventories on inventories.id = inventory_parts.inventory_id
where inventory_id in (
  select inventories.id from inventories
  inner join (
    select id, max(version) as version
    from inventories
    group by id
  ) g
  on inventories.id = g.id
  and inventories.version = g.version
);

create view if not exists part_info
as
select
  part_num,
  count(distinct set_parts.set_num) as num_sets,
  sum(quantity) as num_set_parts,
  max(year) as year_to,
  min(year) as year_from,
  "https://rebrickable.com/parts/" || part_num as part_url,
  "https://m.rebrickable.com/media/parts/elements/" || part_num || "26.jpg" as part_img_url
from set_parts
join sets on sets.set_num = set_parts.set_num
group by part_num;

create view if not exists part_color_info
as
select
  part_num,
  color_id,
  count(distinct set_parts.set_num) as num_sets,
  sum(quantity) as num_set_parts,
  max(year) as year_to,
  min(year) as year_from,
  "https://rebrickable.com/parts/" || part_num as part_url,
  "https://m.rebrickable.com/media/parts/ldraw/" 
    || color_id || "/" || part_num || ".png" as part_img_url
from set_parts
join sets on sets.set_num = set_parts.set_num
group by part_num, color_id;
