#/bin/bash

# Inspect metadata for each file

# Pull the latest pdal Docker image
docker pull pdal/pdal:latest

# Make sure these directories exist in the project
INPUTDIR="input_data"

# Have to mount the local files to the Docker image with ABSOLUTE ?!?! paths, 
# so we start by storing the absolute path of this directory
LOCAL=$(pwd)
# Send the file names to docker to run pdal info
(cd "${INPUTDIR}" && ls *.las) | cut -d. -f1 | xargs -P14 -I{} \
docker run \
-v "${LOCAL}":/home \
-v "${LOCAL}"/"${INPUTDIR}":/"${INPUTDIR}" \
pdal/pdal:latest pdal \
info -i "${INPUTDIR}"/{}.las \
--readers.las.nosrs=true \
--metadata
