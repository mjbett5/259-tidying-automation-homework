#PSYC 259 Homework 3 - Data Tidying and Automation
#This assignment should be completed in RStudioCloud
#For full credit, provide answers for at least 6/9 questions

#this is the workspace that worked with push/commit. the other one didn't

#List names of students collaborating with: 

### SETUP: RUN THIS BEFORE STARTING ----------

install.packages("tidyverse") #If not installed
#Load packages
library(tidyverse)
paths <- c("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Fellowship_Of_The_Ring.csv",
           "https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Two_Towers.csv",
           "https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Return_Of_The_King.csv")

#Read data
#Each dataset has the words spoken by male/female characters in the LOTR triology by race (elf, hobbit, or human)

ds1 <- read_csv(paths[1])
ds2 <- read_csv(paths[2])
ds3 <- read_csv(paths[3])
ds_combined <- bind_rows(ds1, ds2, ds3)

### Question 1 ---------- 

#For this assignment, you created a fork from the Github repo and cloned your own copy
#As you work on the assignment, make commits and push the changes to your own repository.
#Make your repository public and paste the link here:

#The_Link:

#https://github.com/mjbett5/259-tidying-automation-homework/blob/main/tidying_automation_homework.R

tidying_automation_homework.R


#ANSWER
#YOUR GITHUB LINK: 

### Question 2 ---------- 

#Use a for loop with paths to read the data in to a new tibble "ds_loop" so that the data are combined into a single dataset
#(Yes, Vroom does this automatically but practice doing it with a loop)
#If you did this correctly, it should look the same as ds_combined created above
new_data<-tibble()

read_csv()
for (file in paths){
  temp_data<-read_csv(file)
  
  temp_data$file<- file
  new_data<- bind_rows(new_data,temp_data)
}


### Question 3 ----------

#Use map with paths to read in the data to a single tibble called ds_map
#If you did this correctly, it should look the same as ds_combined created above
mapped_data<-map(paths,~ read_csv(.x))

mapped_data<-bind_rows(mapped_data)



### Question 4 ----------

#The data are in a wider-than-ideal format. 
#Use pivot_longer to reshape the data so that sex is a column with values male/female and words is a column
#Use ds_combined or one of the ones you created in Question 2 or 3, and save the output to ds_longer
ds_longer<-pivot_longer(mapped_data,Female:Male,names_to ="Sex" ,values_to = "Count")



### Question 5 ----------

#It's helpful to know how many words were spoken, but each book was a different length
#The tibble below contains the total number of words in each book (make sure to run those lines so that it appears in your environment)
#Merge it into ds_longer and then create a new column that expresses the words spoken as a percentage of the total
total_words <- tibble(Film =  c("The Fellowship Of The Ring", "The Two Towers","The Return Of The King"),
                      Words = c(177277, 143436, 134462))

ds_with_words_col<-left_join(ds_longer,total_words)


### Question 6 ----------
#The function below creates a graph to compare the words spoken by race/sex for a single film
#The input for the function is a tibble that contains only a single film
#Write a for loop that iterates through the film names to apply the function to a subset of ds_longer (each film)
#Run all 6 lines code below to define the function (it should show in your environment after running)

words_graph <- function(df) {
  p <- ggplot(df, aes(x = Race, y = Words, fill = Sex)) + 
    geom_bar(stat = "identity", position = "dodge") + 
    ggtitle(df$Film) + theme_minimal()
  print(p)
}

for (movie in unique(ds_with_words_col$Film)) {
  words_graph(ds_with_words_col%>%filter(Film==movie))
}


### Question 7 ----------

#Apply the words_graph function again, but this time
#use split and map to apply the function to each film separately



### Question 8 ---------- 

#The PI wants a .csv file for each film with a row for male and a row for female
#and separate columns for the words spoken by each race and the percentage of words spoken by each race
#First, get the data formatted in the correct way
#From ds_longer, create a new tibble "ds_wider" that has columns for words for each race and percentage for each race




### Question 9 ---------

#Using your new "ds_wider" tibble, write the three data files using either a for loop or map
#The files should be written to "data_cleaned" and should be named by film title
