library(tidyverse)
library(rgdal)
library(RSQLite)
library(leaflet)
library(sf)

## Functions

num_from_fac <- function(fac) as.numeric(levels(fac))[fac]

# Read in original file

file_import <- "../census2016_eiuwi_qld_short.gpkg"
g_layers <- ogrListLayers(file_import)
g_layer <- "census2016_eiuwi_qld_sa2_short"

imported_layer <- readOGR(file_import, g_layer, verbose = FALSE)  # takes long time

# Save single layer as RDS for quick import 

file_export <- "census2016_eiuwi_qld_sa2_short.rds"
saveRDS(imported_layer, file_export)

#### Playground ####
file <- "census2016_eiuwi_qld_sa2_short.gpkg"
g_layers <- ogrListLayers(file)
dta <- src_sqlite(file) 

## Search for layers that contain specific columns

for(g_layer in g_layers){
  df <- tbl(src_sqlite(file), g_layer)
  tbldata <- tbl (dta, g_layer) #Create a table from a data source
  tbldf <- as.data.frame (tbldata) #Create a data frame
  cols <- names(tbldf)
  #ag_cols <- cols[grep("^(?=.*Ag_)(?!.*Fshg)", cols, perl = TRUE)]
  if(length(ag_cols)>0){
    print(g_layer)
  }
  #qld_gpkg <- readOGR("census2016_eiuwh_qld_short.gpkg", g_layer, verbose = FALSE)  
}

g_layer <- "census2016_eiuwi_qld_sa2_short"

## Use rgdal tbl function

tbldata <- tbl (dta, g_layer) #Create a table from a data source
tbldf <- as.data.frame (tbldata) #Create a data frame
cols <- names(tbldf)
base_cols <- c("primaryindex", "sa1_7digitcode_2016")
ag_cols <- cols[grep("^(?=.*Ag)", cols, perl = TRUE)]
tot_cols <- cols[grep("^._Tot", cols, perl = TRUE)]
my_cols <- c(base_cols, ag_cols, tot_cols)
tbldf <- tbldf %>% select(my_cols)

## Use readOGR - very slow

qld_gpkg <- readOGR(file, g_layer, verbose = FALSE)  

my_ops <- num_from_fac(qld_gpkg$P_AgriForestFish_Tot)/num_from_fac(qld_gpkg$P_Tot_Tot)

my_weird <- qld_gpkg %>% as.data.frame() %>% select(grep("P_", names(.))) %>%  filter(num_from_fac(P_Tot_Tot) < num_from_fac(P_AgriForestFish_Tot))

leaflet(qld_gpkg) %>%
  addTiles() %>%
  addPolylines(weight = 1, fill = TRUE, fillOpacity = my_ops)

ogrInfo(file, g_layer)
  
writeOGR(qld_gpkg, "census2016_eiuwi_qld_sa2_short.gpkg", driver = "GPKG", layer = g_layer)

# 190911

saveRDS(qld_gpkg, test_file)

## Use sf to speed up the read

qld_gpkg2 <- readRDS(test_file)  

my_ops <- num_from_fac(qld_gpkg2$P_AgriForestFish_Tot)/num_from_fac(qld_gpkg2$P_Tot_Tot)

leaflet(qld_gpkg2) %>%
  addTiles() %>%
  addPolygons(weight = 1, fill = TRUE, fillOpacity = my_ops)

