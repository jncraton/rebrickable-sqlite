create table colors (
  id numeric primary key,
  name text,
  rgb text,
  is_trans text
);

.mode csv
.import tables/colors.csv colors