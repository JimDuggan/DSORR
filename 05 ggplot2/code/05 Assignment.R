library(readxl)
library(ggplot2)

# http://biostat.mc.vanderbilt.edu/wiki/Main/DataSets

orig_list <- readxl::read_excel("datasets/Titanic/titanic3.xls")
plist     <- orig_list

