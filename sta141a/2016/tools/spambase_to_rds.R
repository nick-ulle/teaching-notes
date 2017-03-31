# A function that reads the [spambase][] data into a tidyverse data frame and
# saves the result as an RDS file.
#
# [spambase]:  https://archive.ics.uci.edu/ml/datasets/Spambase

library(dplyr)
library(stringr)

convert_spam = function() {
  df = read.csv("../data/spam/spambase.data", header = FALSE)
  df = as_data_frame(df)

  names = readLines("../data/spam/spambase.names")[-(1:33)]
  names = str_split_fixed(names, ":", 2)[, 1]
  names(df) = c(names, "class")
  
  df$class = factor(c("ham", "spam"))[df$class + 1]

  saveRDS(df, "../data/spambase.rds")
}
