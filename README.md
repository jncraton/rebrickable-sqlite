# rebrickable-database

This is set of scripts to import and create a local copy of the Rebrickable database. This uses the CSV downloads provided by Rebrickable, so it is a relatively quick and easy way to create a local copy of all Lego parts and set inventories.

## Getting started

Simply run `make`.

This will download the table data from Rebrickable and import them into an sqlite database.

## Example queries

### List all colors

```
select id, name 
from colors;
```

### Get all parts in a set

This May seem a little more complicated than it needs to be. Rebrickable maintains multiple versions of set inventories. This is a great feature, but we usually want only the most recent version.

```
select part_num, color_id, quantity
from inventory_parts 
where inventory_id = (
  select id from inventories 
  where set_num='10193-1' --<-- replace with your set number
  order by version desc
  limit 1
);
```

### List top 10 parts based on the number of inventories they are in

Part numbers

```
select 
  part_num,
  sum(quantity) as total_quantity 
from inventory_parts
group by part_num
order by total_quantity desc
limit 10;
```

Including names

```
select 
  parts.part_num, 
  name, 
  sum(quantity) as total_quantity 
from inventory_parts
join parts on parts.part_num = inventory_parts.part_num
group by inventory_parts.part_num
order by total_quantity desc
limit 10;
```

### More examples

These examples, along with others, are available in the runable SQLite script `examples.sql`.
