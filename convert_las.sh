#/bin/bash

# Convert LAS files to LAZ and DEM output

# Pull the latest pdal Docker image
docker pull pdal/pdal:latest

# Make sure these directories exist in the project
INPUTDIR="input_data"
OUTPUTDIR="output_data"

# Have to mount the local files to the Docker image with ABSOLUTE ?!?! paths, 
# so we start by storing the absolute path of this directory
LOCAL=$(pwd)
# Send the file names to docker to run pdal pipeline
# Passing the -P option to xargs allows it to run in parallel
(cd "${INPUTDIR}" && ls *.las) | cut -d. -f1 | xargs -P14 -I{} \
docker run \
-v "${LOCAL}":/home \
-v "${LOCAL}"/"${INPUTDIR}":/"${INPUTDIR}" \
-v "${LOCAL}"/"${OUTPUTDIR}":/"${OUTPUTDIR}" \
pdal/pdal:latest pdal \
pipeline home/compress_las.json \
--readers.las.nosrs=true \
--readers.las.filename="${INPUTDIR}"/{}.las \
--writers.las.filename="${OUTPUTDIR}"/{}.laz \
--writers.gdal.filename="${OUTPUTDIR}"/{}.tif
