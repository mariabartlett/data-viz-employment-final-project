# data-viz-employment-final-project

# PPOL-5202 Final Project: Labor and global conflict

## Description

Our study seeks to descriptively analyze the relationship between violence and employment around the world. 

## Research Questions

1. How does the relationship between conflict and employment vary across different global regions? 
2. Does employment in certain industries have a positive / negative correlation with conflict?
3. How does unemployment vary across demographic groups during times of conflict? 
	
## Input Data

| Data source | File name | Year(s) of data  | Level of file  | Key variables(s) |
| ------- | --- | --- | --- | --- | 
| Armed Conflict Location & Event Data (ACLED) | `1997-01-01-2024-11-20.csv` | January 1, 1997 – November 20, 2024 | Incident | Conflict country, conflict date, conflict type, fatality count 
| International Labour Organization (ILO) "Employment by ILO sector and sex (thousands) - Annual" Table | `EMP_TEMP_SEX_IND_NB_A-filtered-2024-11-23.csv` | 2000 - 2023 | Country - year - gender - industry | Employment counts and percentages by industry
| World Bank Group Population Data | `wb_wdi_pop.csv` | 1990 - 2023 | Country | Total country population
| World Bank Group Unemployment Data | `wb_wdi_unemp.csv` | 1991 - 2023 | Country - unemployment metric | Percent unemployed, by gender and age group 

* The raw ACLED, ILO, and World Bank data are available on Google Drive at [this location](https://drive.google.com/drive/folders/1YN7C2_ZeuKh0AmLYQu94xCisa-Ror5Cj). Because of file size, these files are not available in this GitHub repo.

## Processed Analytic Data

| File name | Year(s) of data  | Level of file  | Data purpose |
| ------- | --- | --- | --- |
| `ACLED-event-level-1997-2024.csv` | January 1, 1997 – November 20, 2024 | Incident | Provides comprehensive ACLED incident-level data for geospatial visualization
| `ACLED-sector-employment-annual-2000-2023.csv` | 2000 - 2023 | Country - year - industry | Provides rates of violence alongside data on sector employment
| `ACLED-unemployment-annual-1997-2023.csv` | 1997 - 2023 | Country - year - unemployment metric | Provides rates of violence alongside data on unemployment

* The processed analytic data files are available on Google Drive at [this location](https://drive.google.com/drive/folders/17mzLDUja00r7Ne5ycm5DB1MZFcrWuuEd). Because of file size, these files are not available in this GitHub repo.

## Code & Output

All code is available in `02_Scripts`. A description of the purpose and output produced by each script follows below. The `01_data_prep.qmd` must be run before `02_data_viz.qmd` and `03_shiny_viz.qmd`. However, `02_data_viz.qmd` and `03_shiny_viz.qmd` are independent of each other and can be run in either order.

| Script | Purpose | Input file(s) | Output file(s)
| ------- | --- | --- | --- |
| `01_data_prep.qmd` | Perform data cleaning, variable constructions, and validation on BEA data | Raw ACLED (`1997-01-01-2024-11-20.csv`), ILO (`EMP_TEMP_SEX_IND_NB_A-filtered-2024-11-23.csv`), and World Bank data (`wb_wdi_pop.csv`; `wb_wdi_unemp.csv`)  | Analytic files (`ACLED-event-level-1997-2024.csv`; `ACLED-sector-employment-annual-2000-2023.csv`; `ACLED-unemployment-annual-1997-2023.csv`) |
| `02_data_viz.qmd` | Create data visualizations with `ggplot2` and `plot_ly` to be rendered in Quarto | `ACLED-event-level-1997-2024.csv`; `ACLED-sector-employment-annual-2000-2023.csv`; `ACLED-unemployment-annual-1997-2023.csv` | `02_data_viz.html`
| `03_shiny_viz.qmd` | Create Shiny dashboard | `ACLED-event-level-1997-2024.csv`; `ACLED-sector-employment-annual-2000-2023.csv`; `ACLED-unemployment-annual-1997-2023.csv` | [Shiny dashboard](https://js5241.shinyapps.io/viz_final/)

## Presentation & Report

The slide deck for our project presentation is available in the `03_Presentation` folder. The full project report is available in the `04_Report` folder.

## Authors

Jungling Shao, Katharyn Loweth, Maria Bartlett, Sam Cohen, Shun Liu, & Yuhan Ma

## Data Source References

Armed Conflict Location and Event Data (2024). ACLED | Armed Conflict Location & Event Data. ACLED. Accessed November 2024. https://acleddata.com/

International Labor Organization (2024). Toggle navigation ILOSTAT data explorer - Table: “Employment by ILO sector and sex (thousands) - Annual”; Years: “2000-2023.” International Labor Organization. Accessed November 2024. 
[https://rshiny.ilo.org/dataexplorer58/?lang=en&id=SDG_0831_SEX_ECO_RT_A](https://rshiny.ilo.org/dataexplorer58/?id=EMP_TEMP_SEX_IND_NB_A)

World Bank Group (2024). World Development Indicators. World Bank Group. Accessed November 2024. https://databank.worldbank.org/home

