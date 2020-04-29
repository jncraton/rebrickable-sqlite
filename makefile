DB = dist/bricks.db
sqldump = dist/bricks.sql

all: $(sqldump)

$(sqldump): $(DB)
	sqlite3 $(DB) .dump > $(sqldump)

$(DB): tables/themes.csv tables/colors.csv tables/part_categories.csv tables/parts.csv tables/part_relationships.csv tables/elements.csv tables/minifigs.csv tables/inventories.csv tables/sets.csv tables/inventory_parts.csv tables/inventory_sets.csv tables/inventory_minifigs.csv scripts/schema.sql scripts/import.sql
	sqlite3 $(DB) < scripts/schema.sql
	sqlite3 $(DB) < scripts/import.sql

tables/%.csv:
	curl --silent https://m.rebrickable.com/media/downloads/$(subst tables/,,$@).gz | gunzip -c | tail -n +2 > $@

indices: $(DB)
	sqlite3 $(DB) < scripts/indices.sql

test: $(DB)
	sqlite3 $(DB) < examples.sql

clean:
	rm -f $(DB)
	rm -f $(sqldump)
	rm -f tables/*.csv
