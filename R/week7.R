# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
# Additional Library
# Additional Library
# Additional Library

# Data Import and Cleaning
week7_tbl <- read_csv("../data/week3.csv", col_names = TRUE) %>%
  mutate(condition = factor(condition, levels = c("A", "B", "C"), labels = c("Block A", "Block B", "Control")),
         gender = factor(gender, levels = c("M", "F"), labels = c("Male", "Female")),
         timeStart = ymd_hms(timeStart),
         timeEnd = ymd_hms(timeEnd),
         across(q1:q10, as.integer)) %>%
  filter(q6 == 1) %>%
  select(-q6) %>%
  mutate(timeSpent = timeEnd - timeStart)



# Visualization



























