# We can load the data using read.csv

melb.temperature.data.raw <- read.csv('data/IDCJAC0010_086338_1800_Data.csv')

# Let's see what we have
View(melb.temperature.data.raw)

summary(melb.temperature.data.raw)

# Might want to clean up the data and remove some of the years with no temp

melb.temperature.data.cleaned <- melb.temperature.data.raw[!is.na(melb.temperature.data.raw$Maximum.temperature..Degree.C.),]

# Also there are a lot of fields in there that are not particularly interesting to us, so let's reduce the data to just what we care about

melb.temperature.data.cleaned[,-c(1)] 

melb.temperature.data <- melb.temperature.data.cleaned[,c('Year', 'Month', 'Day', 'Maximum.temperature..Degree.C.')]

# while we are at it, lets rename that maximum temp column 

names(melb.temperature.data)[4] <- 'Maximum.temperature'

# Now we have a dataset!

summary(melb.temperature.data)
View(melb.temperature.data)