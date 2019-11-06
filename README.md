# NAIP2017

## Tyson's Notes:

First, I am using my local workstation for compressing the original `*.las` files and for generating example DEMs as GeoTiff.

I am using [Docker](https://docker.com) to run HoBu's [PDAL](http://pdal.io).

Next, after the files are generated, I will move them to CyVerse using [iRODS iCommands](https://irods.org), and share the data in the data store.

### Compressing *.LAS to *.LAZ

I use PDAL to compress the tiles from *.las to *.laz

I use PDAL's `pipeline` option which requires a JSON file for each parameter. The file I used is called `compress.json` and has 
instructions for compressing the file as a LAS v1.4 filetype.

The example  bash script and configuration `json` are in the [/pdal_jsons](/pdal_jsons) directory.

### DEM creation

I use PDAL's `writer.gdal` option to create a bare earth `*.tif` (minimum height) model in the same `compress.json` pipeline command

The model uses all points, at 1 meter (m) resolution with a 1.5 m radius. The output tiles are between 360-370 Mb each. 

### Moving files up (and down) from CyVerse

I use iCommands to move the contents of the new output data directories: 

```
iput -KPbvrf /vol_c/AZGS_data /iplant/home/tswetnam/
```

the [iput](https://docs.irods.org/master/icommands/user/#iput) command uploads the data, the various flags are for checksum, progressive-verbose output, bulk upload, and forced overwrite. 

Once the data are in the data store, I can move them to a shared community directory within CyVerse.
