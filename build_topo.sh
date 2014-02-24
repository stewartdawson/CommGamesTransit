#! /bin/bash
# City View
#touch json/city.json
rm -f json/city.json
ogr2ogr -f GeoJSON -where "name='Glasgow City'" json/city.json glasgow/glasgow.osm-polygon.shp
#touch json/riverClyde.json
rm -f json/riverClyde.json
ogr2ogr -f GeoJSON -clipdst json/city.json -where "name='River Clyde'" json/riverClyde.json scotland/waterways.shp

#Create Glasgow area detail
#touch glasgow/glasgow-from-scotland-roadlanduse.tab
#rm glasgow/glasgow-from-scotland-roadlanduse.tab
#ogr2ogr -f 'MapInfo File' -clipdst json/city.json glasgow/glasgow-from-scotland-roadlanduse.tab scotland/landuse.shp
#ogr2ogr -f 'MapInfo File' -clipdst json/city.json -update -append glasgow/glasgow-from-scotland-roadlanduse.tab scotland/roads.shp

# Commonwealth area with celtic park, the velodrome, and the athletes village
#touch json/CommArea.json
rm -f json/CommArea.json
# ogr2ogr -f GeoJSON -clipsrc -4.1936 55.8379 -4.2274 55.8513 -where "highway<>''" json/CommArea.json glasgow/glasgow.osm-line.shp
#ogr2ogr -f GeoJSON -clipsrc -4.1936 55.8379 -4.2274 55.8513 json/CommArea.json scotland/landuse.shp
ogr2ogr -f GeoJSON -clipsrc -4.1936 55.8379 -4.2274 55.8513 json/CommArea.json scotland/roads.shp

#touch json/CommTransit.json
rm -f json/CommTransit.json
ogr2ogr -f GeoJSON -clipsrc -4.1936 55.8379 -4.2274 55.8513 -where "type='bus_stop'" json/CommTransit.json scotland/points.shp

# Athletes' Village
#touch json/Village.json
rm -f json/Village.json
ogr2ogr -f GeoJSON -where "name='Athletes\' Village'" json/Village.json scotland/landuse.shp

# Celtic Park
#touch json/Celtic.json
rm -f json/Celtic.json
ogr2ogr -f GeoJSON -where "name='Celtic Park'" json/Celtic.json glasgow/glasgow.osm-polygon.shp

# Velodrome
#touch json/Velodrome.json
rm -f json/Velodrome.json
ogr2ogr -f GeoJSON -where "name='Sir Chris Hoy Velodrome'" json/Velodrome.json scotland/buildings.shp

# Ibrox Stadium
#touch json/Ibrox.json
rm -f json/Ibrox.json
ogr2ogr -f GeoJSON -where "name='Ibrox Stadium'" json/Ibrox.json glasgow/glasgow.osm-polygon.shp
#touch json/IbroxArea.json
rm -f json/IbroxArea.json
ogr2ogr -f GeoJSON -clipsrc -4.2931 55.8474 -4.3248 55.8573 json/IbroxArea.json scotland/landuse.shp

#touch json/IbroxTransit.json
rm -f json/IbroxTransit.json
ogr2ogr -f GeoJSON -clipsrc -4.2931 55.8474 -4.3248 55.8573  -where "type='bus_stop'" json/IbroxTransit.json scotland/points.shp

# build topo file
#touch topo/glasgow.json
rm -f topo/glasgow.json
topojson -p highway -p osm_id --id-property name -o topo/glasgow.json json/CommArea.json json/Village.json  json/Celtic.json json/Velodrome.json json/Ibrox.json json/city.json json/riverClyde.json json/IbroxArea.json json/CommTransit.json json/IbroxTransit.json
