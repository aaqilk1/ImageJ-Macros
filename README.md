# Welcome to the ImageJ Macros Repository for VMO/VMT Image Processing 

Currently, in order to run macros, navigate to Plugins > New > Macro and paste the code from the desired file. 

These macros have been developed under the following version of Fiji/ImageJ

ImageJ2
Version: 2.16.0/1.54p
Build: 26d66057dd
Date: 2024-10-15T19:41:44+0000
Mac OS X Sonoma 14.8.3 Intel 

I plan on incorporating these into the next version of Hughes Lab Tools or creating a standalone executable in the future as well as confirming functionality
on newer builds/releases across platforms. 


## Batch Sort

This macro is designed to help organize raw lionheart images across different days for analysis. A 2-plate experiment ranging over 4 imaging days with automatic stitching will have a folder structure as follows:

```
Day 1
  Plate 1
    020226_12623_Experiment1
      0209226_12623_Plate 1
        #0209226_Stitched
          E1_-2_1_1_Stitched[GFP 469,525]_001.tiff
          E2_-2_1_1_Stitched[GFP 469,525]_001.tiff
        E1_01_1_1_GFP_001.tif
        E1_01_1_2_BF_001.tif
```

And this structure would repeat per day per plate.

The macro will prompt you to select:
- A **source directory** (topmost experiment folder)
- A **target directory** (where sorted files go)
- Image type: `"Stitched"`, `"Raw"`, or `"Both"`

The resulting output folder structure will be:

```
Normalized_Output
  Plate 1
    E1
      Day 4_stitched_-2_1_1.tif
      Day 6_stitched_-2_1_1.tif
      Day 8_stitched_-2_1_1.tif
    E2
      Day 4_stitched_-2_1_1.tif
      Day 6_stitched_-2_1_1.tif
      Day 8_stitched_-2_1_1.tif
    E3
    E4
    E5
    E6
  Plate 2
    E1
    E2
```

Revision 1.1 of the macro supports images of a single channel only.  
Revision 1.2 is under development and will support multiple channels.

## Image Align 
This macro is designed to help align a sequence of different lionheart images that are skewed (as a result of cutting devices and IF staining). To use this macro, select a registration image in your source image folder. It is important to run this macro in the unsorted source folder straight from the lionheart. 

1. Select the source image (for that set of images, ie "E1" or "D12", usually the EC channel or BF have the best definition).
2. Select a destination folder for copied and transformed images (source images remain unmodified).
3. The macro will open the image in ImageJ and prompt you to use the line tool to highlight the horizontal reference.
4. Click "OK" and the macro will apply the rotation to destination images in the destination folder.


Conditions: 
- All channel images are in the same folder
- The channels are seperated by two underscores with the same prefix
- The horizontal reference must be selected by the user with the line tool

Revision 1.1 supports single and multi channel images in the same folder.  
Revision 1.2 is under development and will be have the option to select source images from the raw lionheart folder or batch-sorted
         output folders.


##
