library(tidyverse)

# Read file
df <- foreign::read.arff("../data/Autism-Adult-Data.arff")

# Save as CSV for easier loading
write_csv(df, path = "../data/autism.csv")