library(dplyr)
library(ggplot2)

source("07 simulation/sdr_paper2/R/tidy_sens.R")

lst_file  <- "07 simulation/sdr_paper2/vensim/BusinessStructures.lst"
vsc_file  <- "07 simulation/sdr_paper2/vensim/BusinessStructures.vsc"
sens_file <- "07 simulation/sdr_paper2/data/Sensitivity.tab"


sens_vars <- get_sens_vars(lst_file)
params    <- get_sens_params(vsc_file)
sens_data <- get_sens_data(sens_file)

ans <- tidy_vensim(sens_vars, params, sens_data, DT=0.125, START=0)

ggplot(filter(ans,Variable=="Business Structures"),aes(x=Time,y=Value,color=Simulation, group=Simulation)) + 
  geom_path() + scale_colour_gradientn(colours=rainbow(10))+
  ylab("Business Structures") +
  xlab("Time (Years)")  + guides(color=FALSE) 





