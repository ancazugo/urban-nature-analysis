
from constants import *
import pandas as pd

# Define file paths
inaturalist_data_path = TABULAR_INPUT_DIR / "inaturalist_gbif/0109185-240626123714530.csv"
gift_plant_traits_path = TABULAR_INPUT_DIR / "GIFT/plant_traits_GIFT.csv"
inaturalist_trees_path = TABULAR_INPUT_DIR / "inaturalist_gbif/inaturalist_trees.csv"

# Processing
gift_plant_traits_df = pd.read_csv(gift_plant_traits_path)
gift_tree_species_df = gift_plant_traits_df[gift_plant_traits_df['trait_value_1.2.1'] == 'tree']

inaturalist_df = pd.read_csv(inaturalist_data_path, delimiter='\t')
inaturalist_df = inaturalist_df[
    (inaturalist_df['kingdom'] == 'Plantae') &
    (inaturalist_df['species'].isin(gift_tree_species_df['work_species'])) &
    (~inaturalist_df['decimalLatitude'].isna()) &
    (~inaturalist_df['decimalLongitude'].isna())
]

print(inaturalist_df.columns)

inaturalist_df.to_csv(inaturalist_trees_path, index=False)