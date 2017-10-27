bricks.db: tables/colors.csv tables/parts.csv tables/sets.csv tables/inventory_parts.csv tables/inventory_sets.csv
	sqlite3 bricks.db < schema.sql

tables/%.csv:
	curl -o $@ https://m.rebrickable.com/media/downloads/$(subst tables/,,$@)

clean:
	rm -f bricks.db
	rm -f tables/*.csv