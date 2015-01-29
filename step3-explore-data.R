# Firstly let's pull all that loading code into a function from step 1 so we can use it again
load.and.clean = function(){
  melb.temperature.data.raw <- read.csv('data/IDCJAC0010_086338_1800_Data.csv')
  melb.temperature.data.cleaned <- melb.temperature.data.raw[!is.na(melb.temperature.data.raw$Maximum.temperature..Degree.C.),]
  melb.temperature.data <- melb.temperature.data.cleaned[,c('Year', 'Month', 'Day', 'Maximum.temperature..Degree.C.')]
  names(melb.temperature.data)[4] <- 'Maximum.temperature'
  return(melb.temperature.data)
}

# Now let's explore!

melb.temperature.data <- load.and.clean()

View(melb.temperature.data)

# The first thing I want to know is - how complete is the data?

table(melb.temperature.data$Year)
table(melb.temperature.data$Year,melb.temperature.data$Month)

# Looks like we have a full set of 2014 data, partial 2013 and only a few observations in 2015 (taken on 29th of Jan)
# Probably need to be mindful of this when comparing the data later on

#Let's just focus on jan 2015 and jan 2014... are the temps in a 'sensible range' ? 

melb.temperature.data.jans <- melb.temperature.data[melb.temperature.data$Year %in% c(2014, 2015) & melb.temperature.data$Month == 1,]

boxplot(melb.temperature.data.jans$Maximum.temperature)

# So those look pretty standard to me - you can see that the majority of readings are in the 22ish to 30 ish range, with a mean of 25 
# There are wider variations, plus some outliers sitting at the top above 40 degrees

# We could do a lot more exploration of the data and checking it looks sensible, but let's go to our question....