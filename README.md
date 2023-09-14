# ODTDemo
Demo MATLAB program for Optical Diffraction Tomography (ODT) data processing

## Features
Processing raw ODT holograms to generate 3D refractive index map of samples.

## Dependencies
MATLAB R2022a or higher version, with *Mapping Toolbox*, and *Image Processing Toolbox* installed.

## Dataset
Demo data is available at [here](https://drive.google.com/file/d/10QyexzHfRZ6S3d6xknMCRF3LrHak8n6B/view?usp=drive_link).

## Useage
1. Run ODTDemo.m and select proper raw TIFF stack file w/o samples in the popup window.
2. Wait a few minutes, a Rytov.tif file will be generated at the same folder of sample raw TIFF file.
3. You can use [ImageJ](https://imagej.net) or [Fiji](https://fiji.sc) to view Rytov.tif.
4. The votex size is also included when view with ImageJ or Fiji.

---------
## Learn more about ODT
* ODT for [live cell imaging](https://doi.org/10.1038/s41377-020-0249-4), and [technical details](https://static-content.springer.com/esm/art%3A10.1038%2Fs41377-020-0249-4/MediaObjects/41377_2020_249_MOESM1_ESM.pdf).
* ODT for [imaging artificial microstructures](https://opg.optica.org/jlt/abstract.cfm?URI=jlt-40-8-2474).

*If this code/program helps you, please cite one of my paper.*
