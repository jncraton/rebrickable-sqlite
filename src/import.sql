.timer on
.mode csv

pragma foreign_keys = 1;

delete from inventory_sets;
delete from inventory_parts;
delete from inventories;
delete from sets;
delete from parts;
delete from part_categories;
delete from colors;
delete from themes;

.import tables/themes.csv themes
.import tables/colors.csv colors
.import tables/part_categories.csv part_categories
.import tables/parts.csv parts
.import tables/sets.csv sets
.import tables/inventories.csv inventories
.import tables/inventory_parts.csv inventory_parts
.import tables/inventory_sets.csv inventory_sets