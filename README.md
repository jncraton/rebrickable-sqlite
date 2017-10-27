# rebrickable-database

This is set of scripts to import and create a local copy of the Rebrickable database. This uses the CSV downloads provided by Rebrickable, so it is a relatively quick and easy way to create a local copy of all Lego parts and set inventories.

## Getting started

Simply run `make`.

This will download the table data from Rebrickable and import them into an sqlite database.

## Example queries

### Get all parts in a set

This gets a little complicated. Rebrickable maintains multiple versions of set inventories. This is a great features, but we usually want only the most recent version.

```
select * from inventory_parts where
  inventory_id = (
    select id from inventories 
      where set_num='10193-1' --<-- replace with your set number
      order by version desc
      limit 1
  );
```