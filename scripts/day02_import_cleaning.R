
# Day 02 - Importing and cleaning ecological data

library(tidyverse)
library(readxl)
library(vegan)

# Check the working directory
getwd()

# Check project folders
list.dirs(recursive = FALSE)


# -----------------------------------------
# 1. Create an ecological dataset
# -----------------------------------------

flora <- data.frame(
  Quadrat = c("Q1", "Q2", "Q3", "Q4", "Q5"),
  Habitat = c("Grassland", "Grassland", "Forest",
              "Forest", "Grassland"),
  pH = c(6.5, 6.8, 5.2, NA, 7.1),
  Altitude = c(320, 345, 510, 530, 310),
  
  Lolium_perenne = c(40, 30, 0, 0, 45),
  Trifolium_repens = c(20, 25, 0, 5, 15),
  Plantago_lanceolata = c(10, 5, 0, 0, 20),
  Dactylis_glomerata = c(5, 15, 10, 5, 10),
  Poa_nemoralis = c(0, 0, 40, 35, 0),
  Dryopteris_filix_mas = c(0, 0, 25, 30, 0)
)

# Display the dataset
View(flora)

# Export the dataset to the data folder

write.csv(
  flora,
  file = "data/floristic_dataset.csv",
  row.names = FALSE
)


# Import the CSV file

flora_imported <- read_csv(
  "data/floristic_dataset.csv",
  show_col_types = FALSE
)

# Display imported data
View(flora_imported)



# -----------------------------------------
# 2. Inspect the imported dataset
# -----------------------------------------

# Dimensions: rows and columns
dim(flora_imported)

# Display the first six rows
head(flora_imported)

# Inspect variable types
glimpse(flora_imported)

# Summary statistics
summary(flora_imported)


# -----------------------------------------
# 3. Identify missing values
# -----------------------------------------

# Check all missing values
is.na(flora_imported)

# Count missing values in each column
colSums(is.na(flora_imported))

# Display rows containing at least one NA
flora_imported %>%
  filter(if_any(everything(), is.na))



# -----------------------------------------
# 4. Managing missing values
# -----------------------------------------

# Calculate mean pH without missing values
mean(flora_imported$pH, na.rm = TRUE)

# Mean soil pH by habitat

flora_imported %>%
  group_by(Habitat) %>%
  summarise(
    Mean_pH = mean(pH, na.rm = TRUE),
    Number_of_quadrats = n()
  )

# Better summary: report valid measurements

pH_summary <- flora_imported %>%
  group_by(Habitat) %>%
  summarise(
    Mean_pH = mean(pH, na.rm = TRUE),
    Total_quadrats = n(),
    Valid_pH = sum(!is.na(pH)),
    Missing_pH = sum(is.na(pH)),
    .groups = "drop"
  )

print(pH_summary)




# -----------------------------------------
# 5. Create the community matrix
# -----------------------------------------

# Select only species columns

species_matrix <- flora_imported %>%
  select(
    Lolium_perenne,
    Trifolium_repens,
    Plantago_lanceolata,
    Dactylis_glomerata,
    Poa_nemoralis,
    Dryopteris_filix_mas
  ) %>%
  as.data.frame()

# Assign quadrat names to rows
rownames(species_matrix) <- flora_imported$Quadrat

# Display the community matrix
View(species_matrix)

# Check dimensions
dim(species_matrix)



# -----------------------------------------
# 6. Create environmental data
# -----------------------------------------

environment <- flora_imported %>%
  select(
    Quadrat,
    Habitat,
    pH,
    Altitude
  )

# Display environmental variables
View(environment)

# Check dimensions
dim(environment)




# -----------------------------------------
# 7. Export cleaned and structured datasets
# -----------------------------------------

# Export the community matrix
write.csv(
  species_matrix,
  file = "results/day02_species_matrix.csv",
  row.names = TRUE
)

# Export environmental data
write.csv(
  environment,
  file = "results/day02_environment.csv",
  row.names = FALSE
)

# Export the missing data summary
write.csv(
  pH_summary,
  file = "results/day02_pH_summary.csv",
  row.names = FALSE
)

# Check exported files
list.files("results")


# Check consistency between the two datasets

identical(
  rownames(species_matrix),
  environment$Quadrat
)

