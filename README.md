# Effective Degrees of Freedom of the Pearson's Correlation Coefficient under Serial Correlation

## Highlights
* Autocorrelation biases the standard error of Pearson's correlation and breaks the variance-stabilising property of Fisher's transformation.
* Severity of resting state fMRI autocorrelation varies systematically with region of interest size, and is heterogeneous over subjects.
* Commonly used methods (see Aux directory) to adjust correlation standard errors are themselves biased when true correlation is non-zero due to a confounding effect.
* We propose a ?xDF? method to provide accurate estimates of the variance of Pearson?s correlation -- before or after Fisher?s transformation -- that considers auto-correlation of each time series as well as instantaneous and lagged cross-correlation.
* Accounting for the autocorrelation in resting-state functional connectivity considerably alters the graph theoretical description of human connectome.


## Table of contents
* [Introduction](#introduction)
* [Folder Structure](#folderstruct)
* [Dependencies](#dependencies)
* [Examples](#Examples)
  * [Using xDF](#xxDF)
  * [Constructing Functional Connectivity (FC) Maps](#FC)


## Introduction <a name="introduction"></a>
Collection of code to calculate the bias at the location of peaks and
reproduce figures from:

## Folder Structure <a name="folderstruct"></a>

Bias Calculations contains the functions used to implement the bootstrap and
data-splitting.

Linear Modelling contains MVlm_multivar which fits a multivariate linear model 
at every voxel (when the total number of subjects can fit into memory). 
It also includes examples of how large scale linear models can be run 

Simulations contains the 

Real Data contains

Statistical Functions contains the general statistical functions used in modelling.

## Dependencies <a name="dependencies"></a>
Collection of scripts to implement the xDF method introduced in

RFTtoolbox package. This can be downloaded at: https://github.com/BrainStatsSam/RFTtoolbox.
