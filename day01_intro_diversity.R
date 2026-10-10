
# Day 01 - Introduction to ecological data analysis
# Plant Ecology Data Analysis with R

# Check the R version
R.version.string

# Install the essential packages
#install.packages(c("tidyverse", "vegan", "readxl"))

# Load the packages

library(tidyverse)
library(vegan)
library(readxl)

# -----------------------------------------
# 1. Create a vegetation dataset
# -----------------------------------------

vegetation <- data.frame(
  row.names = c("Q1", "Q2", "Q3", "Q4", "Q5"),
  
  Lolium_perenne = c(40, 30, 60, 20, 10),
  
  Trifolium_repens = c(20, 25, 0, 35, 10),
  
  Plantago_lanceolata = c(10, 5, 10, 15, 30),
  
  Dactylis_glomerata = c(5, 15, 5, 10, 25)
)

# Display the vegetation table
vegetation


# -----------------------------------------
# 2. Biodiversity indices using vegan
# -----------------------------------------

# Species richness
richness <- specnumber(vegetation)

# Shannon diversity
shannon <- diversity(vegetation, index = "shannon")

# Gini-Simpson diversity
simpson <- diversity(vegetation, index = "simpson")

# Combine results into one table
results <- data.frame(
  Quadrat = rownames(vegetation),
  Richness = richness,
  Shannon = round(shannon, 3),
  Simpson = round(simpson, 3)
)

# Display results
print(results)

# -----------------------------------------
# 3. Scientific visualization with ggplot2
# -----------------------------------------

# Shannon diversity across quadrats

ggplot(results, aes(x = Quadrat, y = Shannon)) +
  geom_col(fill = "forestgreen", width = 0.65) +
  labs(
    title = "Plant diversity across quadrats",
    subtitle = "Shannon diversity index",
    x = "Sampling quadrat",
    y = "Shannon diversity (H')"
  ) +
  theme_minimal(base_size = 13)


# -----------------------------------------
# 4. Save the scientific figure
# -----------------------------------------

# Store the plot as an object
p1 <- ggplot(results, aes(x = Quadrat, y = Shannon)) +
  geom_col(fill = "forestgreen", width = 0.65) +
  labs(
    title = "Plant diversity across quadrats",
    subtitle = "Shannon diversity index",
    x = "Sampling quadrat",
    y = "Shannon diversity (H')"
  ) +
  theme_minimal(base_size = 13)

# Save the figure
ggsave(
  filename = "day01_shannon_diversity.png",
  plot = p1,
  width = 8,
  height = 5,
  dpi = 300
)



# -----------------------------------------
# 5. Export biodiversity results
# -----------------------------------------

write.csv(
  results,
  file = "day01_diversity_results.csv",
  row.names = FALSE
)

getwd()

list.files()

