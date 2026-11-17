
# =========================================
# Day 03 - Data Manipulation with dplyr
# Plant Ecology Data Analysis with R
# =========================================

# 1. Load packages

library(tidyverse)
library(vegan)

# 2. Check the project directory

getwd()

# 3. Import the floristic dataset

flora <- read_csv(
  "data/floristic_dataset.csv",
  show_col_types = FALSE
)

# 4. Inspect the dataset

glimpse(flora)

# Display the table

View(flora)


# -----------------------------------------
# 2. Selecting variables
# -----------------------------------------

# Select environmental variables

environment_data <- flora %>%
  select(Quadrat, Habitat, pH, Altitude)

# Display the result

print(environment_data)



# -----------------------------------------
# 3. Filtering observations
# -----------------------------------------

# Select only forest quadrats

forest_data <- flora %>%
  filter(Habitat == "Forest")

# Display results

print(forest_data)


# -----------------------------------------
# 4. Combining filter() and select()
# -----------------------------------------

forest_environment <- flora %>%
  filter(Habitat == "Forest") %>%
  select(Quadrat, Habitat, pH, Altitude)

print(forest_environment)


# -----------------------------------------
# 5. Sorting ecological observations
# -----------------------------------------

# Sort quadrats by increasing altitude

flora_sorted <- flora %>%
  arrange(Altitude)

print(flora_sorted %>%
        select(Quadrat, Habitat, Altitude))


# Sort by habitat, then by altitude

flora_sorted_habitat <- flora %>%
  arrange(Habitat, Altitude)

print(flora_sorted_habitat %>%
        select(Quadrat, Habitat, Altitude))


# -----------------------------------------
# End of Day 03
# -----------------------------------------

# Export the selected forest environmental data

write.csv(
  forest_environment,
  "results/day03_forest_environment.csv",
  row.names = FALSE
)


