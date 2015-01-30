# Step 4 - answer the question :  Was this Jan colder or warmer than last jan?
# same load fn from step 3
load.and.clean = function(){
  melb.temperature.data.raw <- read.csv('data/IDCJAC0010_086338_1800_Data.csv')
  melb.temperature.data.cleaned <- melb.temperature.data.raw[!is.na(melb.temperature.data.raw$Maximum.temperature..Degree.C.),]
  melb.temperature.data <- melb.temperature.data.cleaned[,c('Year', 'Month', 'Day', 'Maximum.temperature..Degree.C.')]
  names(melb.temperature.data)[4] <- 'Maximum.temperature'
  return(melb.temperature.data)
}

# a function to just load a particular month
load.month.data = function(month){
  melb.temperature.data <- load.and.clean()
  melb.temperature.data.jans <- melb.temperature.data[melb.temperature.data$Year %in% c(2014, 2015) & melb.temperature.data$Month == month,]
}

melb.temperature.jan.data <- load.month.data(1)
# remind ourselves what the fields are again
summary(melb.temperature.jan.data)

# to start with, it would be nice to have a data set with a row for each day of jan, and a column for 2014 and 2015 temps 
# luckily R has a package for this!
library(reshape) # if this gives an error, you need to install the reshape package:

#install.packages('reshape')
# see here for more about reshape: http://www.statmethods.net/management/reshape.html

melb.temperature.days.jan <- cast(melb.temperature.jan.data, Day~Year, value='Maximum.temperature')
# can be quite tricky to see what this does so let's look at the data"
View(melb.temperature.days.jan)

# plot 2014 and 2015 individually
plot(melb.temperature.days.jan$`2014`,type='l', main='Max temps in Jan 2014')


# plot 2014 and 2015 individually
plot(melb.temperature.days.jan$`2015`,type='l', main='Max temps in Jan 2015')

# together....

plot(melb.temperature.days.jan$`2014`,type='l', main='Max temps in Jan 2014 + 2015', col='darkgreen')

lines(melb.temperature.days.jan$`2015`,type='l', col='purple')

# Hmmm... what's the answer? It looks like they are kind of on the level - with that large mid Jan 2014 heatwave clearly evident

# Let's take a closer look at the statistics

boxplot(Maximum.temperature ~ Year, melb.temperature.jan.data)

# hmm, looks as if the avg is actually kinda higher in 2015 - that said, this is missing a few days of data!
# But definitely there was a wider range of temps in 2014.
# But does this answer my question. What do I mean by 'was Jan 2014 hotter than jan 2015'?
# My feeling is that there were more days that were 'far too hot' by my scale! 
# Using cut, we can divide up temps based on my tolerance levels!

melb.temperature.jan.data$Jens.assessment <- cut(melb.temperature.jan.data$Maximum.temperature, breaks=c(10,22,28,36,40,50), labels=c('Kinda Chilly', 'Pleasantly cool', 'Nicely warm', 'Kinda hot', 'Arrrgh the Heat!'))

plot(Jens.assessment~Year, melb.temperature.jan.data,ylab='')

counts <- table(melb.temperature.jan.data$Jens.assessment, melb.temperature.jan.data$Year)

counts

par(mar=c(5.1, 4.1, 4.1, 6.1), xpd=TRUE)
barplot(counts, main='Distribution of days in jan 2014 and 2015',
        xlab="Year")

# That's kind of telling me that there were more 'jen-friendly' days in jan this year ... but what would your answer to the question be?


