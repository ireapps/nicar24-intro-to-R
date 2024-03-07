## Introduction-to-R.html

## .RProj files, folder structure, general organization, notebooks

library(tidyverse)

read_csv("data/mlb.csv")

mlb <- read_csv("data/mlb.csv")

mlb %>% arrange(salary)

mlb %>% arrange(desc(salary))

mlb %>% filter(team=="Baltimore Orioles")

mlb %>% filter(team=="Baltimore Orioles" | team=="Washington Nationals")

mlb %>% filter(team=="Baltimore Orioles" & salary > 1000000)

mlb %>% distinct(team)

mlb %>% count(team)

mlb %>% group_by(team) %>% 
  summarise(total_sal = sum(salary)) %>% 
  arrange(desc(total_sal))

mlb %>% group_by(team) %>% 
  summarise(total_sal = sum(salary), avg_sal = mean(salary)) %>% 
  arrange(desc(total_sal))

mlb %>% group_by(team) %>% 
  summarise(total_sal = sum(salary), avg_sal = mean(salary), n=n()) %>% 
  arrange(desc(total_sal))

range(mlb$salary) # also works on dates, and on text (alphabetical order)

###### Salaries ######

library(tidyverse)
library(readxl)

salaries <- read_excel("data/Bloomington Salaries.xlsx", sheet = 1)

## talk about functions, function documentation, arguments
?read_excel()

str(salaries)

# who got the most in overtime? 
salaries %>% arrange(desc(overtime_oncall))

# which department pays the most in overtime? (TEACH na.rm=T)
salaries %>%
  group_by(department) %>% 
  summarise(total_OT = sum(overtime_oncall, na.rm=T)) %>% 
  arrange(desc(total_OT))

# who gets the most overtime as a pct of their total pay? 

## introduce mutate()

salaries %>% mutate(pct_overtime = overtime_oncall/total_comp)

## always test, then make it permanent 

salaries <- salaries %>% mutate(pct_overtime = overtime_oncall/total_comp)

salaries %>% arrange(desc(pct_overtime))

# which department pays out the highest percentage in overtime? 

salaries %>% 
  group_by(department) %>% 
  summarise(total_pay = sum(total_comp), total_OT = sum(overtime_oncall, na.rm=T)) %>% 
  mutate(OT_pct = total_OT/total_pay) %>% 
  arrange(desc(OT_pct))

####### WNBA salaries #########

wnba_salaries <- read_csv("data/wnba_salaries.csv")
wnba_teams <- read_csv("data/wnba_teams.csv")

## Discuss what is in each table. 

# Who has the highest overall field goal percentage? 
wnba_salaries %>% arrange(desc(field_goal_pct))

# OK, but this skewed a bit by people who hardly played. Let's set a threshold; 
# you had to play in at least 20 games (half of the season) and attempt at least 5 goals pg

wnba_salaries %>% 
  filter(games > 20 & field_goals_attempted) %>% 
  arrange(desc(field_goal_pct)) %>% 
  select(name, field_goal_pct)

# Who did these people play for? Need wnba_teams to answer that.

## Talk about different kinds of joins, 

###### hot 100 ########

hot100 <- read_csv("https://raw.githubusercontent.com/ireapps/nicar24-intro-to-R/main/data/hot-100-current.txt")

range(hot100$chart_week)

## talk about what is one row: song x week

hot100 %>% filter(performer=="Queen" & title=="Bohemian Rhapsody")

# What questions do you have about this data? 
# What was the #1 song the day you were born? 



