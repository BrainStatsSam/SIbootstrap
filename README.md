# Selective peak inference: Unbiased estimation of raw and standardized effect size at local maxima

## Highlights
* 

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
* [Set Up](#setup)
    * [Dependencies](#dependencies)
* [Examples](#Examples)
    * [Using xDF](#xxDF)
    * [Constructing Functional Connectivity (FC) Maps](#FC)

## Introduction <a name="introduction"></a>
Collection of code to calculate the bias at the location of peaks and
reproduce figures from:

## Folder Structure <a name="folderstruct"></a>

### Bias Calculations <a name="biascalcs"></a>

This folder contains the functions used to implement the bootstrap and
data-splitting.

### Linear Modelling <a name="linmod"></a>
This folder contains MVlm_multivar which fits a multivariate linear model 
at every voxel (when the total number of subjects can fit into memory). 
It also includes examples of how large scale linear models can be run.

### Power <a name="power"></a>

### Results <a name="results"></a>

### Results Figures <a name="resfigs"></a>

Unfortunately the image data is not sharable however using the real results 
provided in the results folder we can reproduce figures:  . (Where SM denotes
the supplementary material.)

The simulations data can be regenerated from scratch (see the code in the 
Simulations folder). Using the results (already calculated) provided there
we here repoduce figures:  

### Simulations <a name="sims"></a>

contains the 

Discuss the threshold calculations. 

### Statistical Functions <a name="statfns"></a>

contains the general statistical functions used in modelling.

## Set up <a name="setup"></a>
Collection of scripts to implement the xDF method introduced in

### Dependencies <a name="dependencies"></a>
MATLAB

For code needed to generate the simulations and perform RFT inference you
will need the RFTtoolbox package. 

This can be downloaded at: https://github.com/BrainStatsSam/RFTtoolbox.
