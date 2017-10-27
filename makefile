tables/%.csv:
	curl -o $@ https://m.rebrickable.com/media/downloads/$(subst tables/,,$@)