

#  ------------------------------------------------------------------------
#
# Title : test
#    By : Philippe MICHEL
#  Date : 2021-05-20
#    
#  ------------------------------------------------------------------------



# Packages ----------------------------------------------------------------

library("thesisph")
library("tidyverse")
library(tidyr)


# Format long pour les interventions
zz <- tt[,c(1,8,11,14,18)]
zzx <- zz %>% 
  pivot_longer(c(ni_m4 , ni_m12 ,ni_m24))