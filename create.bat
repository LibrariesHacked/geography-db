ogr2ogr -f "CSV" lsoa_boundaries.csv lsoa_boundaries.shp -lco GEOMETRY=AS_WKT -nlt PROMOTE_TO_MULTI
ogr2ogr -f "CSV" lad_boundaries.csv lad_boundaries.shp -lco GEOMETRY=AS_WKT -nlt PROMOTE_TO_MULTI
ogr2ogr -f "CSV" county_boundaries.csv county_boundaries.shp -lco GEOMETRY=AS_WKT -nlt PROMOTE_TO_MULTI
psql --set=sslmode=require -f create.sql -h host -p 5432 -U username postgres