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
  labs(x = "Date of Experiment", y = "Q1 Score")) %>% # Additional Parenthesis to allow piping save
  ggsave("../figs/figs1.png", plot = ., height = 3, width = 6, units = "in", dpi = 600)

(week7_tbl %>%
  ggplot(aes(q1, q2, color = gender)) + 
  geom_jitter() +
  labs(x = "q1", y = "q2", color = "Participant Gender")) %>% # next few plots have the same dimensions becuase they all looked weird until these dimensions were selected
  ggsave("../figs/figs2.png", plot = ., height = 4, width = 8, units = "in", dpi = 600)
(week7_tbl %>%
    ggplot(aes(q1, q2)) +
    geom_jitter() +
    facet_grid(.~gender) +
    labs(x = "Score on Q1", y = "Score on Q2")) %>%
    ggsave("../figs/figs3.png", plot = ., height = 4, width = 8, units = "in", dpi = 600)

(week7_tbl %>%
  ggplot(aes(gender, timeSpent)) +
  geom_boxplot() +
  labs(x = "Gender", y = " Time Elapsed (mins)")) %>%
  ggsave("../figs/figs4.png", plot = ., height = 4, width = 8, units = "in", dpi = 600)
  
(week7_tbl %>%
  ggplot(aes(q5, q7, color = condition)) +
  geom_jitter() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(x = "Score on Q5", y = "Score on Q7", color = "Experimental Condition") +
  theme(legend.position = "bottom", legend.background = element_rect(fill = "#DFDFDF"))) %>%
  ggsave("../figs/figs5.png", plot = ., height = 4, width = 8, units = "in", dpi = 600)