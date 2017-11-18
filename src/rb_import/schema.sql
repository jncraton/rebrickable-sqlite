.timer on

pragma foreign_keys = 1;

create table if not exists themes (
  id smallint primary key,
  name varchar(64),
  parent_id smallint
);

create table if not exists colors (
  id smallint primary key,
  name varchar(64),
  rgb varchar(6),
  is_trans varchar(1)
);

create table if not exists part_categories (
  id smallint primary key,
  name varchar(64)
);

create table if not exists parts (
  part_num varchar(16) primary key,
  name varchar(255),
  part_cat_id smallint,
  foreign key(part_cat_id) references part_categories(id)
);

create table if not exists part_relationships (
  rel_type varchar(1),
  child_part_num varchar(16),
  parent_part_num varchar(16)
  --TODO: foreign key constraints currently fail on this table
  --foreign key(child_part_num) references parts(part_num)
  --foreign key(parent_part_num) references parts(part_num)
);

create table if not exists inventories (
  id int primary key,
  version smallint,
  set_num varchar(16),
  foreign key(set_num) references sets(set_num)
);

create table if not exists sets (
  set_num varchar(16) primary key,
  name varchar(128),
  year smallint,
  theme_id smallint,
  num_parts int,
  foreign key(theme_id) references themes(id)
);

create table if not exists inventory_parts (
  inventory_id int,
  part_num varchar(16),
  color_id smallint,
  quantity smallint,
  is_spare varchar(1),
  foreign key(inventory_id) references inventories(id),
  foreign key(color_id) references colors(id)
);

create table if not exists inventory_sets (
  inventory_id int,
  set_num varchar(16),
  quantity smallint,
  foreign key(inventory_id) references inventories(id),
  foreign key(set_num) references sets(set_num)
);

create view if not exists set_parts
as 
select 
  i1.set_num,
  inventory_parts.inventory_id, 
  inventory_parts.part_num, 
  inventory_parts.color_id, 
  inventory_parts.quantity, 
  inventory_parts.is_spare
from inventories i1
left outer join inventory_parts on
  inventory_parts.inventory_id = i1.id
where i1.version = (
  select max(version)
  from inventories i2 
  where i1.id = i2.id
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
  "https://m.rebrickable.com/media/parts/ldraw/26/" ||
    part_num || ".png" as part_img_url
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
  "https://m.rebrickable.com/media/parts/ldraw/" ||
    color_id || "/" || part_num || ".png" as part_img_url
from set_parts
join sets on sets.set_num = set_parts.set_num
group by part_num, color_id;
