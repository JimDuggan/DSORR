library(nycflights13)
library(dplyr)
library(ggplot2)
library(lubridate)


flights %>% 
  group_by(month) %>% 
  summarise(AvrDelay=mean(dep_delay,na.rm = T)) -> sum1

ggplot(sum1,aes(x=month,y=AvrDelay))+
  geom_point()+
  geom_line()

flights %>% 
  group_by(month,origin) %>% 
  summarise(AvrDelay=mean(dep_delay,na.rm = T),NumFLights=n()) -> sum2

ggplot(sum2,aes(x=month,y=AvrDelay,colour=origin))+
  geom_point()+
  geom_line()

flights %>% 
  mutate(DayOfWeek=wday(time_hour,label = T)) %>%
  group_by(DayOfWeek) %>%
  summarise(AvrDelay=mean(dep_delay,na.rm = T),NumFLights=n()) -> sum3

ggplot(sum3,aes(x=DayOfWeek,y=AvrDelay,group=1))+
  geom_point()+geom_line()


