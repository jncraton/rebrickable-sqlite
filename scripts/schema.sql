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
  part_material_id smallint,
  foreign key(part_cat_id) references part_categories(id)
);

create table if not exists part_relationships (
  rel_type varchar(1),
  child_part_num varchar(20),
  parent_part_num varchar(20)
);

create table if not exists elements (
  element_id varchar(16) primary key,
  part_num varchar(16),
  color_id smallint,
  foreign key(part_num) references parts(part_num),
  foreign key(color_id) references colors(id)
);

create table if not exists minifigs (
  fig_num varchar(20) primary key,
  name varchar(256),
  num_parts smallint
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
  img_url varchar(128),
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

create table if not exists inventory_minifigs (
  inventory_id int,
  fig_num varchar(20),
  quantity smallint,
  foreign key(inventory_id) references inventories(id),
  foreign key(fig_num) references minifigs(set_num)
);

create view if not exists set_parts
as 
select 
  inventories.set_num,
  inventory_parts.inventory_id, 
  inventory_parts.part_num, 
  inventory_parts.color_id, 
  inventory_parts.quantity, 
  inventory_parts.is_spare
from inventories
left outer join inventory_parts on
  inventory_parts.inventory_id = inventories.id
where inventories.version = 1;

create view if not exists part_info
as
select
  part_num,
  count(distinct set_parts.set_num) as num_sets,
  sum(quantity) as num_set_parts,
  max(year) as year_to,
  min(year) as year_from,
  "https://rebrickable.com/parts/" || part_num as part_url,
  "https://cdn.rebrickable.com/media/thumbs/parts/elements/" ||
    element_id || ".jpg/85x85p.jpg" as part_img_url
from set_parts
join sets on sets.set_num = set_parts.set_num
natural join elements
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

-- The parts table doesn't include absolutely every part_num. This view does.
create view if not exists part_nums
as
select part_num as part_num from parts
union 
select child_part_num as part_num from part_relationships
union
select parent_part_num as part_num from part_relationships;

drop view if exists canonical_parts;
create view if not exists canonical_parts
as
select
  part_num,
  case 
    when parent_part_num is null 
    then part_num else parent_part_num 
    end as canonical_part_num
from part_nums
left join part_relationships on 
  child_part_num = part_num
  and (rel_type = 'M');
