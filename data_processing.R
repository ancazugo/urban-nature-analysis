
# Libraries ---------------------------------------------------------------

library(here)
library(dplyr)
library(readr)
library(tidyr)
library(tibble)
library(rgbif)

source("constants.R")

# Paths -------------------------------------------------------------------

inaturalist_data_path <- here(TABULAR_INPUT_DIR, "inaturalist_gbif/0109185-240626123714530.csv")
gift_plant_traits_path <- here(TABULAR_INPUT_DIR, "GIFT/plant_traits_GIFT.csv")
inaturalist_trees_path <- here(TABULAR_INPUT_DIR, "inaturalist_gbif/inaturalist_trees.csv")

# Processing --------------------------------------------------------------

gift_plant_traits_df <- read_csv(gift_plant_traits_path)
gift_tree_species_df <- gift_plant_traits_df |> 
    filter(trait_value_1.2.1 == 'tree')

inaturalist_df <- read_delim(inaturalist_data_path, delim = '\t') |> 
    filter(kingdom == 'Plantae') |> 
    filter(species %in% gift_tree_species_df$work_species) |> 
    filter(!is.na(decimalLatitude) & !is.na(decimalLongitude))

colnames(inaturalist_df)
    
write_csv(inaturalist_df, inaturalist_trees_path)
