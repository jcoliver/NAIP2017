#/bin/bash

# Convert LAS files to LAZ and DEM output

# Update Conda with latest version of PDAL
# conda install -c conda-forge pdal python-pdal gdal

# Pull the latest pdal Docker image
# May need to install Docker first, 
# see https://docs.docker.com/engine/install/ubuntu/
docker pull pdal/pdal:latest

# Make sure these directories exist in the project
INPUTDIR="input_data"
OUTPUTDIR="output_data"

# Send the file names to docker to run pdal pipeline
# Have to mount the local files to the Docker image with ABSOLUTE ?!?! paths
ls "${INPUTDIR}"/*.las | cut -d. -f1 | xargs -P14 -I{} \
docker run \
-v /home/jcoliver/Desktop/geo/NAIP2017/:/home \
pdal/pdal:latest pdal \
pipeline home/compress_las.json \
--readers.las.filename="${INPUTDIR}"/{}.las \
--writers.las.filename="${OUTPUTDIR}"/{}.laz \
--writers.gdal.filename="${OUTPUTDIR}"/{}.tif

# TODO: Above gives error:
# PDAL: Unable to open stream for 'input_data/input_data/3611105_SW_12.las' with error 'No such file or directory'
# So VERY close...

########################################
# Old below here


ls "${INPUTDIR}"/*.las | cut -d. -f1 | xargs -P14 -I{} \
docker run \
-v /home/jcoliver/Desktop/geo/NAIP2017/:/home \
echo ls

# --mount type=bind,src=/home/jcoliver/Desktop/geo/NAIP2017,dst=/home \ 
# -v ~/Desktop/geo/NAIP2017/:/home \


# run bash script to scrape the *.las file names and begin running latest PDAL Docker Container
cd /media/tswetnam/AZGS_data/GIS_Data_NP112_NP212/NP212_2017/AZ/LAS/UTM_12/
ls *.las | cut -d. -f1 | xargs -P14 -I{} \
docker run \
-v /media/tswetnam/AZGS_data/GIS_Data_NP112_NP212/NP212_2017/AZ/LAS/UTM_12/:/input_data \
-v /vol_c/AZGS_data/GIS_Data_NP112_NP212/NP212_2017/AZ/LAZ/UTM_12/:/output_data \
-v /vol_c/AZGS_data/GIS_Data_NP112_NP212/NP212_2017/AZ/DEM/UTM_12/:/output_dem \
-v /home/tswetnam/github/NAIP2017/:/home \
pdal/pdal:latest pdal \
pipeline /home/pdal_jsons/compress.json \
--readers.las.filename=/input_data/{}.las \
--writers.las.filename=/output_data/{}.laz \
--writers.gdal.filename=/output_dem/{}.tif

# change into directory with first set of LAS data
cd /media/tswetnam/AZGS_data/GIS_Data_NP112_NP212/NP112_2017/AZ/LAS/UTM_12/

# run bash script to scrape the *.las file names and begin running latest PDAL Docker Container
cd /media/tswetnam/AZGS_data/GIS_Data_NP112_NP212/NP112_2017/AZ/LAS/UTM_12/
ls *.las | cut -d. -f1 | xargs -P14 -I{} \
docker run \
-v /media/tswetnam/AZGS_data/GIS_Data_NP112_NP212/NP112_2017/AZ/LAS/UTM_12/:/input_data \
-v /vol_c/AZGS_data/GIS_Data_NP112_NP212/NP112_2017/AZ/LAZ/UTM_12/:/output_data \
-v /vol_c/AZGS_data/GIS_Data_NP112_NP212/NP112_2017/AZ/DEM/UTM_12/:/output_dem \
-v /home/tswetnam/github/NAIP2017/:/home \
pdal/pdal:latest pdal \
pipeline /home/pdal_jsons/compress.json \
--readers.las.filename=/input_data/{}.las \
--writers.las.filename=/output_data/{}.laz \
--writers.gdal.filename=/output_dem/{}.tif


# run bash script to scrape the *.las file names and begin running latest PDAL Docker Container
cd /media/tswetnam/AZGS_data/GIS_Data_NP112_NP212/NP112_2017/AZ/LAS/UTM_11/
ls *.las | cut -d. -f1 | xargs -P14 -I{} \
docker run \
-v /media/tswetnam/AZGS_data/GIS_Data_NP112_NP212/NP112_2017/AZ/LAS/UTM_11/:/input_data \
-v /vol_c/AZGS_data/GIS_Data_NP112_NP212/NP112_2017/AZ/LAZ/UTM_11/:/output_data \
-v /vol_c/AZGS_data/GIS_Data_NP112_NP212/NP112_2017/AZ/DEM/UTM_11/:/output_dem \
-v /home/tswetnam/github/NAIP2017/:/home \
pdal/pdal:latest pdal \
pipeline /home/pdal_jsons/compress.json \
--readers.las.filename=/input_data/{}.las \
--writers.las.filename=/output_data/{}.laz \
--writers.gdal.filename=/output_dem/{}.tif
