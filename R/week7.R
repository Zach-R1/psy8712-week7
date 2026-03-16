# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)
library(GGally)
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
week7_tbl %>%
  ggpairs(columns = grep("^q", names(week7_tbl))) %>%
  ggsave(filename = "../figs/multivisual.png", height = 9, width = 9, units = "in", dpi = 600)
(week7_tbl %>%
  ggplot(aes(timeStart, q1)) +
  geom_point() +
  labs(x = "Date of Experiment", y = "Q1 Score")) %>%
  ggsave("../figs/figs1.png", plot = ., height = 3, width = 6, units = "in", dpi = 600)

























