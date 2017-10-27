.mode csv

create table colors (
  id numeric primary key,
  name text,
  rgb text,
  is_trans text
);

create table parts (
  part_num numeric primary key,
  name text,
  part_cat_id text
);

create table sets (
  set_num numeric primary key,
  name text,
  year text,
  theme_id int,
  num_parts int
);

create table inventory_parts (
  inventory_id numeric,
  part_num text,
  color_id numeric,
  quantity int,
  is_spare int
);

create table inventory_sets (
  inventory_id numeric,
  set_num text,
  quantity int
);

.import tables/colors.csv colors
.import tables/parts.csv parts
.import tables/sets.csv sets
.import tables/inventory_parts.csv inventory_parts
.import tables/inventory_sets.csv inventory_sets