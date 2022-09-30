# NAIP2017

Originally forked from [https://github.com/azgs/NAIP2017](https://github.com/azgs/NAIP2017)

Code for converting NAIP LAS files to LAZ and DEM (GeoTiff) files. Relies on 
the [Docker](https://docker.com) [PDAL](http://pdal.io) image.

See [https://docs.docker.com/engine/install/ubuntu/](https://docs.docker.com/engine/install/ubuntu/)
for Docker installation.

Depending on local docker permissions, may need to run as superuser or to add 
docker permissions for user. See 
[https://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo](https://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo)

`sudo groupadd docker`
`sudo gpasswd -a $USER docker`
`newgrp docker`
`docker run hello-world`

Had to add `--readers.las.nosrs=true` to avoid projection error. See 
[https://github.com/PDAL/PDAL/issues/3803](https://github.com/PDAL/PDAL/issues/3803)

## DEM creation

From original fork (@tyson-swetnam):

> I use PDAL's `writer.gdal` option to create a bare earth `*.tif` (minimum 
height) model in the same `compress.json` pipeline command. The model uses all 
points, at 1 meter (m) resolution with a 1.5 m radius. The output tiles are 
between 360-370 Mb each. 
