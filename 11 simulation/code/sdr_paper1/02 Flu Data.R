library(readr)
library(tibble)
library(tidyr)
library(dplyr)
library(ggplot2)

inc <- read_csv("11 simulation/code/sdr_paper1/data/Incidence.csv")

slice(inc,1:6)

t_inc <- gather(inc,Cohort,Incidence,Young:Elderly)

slice(t_inc,1:8)

y_data <- filter(t_inc,Cohort=="Young")

s_data <- select(inc,Week:Young)

slice(s_data,1:6)

wk_tot <- t_inc %>% group_by(Week) %>%
  summarise(Incidence=sum(Incidence))

srt <- arrange(wk_tot,desc(Incidence))

slice(srt,1:6)

add_col <- mutate(wk_tot,AttackRate=100000*Incidence/8000)

slice(add_col,1:6)

tot_inc <- mutate(inc,Total=Young+Child+Adult+Elderly)



slice(wk_tot,1:6)


fig.1 <- ggplot(data=tot_inc,mapping = aes(x=Week,y=Total)) + 
         geom_line() + geom_point()

fig.2 <- ggplot(t_inc,aes(x=Week,y=Incidence,color=Cohort, shape=Cohort)) + 
       geom_line() + geom_point()

fig.2.bw <- ggplot(t_inc,aes(x=Week,y=Incidence,shape=Cohort)) + 
  geom_line() + geom_point() + scale_fill_grey()

#ggsave("Figure_1.eps", dpi=600,plot = fig.1)
#ggsave("Figure_2.eps",dpi=600,plot = fig.2)
#ggsave("Figure_2_bw.eps",dpi=600,plot = fig.2.bw)


ggplot(t_inc,aes(x=Week,y=Incidence,fill=Cohort)) + geom_area() + scale_fill_grey()



# get the totals sick by cohort
t_coh <- t_inc %>% 
           group_by(Cohort) %>% 
           summarise(TotalInfected=sum(Incidence),
                     PeakValue=max(Incidence),
                     PeakWeek=Week[which(Incidence==max(Incidence))],
                     AvrValue=mean(Incidence),
                     SD=sd(Incidence))


