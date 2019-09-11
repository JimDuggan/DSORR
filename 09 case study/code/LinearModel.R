library(ggplot2)
library(dplyr)
library(tidyr)
library(lubridate)
library(readxl)


ener <- read_excel("datasets/energy/IrelandData January 2017.xlsx")

ener <- mutate(ener, DateTime    =  ymd_hms(DateTime),
                     HourOfDay   =  hour(DateTime),
                     MinuteOfDay =  minute(DateTime),
                     DayOfWeek   =  wday(DateTime,label=T))


ener <- separate(ener,DateTime,c("Date","Time"),sep=" ",remove=F)

weather <- read_excel("datasets/energy/Mac Head Wind Data.xlsx")

weather <- mutate(weather,Date = ymd(Date))

avr_daily_wind <- ener %>% group_by(Date) %>% 
  summarise(AverageWindGeneration=mean(Wind)) %>%
  mutate(Date=ymd(Date))

ggplot(data = weather,mapping = aes(x=Date,y=MaxTemp)) +
  geom_line(linetype="dotted") + geom_point(colour="blue") +
  xlab("Date") + ylab("MaxTemp")

ggplot(data = weather,mapping = aes(x=Date,y=AVRWind)) +
  geom_line(linetype="dashed") + geom_point(colour="blue") +
  xlab("Date") + ylab("Average Wind Speed (Knots")

gen_weather <- left_join(avr_daily_wind,weather) %>% 
                select(Date,AVRWind,AverageWindGeneration)

ggplot(data = gen_weather,mapping = aes(x=AVRWind,y=AverageWindGeneration)) +
  geom_point() +
  xlab("Average Wind Speed (Mace Head)") + ylab("Average Wind Generation") + 
  ggtitle("Wind Speed v Wind Power Generated")

ggplot(data = gen_weather,mapping = aes(x=AVRWind,y=AverageWindGeneration)) +
  geom_point() +
  geom_smooth(method = "lm",se=T)+
  xlab("Average Wind Speed (Mace Head)") + ylab("Average Wind Generation") + 
  ggtitle("Wind Speed v Wind Power Generated")

ggplot(data = gen_weather,mapping = aes(x=AVRWind,y=AverageWindGeneration)) +
  geom_point() +
  geom_smooth()+
  xlab("Average Wind Speed (Mace Head)") + ylab("Average Wind Generation") + 
  ggtitle("Wind Speed v Wind Power Generated")



mod <- lm(data = gen_weather,AverageWindGeneration~AVRWind)



p1 <- predict(mod,newdata = data.frame(AVRWind=25))

p2 <- predict(mod,newdata = data.frame(AVRWind=30))




