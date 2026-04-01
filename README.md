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
This macro is designed to help organize raw lionheart images across different days for analysis. A 2-plate experiment ranging over 4 imaging days with automatic stitching will 
have a folder structure as follows: 

>Day 1 
  >Plate 1
    >020226_12623_Experiment1
      >0209226_12623_Plate 1
        >#0209226_Stitched
          >E1_-2_1_1_Stitched[GFP 469,525]_ 001.tiff 
          >E2_-2_1_1_Stitched[GFP 469, 525]_ 001.tiff
        >E1_01_1_1_GFP_001.tif
        >E1_01_1_2_BF_001.tif

And this structure would repeat per day per plate. The macro will prompt you to select a source directory (this should be the topmost directory for your experiments) and a target
directory (this is where you want your sorted files to be placed) and then will ask if you want "Stiched" images "Raw" images or "Both". The reslting output folder structure will 
be as follows: 

>Normalized_Output
  >Plate 1
    >E1
      >Day 4_stitched_-2_1_1.tif
      >Day 6_stitched_-2_1_1.tif
      >Day 8_stitched_-2_1-1.tif
    >E2
      >Day 4_stitched_-2_1-1.tif
      >Day 6_stitched_-2_1-1.tif
      >Day 8_stitched_-2_1-1.tif
    >E3
    >E4
    >E5
    >E6
>Plate 2
  >E1
  >E2

Revision 1.1 of the Macro supports images of a single channel only. Rev 1.2 is under development and will allow for sorting of multiple different channels. 



## Image Align 
This macro is designed to help align a sequence of different lionheart images that are skewed (as a result of cutting devices and IF staining). To use this macro, 
place all of your images in a certain folder and run the macro. It will prompt source and destination images and then bring up a dialog for "horizontal reference". 
Use the line tool to highlight a horizontal reference (such as a media channel) and the tool will automatically rotate the current image (and any other fluorescence channel) 
in the sequence to the new angle for stacking/color assignment. 


##
