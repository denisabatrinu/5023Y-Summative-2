# :blossom:  Summative 2 BIO 5023Y


## ✨ Brief introduction
This is a solo project assignment for module BIO 5023Y - Data Science for Biologists. This assignment was completed in May 2023 during my second year of my BSc in Biological Sciences at University of East Anglia. Skills acquired during the completion of this assignment include:  data cleaning, exploratory analysis, data visualization & statistical model building and inference.
This report studies the effect of the gene raga-1 and how it interacts with stress on longevity and reproduction in the nematode worm Caenorhabditis elegans; see below for more information.


## 🎯 Objectives
-  Analyse one dataset contained within this repository (elegans_offspring.xlsx - used)
-  Use Markdown to write a formal lab report: hand the output in separately through Blackboard
-  Include all required scripts and Rmd files needed to fully reproduce your report here


## :round_pushpin:  Software specifications
This project was completed using R version 4.2.3 and RSTudio Desktop. Packages needed:
-  tidyverse **→** includes a range of essential packages (such as: ggplot2, dplyr, tidyr etc.)
-  readxl **→** reads the xlsx data file
-  performance **→** provides a collection of tools for visualizing models
-  ggpubr **→** facilitates ggplot2


## :bar_chart:	Data - elegans_offspring.xlsx
The variables within the data used for this project represent as follows:
| Variable            | Definition                              |
|---------------------|-----------------------------------------|
| rnai            | dsRNA treatment of nematodes targeting either the raga gene or ev (empty vector control) for gene expression knockdown |                      
| treatment        |dark or light exposure to light or dark (light is a stress environment for the nematode)          |
| replicate/plate       | replicate an ID number for each experiment       |
| offspring | number of offspring produced |
| parental treatment      | light or dark conditions experienced by the subjects parents            |
| parental_rnai       | rnai treatment of the subjects parents |             

