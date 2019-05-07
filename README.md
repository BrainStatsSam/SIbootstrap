# Selective peak inference: Unbiased estimation of raw and standardized effect size at local maxima
A collection of code to calculate the bias at the location of peaks and
reproduce figures. See https://www.biorxiv.org/content/10.1101/500512v2n
for the current version of the paper.

## Table of contents
* [Introduction](#introduction)
* [Folder Structure](#folderstruct)
    * [Bias Calculations](#biascalcs)
    * [Linear Modelling](#linmod)
    * [Power](#power)
    * [Results](#results)
    * [Results Figures](#resfigs)
    * [Simulations](#sims)
    * [Statistical Functions](#statfns)
* [Dependencies](#dependencies)
* [Citation](#cite)

## Introduction <a name="introduction"></a>
A collection of code to calculate the bias at the location of peaks and
reproduce figures from: 

## Folder Structure <a name="folderstruct"></a>

### Bias Calculations <a name="biascalcs"></a>

This folder contains the functions used to implement the bootstrap, 
circular inference and data-splitting to compute estiamtes of the mean, 
Cohen's d and partial R^2 estimates for the General Linear Model.

### Linear Modelling <a name="linmod"></a>
This folder contains MVlm_multivar which fits a multivariate linear model 
at every voxel (when the total number of subjects can fit into memory). 
It also includes examples of how large scale linear models can be run.

### Power <a name="power"></a>
This folder contains powercalcT and powercalcF which calculate power for
one-sample and general linear model respectively based on estimates of 
Cohen's d and Cohen's f^2.

### Results <a name="results"></a>
This folder contains the results of applying the bootstrap, 
circular inference and data-splitting to the UK biobank fMRI and VBM data
as well as functions to load and display these results.

### Results Figures <a name="resfigs"></a>
This folder contains code to reproduce all results figures from the paper 
as well as pdfs of the figures themselves. 

In order to run it you must first edit startup.m so that SIbootstrap_loc 
is the location of the SIbootstrap repository and then run startup.m to 
define SIbootstrap_loc and the variable def_col (which provides coloring 
for the plots). (Note that a prefix of S denotes a figure from the 
supplementary material.)

The simulations data can be regenerated from scratch (this has already been 
run, but see the code in the Simulations folder in order to re-run it if 
you would like to). And using the data from the Results folder (already 
calculated) we can produce the figures corresponding to the real data.

### Simulations <a name="sims"></a>
This folder contains code to generate the simulations for the paper as well
as the thresholds used. This requires the RFTtoolbox (see [Dependencies](#rftbox))
in order to run.

The subfolder Thresholds contains code to calculate the thresholds used in 
the one-sample and GLM simulations in the paper. store_thresh_nsubj.mat
stores these thresholds in a .mat file (as they take a non-trivial amount 
of time to run).

calcests_sims_thresh can be used to run the simulations and 
dispres_sims_thresh can be used to display the simulation results.

### Statistical Functions <a name="statfns"></a>
This folder contains general statistical functions used in modelling.

## Dependencies <a name="dependencies"></a>

### RFTtoolbox <a name="rftbox"></a>
In order to run most of this code you will need the RFTtoolbox package.  
This can be downloaded at: https://github.com/BrainStatsSam/RFTtoolbox.
This package is used to generate the simulations, perform RFT inference 
and perform general inference on local maxima.

### MATLAB
All code was run in matlab2015a.

### export_fig
Figures were produced using the export_fig matlab package. This can be 
downloaded at https://uk.mathworks.com/matlabcentral/fileexchange/23629-export_fig

## Citation <a name="dependencies"></a>
Please feel free to use any and all code from this repository in your own work
however if you do please cite our pre-print found at:
https://www.biorxiv.org/content/10.1101/500512v2n
and if you share code online that uses this code please include a link 
to this repository.
