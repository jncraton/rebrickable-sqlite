bricks.db: tables/colors.csv
	sqlite3 bricks.db < schema.sql

tables/%.csv: bricks.db
	curl -o $@ https://m.rebrickable.com/media/downloads/$(subst tables/,,$@)

clean:
	rm -f bricks.db
	rm -f tables/*.csv