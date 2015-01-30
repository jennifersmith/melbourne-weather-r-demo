# R basic plots are OK, but the best way to communicate findings is by compelling visualisation :)

# When the build in plots don't suffice, we use a library called ggplot

library(ggplot2) # install.packages('ggplot2')
library(scales)
# Step 4 - answer the question :  Was this Jan colder or warmer than last jan?
# same load fn from step 3
load.and.clean = function(){
  melb.temperature.data.raw <- read.csv('data/IDCJAC0010_086338_1800_Data.csv')
  melb.temperature.data.cleaned <- melb.temperature.data.raw[!is.na(melb.temperature.data.raw$Maximum.temperature..Degree.C.),]
  melb.temperature.data <- melb.temperature.data.cleaned[,c('Year', 'Month', 'Day', 'Maximum.temperature..Degree.C.')]
  names(melb.temperature.data)[4] <- 'Maximum.temperature'
  return(melb.temperature.data)
}

# a function to apply Jen's assessment from step 4
get.jens.assessment = function(){
  melb.temperature.data <- load.and.clean()
  melb.temperature.data$Jens.assessment <- cut(melb.temperature.data$Maximum.temperature, breaks=c(0,15,22,28,36,40,50), labels=c('Brrr', 'Kinda Chilly', 'Pleasantly cool', 'Nicely warm', 'Kinda hot', 'Arrrgh the Heat!'))
  return(melb.temperature.data)
}

show.month = function(month){
  my.data <- get.jens.assessment()
  my.data <- my.data[my.data$Month == month,]
  counts <- table(my.data$Jens.assessment, my.data$Year)
  my.data <- as.data.frame(counts)
  names(my.data)<-c('Assessment', 'Year', 'Freq')
  
  ggplot(data = my.data , aes(x = Year, y = Freq, fill = Assessment)) + 
    geom_bar(stat='identity')  + 
    coord_flip() +
    scale_fill_manual(values=rev(brewer_pal(type='div',palette=7)(6))) +
    labs(title = "Types of day by year")
}

# Let's show all the by month
yesterdays.weather = function(){
  my.data <- get.jens.assessment()
  my.data$YearMonth <- sprintf("%d%02d", my.data$Year, my.data$Month)
  counts <- table(my.data$Jens.assessment, my.data$YearMonth)

  my.data <- as.data.frame(counts)
  
  names(my.data)<-c('Assessment', 'Month', 'Freq')
  print(my.data)
  ggplot(data = my.data , aes(x = Month, y = Freq, fill = Assessment)) + 
    geom_bar(stat='identity')  + 
    coord_flip() +
    scale_fill_manual(values=rev(brewer_pal(type='div',palette=7)(6))) +
    labs(title = "Types of day by month")
}