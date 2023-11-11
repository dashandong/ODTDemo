# ODTDemo

Demo MATLAB program for Optical Diffraction Tomography (ODT) data processing

## Features

Processing raw ODT holograms to generate 3D refractive index map of samples.

## Dependencies

- MATLAB R2022a or higher version, with
  - [x] *Mapping Toolbox*
  - [x] *Image Processing Toolbox*

## Dataset

Demo data is available for:

- [COS-7 Live Cell Sample][demodate_Cos7_LiveCell]
- [*C.elegans* Spermatids Sample][demodate_CelegansSpermatids]

## Useage

1. Run ODTDemo.m and select proper raw TIFF stack file w/o samples in the popup window.
2. Wait a few minutes, a Rytov.tif file will be generated at the same folder of sample raw TIFF file.
3. You can use [ImageJ][imagej] or [Fiji][fiji] to view Rytov.tif.
4. The votex size is also included when view with ImageJ or Fiji.

---------

## Learn more about ODT

- ODT for [live cell imaging][sr-fact], and [technical details][sr-fact-sup].
- ODT for [studying mitopherogenesis process][spermatids-paper].
- ODT for [imaging artificial microstructures][jlt-paper].

*If this code/program helps you, please cite our papers.*

[demodate_CelegansSpermatids]: https://drive.google.com/file/d/1cDtvC-lBBGq7cVr0NRfC0znxAmkCDrna/view?usp=sharing
[demodate_Cos7_LiveCell]: https://drive.google.com/file/d/1i1_jOE4T3X6maEetQlatJ4QM_jDGpZHf/view?usp=sharing
[imagej]: https://imagej.net
[fiji]: https://fiji.sc
[sr-fact]: https://doi.org/10.1038/s41377-020-0249-4
[sr-fact-sup]: https://static-content.springer.com/esm/art%3A10.1038%2Fs41377-020-0249-4/MediaObjects/41377_2020_249_MOESM1_ESM.pdf
[jlt-paper]: https://opg.optica.org/jlt/abstract.cfm?URI=jlt-40-8-2474
[spermatids-paper]: https://doi.org/10.1038/s41556-023-01264-z
