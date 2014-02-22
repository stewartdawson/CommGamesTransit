#! /bin/bash
# City View
touch json/city.json
rm json/city.json
ogr2ogr -f GeoJSON -where "name='Glasgow City'" json/city.json glasgow/glasgow.osm-polygon.shp
touch json/riverClyde.json
rm json/riverClyde.json
ogr2ogr -f GeoJSON -clipdst json/city.json -where "name='River Clyde'" json/riverClyde.json scotland/waterways.shp

# Commonwealth area with celtic park, the velodrome, and the athletes village
touch json/CommArea.json
rm json/CommArea.json
# ogr2ogr -f GeoJSON -clipsrc -4.1936 55.8379 -4.2274 55.8513 -where "highway<>''" json/CommArea.json glasgow/glasgow.osm-line.shp
ogr2ogr -f GeoJSON -clipsrc -4.1936 55.8379 -4.2274 55.8513 json/CommArea.json scotland/landuse.shp
ogr2ogr -f GeoJSON -clipsrc -4.1936 55.8379 -4.2274 55.8513 -update -append json/CommArea.json scotland/roadways.shp

touch json/CommTransit.json
rm json/CommTransit.json
ogr2ogr -f GeoJSON -clipsrc -4.1936 55.8379 -4.2274 55.8513 -where "type='bus_stop'" json/CommTransit.json scotland/points.shp

# Athletes' Village
touch json/Village.json
rm json/Village.json
ogr2ogr -f GeoJSON -where "name='Athletes\' Village'" json/Village.json scotland/landuse.shp

# Celtic Park
touch json/Celtic.json
rm json/Celtic.json
ogr2ogr -f GeoJSON -where "name='Celtic Park'" json/Celtic.json glasgow/glasgow.osm-polygon.shp

# Velodrome
touch json/Velodrome.json
rm json/Velodrome.json
ogr2ogr -f GeoJSON -where "name='Sir Chris Hoy Velodrome'" json/Velodrome.json scotland/buildings.shp

# Ibrox Stadium
touch json/Ibrox.json
rm json/Ibrox.json
ogr2ogr -f GeoJSON -where "name='Ibrox Stadium'" json/Ibrox.json glasgow/glasgow.osm-polygon.shp
touch json/IbroxArea.json
rm json/IbroxArea.json
ogr2ogr -f GeoJSON -clipsrc -4.2931 55.8474 -4.3248 55.8573 json/IbroxArea.json scotland/landuse.shp

touch json/IbroxTransit.json
rm json/IbroxTransit.json
ogr2ogr -f GeoJSON -clipsrc -4.2931 55.8474 -4.3248 55.8573  -where "type='bus_stop'" json/IbroxTransit.json scotland/points.shp

# build topo file
touch topo/glasgow.json
rm topo/glasgow.json
topojson -p highway -p osm_id --id-property name -o topo/glasgow.json json/CommArea.json json/Village.json  json/Celtic.json json/Velodrome.json json/Ibrox.json json/city.json json/riverClyde.json json/IbroxArea.json json/CommTransit.json json/IbroxTransit.json
