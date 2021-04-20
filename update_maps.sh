#!/bin/bash
MAIN_DIR='/opt/cs16-server'
CS_DIR=$PRE_FOLDER'/cstrike'
wget $1 -q --show-progress
zipfile=$(find -type f -iname '*.zip')
mapname=${zipfile:2:-4}
unzip -q $zipfile
rm $zipfile
docker cp cstrike 'cs:/'$MAIN_DIR
rm -r cstrike
to_mapsini='echo '$mapname' >> '$MAIN_DIR'/cstrike/addons/amxmodx/configs/maps.ini'
docker exec -i cs /bin/sh -c "$to_mapsini"
to_mapcycle='echo '$mapname' >> '$MAIN_DIR'/cstrike/mapcycle.txt'
docker exec -i cs /bin/sh -c "$to_mapcycle"
docker restart cs
echo 'Docker containter cs restarted.'