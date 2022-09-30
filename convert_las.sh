#/bin/bash

# Convert LAS files to LAZ and DEM output
# Depending on local docker permissions, may need to run as su or to add 
# docker permissions for user.
# See https://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo
# `sudo groupadd docker`
# `sudo gpasswd -a $USER docker`
# `newgrp docker`
# `docker run hello-world`


# Update Conda with latest version of PDAL
# conda install -c conda-forge pdal python-pdal gdal

# Pull the latest pdal Docker image
# May need to install Docker first, 
# see https://docs.docker.com/engine/install/ubuntu/
docker pull pdal/pdal:latest

# Make sure these directories exist in the project
INPUTDIR="input_data"
OUTPUTDIR="output_data"

# Have to mount the local files to the Docker image with ABSOLUTE ?!?! paths, 
# so we start by storing the absolute path of this directory
LOCAL=$(pwd)
# Send the file names to docker to run pdal pipeline
# Had to add `--readers.las.nosrs=true` to avoid projection error
# https://github.com/PDAL/PDAL/issues/3803
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
