#/bin/bash

# Convert LAZ files DEM (tif) output
# LAZ is a compressed version of LAS (LASzip)

# Pull the latest pdal Docker image
docker pull pdal/pdal:latest

# Make sure these directories exist in the project
INPUTDIR="input_data"
OUTPUTDIR="output_data"

# Have to mount the local files to the Docker image with ABSOLUTE ?!?! paths, 
# so we start by storing the absolute path of this directory
LOCAL=$(pwd)
# Send the file names to docker to run pdal pipeline
(cd "${INPUTDIR}" && ls *.laz) | cut -d. -f1 | xargs -P14 -I{} \
docker run \
-v "${LOCAL}":/home \
-v "${LOCAL}"/"${INPUTDIR}":/"${INPUTDIR}" \
-v "${LOCAL}"/"${OUTPUTDIR}":/"${OUTPUTDIR}" \
pdal/pdal:latest pdal \
pipeline home/laz_to_dem.json \
--readers.las.filename="${INPUTDIR}"/{}.laz \
--writers.gdal.filename="${OUTPUTDIR}"/{}.tif
