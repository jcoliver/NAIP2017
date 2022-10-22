# NAIP2017

Originally forked from [https://github.com/azgs/NAIP2017](https://github.com/azgs/NAIP2017)

Code for converting NAIP LAS files to LAZ and DEM (GeoTiff) files. Relies on 
the [Docker](https://docker.com) [PDAL](http://pdal.io) image.

## Options

There are three options:

1. The script convert_las.sh takes an uncompressed LAS file and (a) creates a 
compressed version and saves this as a LAS file and (b) uses some PDAL magic to 
create a digital elevation model (DEM) from the LAS file and saves it as a 
geotiff file (.tif). It relies on the pipeline defined in compress_las.json. 
This is very close to the original workflow at 
[https://github.com/azgs/NAIP2017](https://github.com/azgs/NAIP2017) from which 
this repo was forked.
2. The script convert_laz.sh takes a compressed LAZ file and creates a digital 
elevation model (DEM) from the LAS file and saves it as a geotiff file (.tif).
Yes, also involving PDAL incantations. The processing relies on the pipeline 
in laz_to_dem.json.
3. The script inspect_las.sh is a reality check that prints out the metadata of 
las files in the input_data folder.

For any files you want to process, put them in the input_data folder and run 
the corresponding script from the top level of this repository (i.e. from the 
NAIP2017 directory).

## Docker details

See [https://docs.docker.com/engine/install/ubuntu/](https://docs.docker.com/engine/install/ubuntu/)
for Docker installation.

Depending on local docker permissions, may need to run as superuser or to add 
docker permissions for user. See 
[https://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo](https://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo)

`sudo groupadd docker`
`sudo gpasswd -a $USER docker`
`newgrp docker`
`docker run hello-world`

## Projection error

Had to add `--readers.las.nosrs=true` to avoid projection error in 
convert_las.sh script. See [https://github.com/PDAL/PDAL/issues/3803](https://github.com/PDAL/PDAL/issues/3803)

## DEM creation

From original fork (@tyson-swetnam):

> I use PDAL's `writer.gdal` option to create a bare earth `*.tif` (minimum 
height) model in the same `compress.json` pipeline command. The model uses all 
points, at 1 meter (m) resolution with a 1.5 m radius. The output tiles are 
between 360-370 Mb each. 
