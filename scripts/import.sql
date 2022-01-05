.timer on
.mode csv

pragma foreign_keys = 0;

delete from inventory_sets;
delete from inventory_minifigs;
delete from inventory_parts;
delete from inventories;
delete from sets;
delete from minifigs;
delete from elements;
delete from part_relationships;
delete from parts;
delete from part_categories;
delete from colors;
delete from themes;

.import tables/themes.csv themes
.import tables/colors.csv colors
.import tables/part_categories.csv part_categories
.import tables/parts.csv parts
.import tables/part_relationships.csv part_relationships
.import tables/elements.csv elements
.import tables/minifigs.csv minifigs
.import tables/sets.csv sets
.import tables/inventories.csv inventories
.import tables/inventory_parts.csv inventory_parts
.import tables/inventory_minifigs.csv inventory_minifigs
.import tables/inventory_sets.csv inventory_sets

insert or ignore into parts (part_num, name, part_cat_id)
select child_part_num, parts.name, parts.part_cat_id
from part_relationships
join parts on part_num = parent_part_num;

insert or ignore into parts (part_num, name, part_cat_id)
select parent_part_num, parts.name, parts.part_cat_id
from part_relationships
join parts on part_num = child_part_num;