library(tidyverse)

## Load the csv
df <- read_csv("../data/autism.csv")

# read_csv read the index as a column so we have to drop the first column, named X1
## Attribution https://stackoverflow.com/questions/4605206/drop-data-frame-columns-by-name
drop <- c("X1")
df <- df[ , !(names(df) %in% drop)]

# Three of our column names are mispelled (jundice -> jaundice, austim -> autism, and contry_of_res)
# Look at the column names with: names(df)
names(df)[14] <- "jaundice"
names(df)[15] <- "autism"
names(df)[16] <- "country_of_res"

# Save our cleaned dataframe
write_csv(df, path = "../data/autism.csv")