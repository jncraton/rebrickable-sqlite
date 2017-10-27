all: bricks.db

bricks.db: tables/themes.csv tables/colors.csv tables/part_categories.csv tables/parts.csv tables/inventories.csv tables/sets.csv tables/inventory_parts.csv tables/inventory_sets.csv
	sqlite3 bricks.db < src/schema.sql
	sqlite3 bricks.db < src/import.sql

tables/%.csv:
	curl --silent -o $@ https://m.rebrickable.com/media/downloads/$(subst tables/,,$@)

indices: bricks.db
	sqlite3 bricks.db < src/indices.sql

test: bricks.db
	sqlite3 bricks.db < examples.sql

clean:
	rm -f bricks.db
	rm -f tables/*.csv