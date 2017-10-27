all: bricks.db

bricks.db: tables/themes.csv tables/colors.csv tables/part_categories.csv tables/parts.csv tables/inventories.csv tables/sets.csv tables/inventory_parts.csv tables/inventory_sets.csv src/schema.sql src/import.sql
	sqlite3 bricks.db < src/schema.sql
	sqlite3 bricks.db < src/import.sql

tables/%.csv:
	curl --silent https://m.rebrickable.com/media/downloads/$(subst tables/,,$@) | tail -n +2 > $@

indices: bricks.db
	sqlite3 bricks.db < src/indices.sql

test: bricks.db
	sqlite3 bricks.db < examples.sql

clean:
	rm -f bricks.db
	rm -f tables/*.csv