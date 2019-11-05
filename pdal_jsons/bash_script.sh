#/bin/bash

# Update Conda with latest version of PDAL
conda install -c conda-forge pdal python-pdal gdal

# Run with Docker
docker pull pdal/pdal:latest


# Create two output directories on my scratch storage
sudo mkdir -p /vol_c/AZGS_data/GIS_Data_NP112_NP212/NP212_2017/AZ/LAZ/UTM_12/
sudo mkdir -p /vol_c/AZGS_data/GIS_Data_NP112_NP212/NP212_2017/AZ/DEM/UTM_12/

# changed ownership of directories recursively
sudo chown -R tswetnam:tswetnam /vol_c/AZGS_data

# change into directory with first set of LAS data
cd /media/tswetnam/AZGS_data/GIS_Data_NP112_NP212/NP212_2017/AZ/LAS/UTM_12/


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

