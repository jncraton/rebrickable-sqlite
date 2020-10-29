# rebrickable-sqlite

[![Build Status](https://travis-ci.org/jncraton/rebrickable-import-dumps.svg?branch=master)](https://travis-ci.org/jncraton/rebrickable-import-dumps)

This is set of scripts to create a local copy of the Rebrickable database. It uses the CSV dumps provided by [Rebrickable](https://rebrickable.com/downloads/) and is a relatively quick and easy way to create a local copy of all Lego parts and set inventories.

It includes custom views and indices to make working with this data more efficient.

## Getting started

Simply run `make`. You will need sqlite3 and curl installed if they are not already.

This will download the table data from Rebrickable and import it into an SQLite database. The output database file is dist/bricks.db.

## Example queries

### List all colors

```sql
select id, name 
from colors;
```

### Get all parts in a set

```sql
select part_num, color_id, quantity
from set_parts
where set_num = '10193-1';
```

### List top 10 parts based on the number of sets they are in

```sql
select part_num, num_sets
from part_info
order by num_sets desc limit 10;
```

### More examples

These examples, along with others, are available in the runable SQLite script `examples.sql`.
