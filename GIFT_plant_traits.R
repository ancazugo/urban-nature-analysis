
# Libraries ---------------------------------------------------------------

library(here)
library(dplyr)
library(readr)
library(tidyr)
library(GIFT)

source("constants.R")

# Paths -------------------------------------------------------------------

plant_traits_gift_path <- here(TABULAR_INPUT_DIR, "GIFT/plant_traits_GIFT.csv")

# Processing --------------------------------------------------------------

# "1.2.1" = Growth form (herb, shrub, tree, other)
# "1.2.2" = Growth form (herb, graminoid, forb, subshrub, shrub, tree, palm, other)
# "2.4.1" = Deciduousness (deciduous, evergreen, variable)

plant_traits_gift_df <- GIFT::GIFT_traits(trait_IDs = c("1.2.1", "1.2.2", "2.4.1"))

write_csv(plant_traits_gift_df, plant_traits_gift_path)