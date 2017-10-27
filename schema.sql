.mode csv

create table if not exists colors (
  id numeric primary key,
  name text,
  rgb text,
  is_trans text
);

create table if not exists parts (
  part_num numeric primary key,
  name text,
  part_cat_id text
);

create table if not exists sets (
  set_num numeric primary key,
  name text,
  year text,
  theme_id int,
  num_parts int
);

create table if not exists inventory_parts (
  inventory_id numeric,
  part_num text,
  color_id numeric,
  quantity int,
  is_spare int
);

create table if not exists inventory_sets (
  inventory_id numeric,
  set_num text,
  quantity int
);

delete from colors;
delete from parts;
delete from sets;
delete from inventory_parts;
delete from inventory_sets;

.import tables/colors.csv colors
.import tables/parts.csv parts
.import tables/sets.csv sets
.import tables/inventory_parts.csv inventory_parts
.import tables/inventory_sets.csv inventory_sets

vacuum;