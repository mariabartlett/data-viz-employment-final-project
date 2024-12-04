# data-viz-employment-final-project

# PPOL-5202 Final Project: Labor and global conflict

## Description

Our study seeks to descriptively analyze the relationship between violence and employment around the world. 

## Research Questions

1. How does the relationship between conflict and employment vary across different global regions? 
2. Does employment in certain industries have a positive / negative correlation with conflict?
3. What are the effects of conflict on unemployment across demographics groups? 
	
## Input Data

| Data source | File name | Year(s) of data  | Level of file  | Key variables(s) |
| ------- | --- | --- | --- | --- | 
| Armed Conflict Location & Event Data (ACLED) | `1997-01-01-2024-11-20.csv` | January 1, 1997 – November 20, 2024 | Incident | Conflict country, conflict date, conflict type, fatality count 
| International Labour Organization (ILO) "Employment by ILO sector and sex (thousands) - Annual" Table | `EMP_TEMP_SEX_IND_NB_A-filtered-2024-11-23.csv` | 2000 - 2023 | Country - year - gender - industry | Employment counts and percentages by industry
| World Bank Group Population Data | `wb_wdi_pop.csv` | 1990 - 2023 | Country | Total country population
| World Bank Group Unemployment Data | `wb_wdi_unemp.csv` | 1991 - 2023 | Country - unemployment metric | Percent unemployed, by gender and age group 

* The raw ACLED, ILO, and World Bank data are available on Google Drive at [this location](https://drive.google.com/drive/folders/1YN7C2_ZeuKh0AmLYQu94xCisa-Ror5Cj). Because of file size, these files are not available in this GitHub repo.

## Processed Analytic Data

| File name | Year(s) of data  | Level of file  | Data description |
| ------- | --- | --- | --- |
| `ACLED-event-level-1997-2024.csv` | January 1, 1997 – November 20, 2024 | Incident | XXX
| `ACLED-sector-employment-annual-2000-2023.csv` | 2000 - 2023 | Country - year - industry | XXX
| `ACLED-unemployment-annual-1997-2023.csv` | 1997 - 2023 | Country - year - unemployment metric | XXX

* The processed analytic data files are available on Google Drive at [this location](https://drive.google.com/drive/folders/17mzLDUja00r7Ne5ycm5DB1MZFcrWuuEd). Because of file size, these files are not available in this GitHub repo.

## Code & Output

All code is available in `02_Scripts`. A description of the purpose and output produced by each script follows below (scroll horizontally to see full table):

| Script | Purpose | Input file(s) | Output file(s)
| ------- | --- | --- | --- |
| `01_data_prep.qmd` | Perform data cleaning, variable constructions, and validation on BEA data | Raw ACLED (`1997-01-01-2024-11-20.csv`), ILO (`EMP_TEMP_SEX_IND_NB_A-filtered-2024-11-23.csv`), and World Bank data (`wb_wdi_pop.csv`; `wb_wdi_unemp.csv`)  | Analytic files (`ACLED-event-level-1997-2024.csv`; `ACLED-sector-employment-annual-2000-2023.csv`; `ACLED-unemployment-annual-1997-2023.csv`)

## Report

The full project report ...

## Authors

Jungling Shao, Katharyn Loweth, Maria Bartlett, Sam Cohen, Shun Liu, & Yuhan Ma

## Data Source References

Employment by ILO sector and sex (thousands)—Annual (2000-2023). [Dataset]. International Labour Organization. https://rshiny.ilo.org/dataexplorer58/?id=EMP_TEMP_SEX_IND_NB_A


