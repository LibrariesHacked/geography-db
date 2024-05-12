cd data
ogr2ogr -f "CSV" lsoa_boundaries_bfc.csv lsoa_boundaries_bfc.shp -lco GEOMETRY=AS_WKT -nlt PROMOTE_TO_MULTI
ogr2ogr -f "CSV" lsoa_boundaries_bgc.csv lsoa_boundaries_bgc.shp -lco GEOMETRY=AS_WKT -nlt PROMOTE_TO_MULTI
ogr2ogr -f "CSV" datazone_boundaries.csv datazone_boundaries.shp -lco GEOMETRY=AS_WKT -nlt PROMOTE_TO_MULTI
ogr2ogr -f "CSV" country_boundaries.csv country_boundaries.shp -lco GEOMETRY=AS_WKT -nlt PROMOTE_TO_MULTI
ogr2ogr -f "CSV" region_boundaries.csv region_boundaries.shp -lco GEOMETRY=AS_WKT -nlt PROMOTE_TO_MULTI
ogr2ogr -f "CSV" district_borough_unitary_ward_region.csv district_borough_unitary_ward_region.shp -lco GEOMETRY=AS_WKT -nlt PROMOTE_TO_MULTI
ogr2ogr -f "CSV" ni_sa_boundaries.csv ni_sa_boundaries.shp -lco GEOMETRY=AS_WKT -nlt PROMOTE_TO_MULTI
ogr2ogr -f "CSV" county_bfc.csv county_bfc.shp -lco GEOMETRY=AS_WKT -nlt PROMOTE_TO_MULTI
ogr2ogr -f "CSV" county_bgc.csv county_bgc.shp -lco GEOMETRY=AS_WKT -nlt PROMOTE_TO_MULTI
ogr2ogr -f "CSV" district_bfc.csv district_bfc.shp -lco GEOMETRY=AS_WKT -nlt PROMOTE_TO_MULTI
ogr2ogr -f "CSV" district_bgc.csv district_bgc.shp -lco GEOMETRY=AS_WKT -nlt PROMOTE_TO_MULTI

cd os_open_names
copy *.csv os_open_names.csv
move os_open_names.csv ..

cd ..
psql --set=sslmode=require -f create.sql -h localhost -p 5432 -U postgres postgres