-- Drops tables generated by external data so they can be rebuilt

drop table if exists themes;
drop table if exists colors;
drop table if exists part_categories;
drop table if exists parts;
drop table if exists part_relationships;
drop table if exists inventories;
drop table if exists sets;
drop table if exists inventory_parts;
drop table if exists inventory_sets;
drop view if exists set_parts;
drop view if exists part_info;
drop view if exists part_color_info;
drop view if exists part_nums;
drop view if exists canonical_parts;

