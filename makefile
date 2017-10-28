db = dist/bricks.db
sqldump = dist/bricks.sql

all: $(sqldump)

$(sqldump): $(db)
	sqlite3 $(db) .dump > $(sqldump)

$(db): tables/themes.csv tables/colors.csv tables/part_categories.csv tables/parts.csv tables/inventories.csv tables/sets.csv tables/inventory_parts.csv tables/inventory_sets.csv src/schema.sql src/import.sql
	sqlite3 $(db) < src/schema.sql
	sqlite3 $(db) < src/import.sql

tables/%.csv:
	curl --silent https://m.rebrickable.com/media/downloads/$(subst tables/,,$@) | tail -n +2 > $@

indices: $(db)
	sqlite3 $(db) < src/indices.sql

test: $(db)
	sqlite3 $(db) < examples.sql

clean:
	rm -f $(db)
	rm -f $(sqldump)
	rm -f tables/*.csv