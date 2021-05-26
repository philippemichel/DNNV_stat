library(networkD3)
library(ytidyverse)
library(tidyr)


ttz <- as_tibble(tt[,c(11,14,18)])
levels(ttz$ni_m4) <- c("niveau1", "CAMSP", "Pas d'intervention")
levels(ttz$ni_m12) <- c("niveau1", "CAMSP", "Pas d'intervention")
levels(ttz$ni_m24) <- c("niveau1", "CAMSP", "Pas d'intervention")
ttz$ni_m12[ttz$ni_m4 == "CAMSP"] <- "CAMSP"
ttz$ni_m24[ttz$ni_m12 == "CAMSP"] <- "CAMSP"
ttz <- na.omit(ttz)
m4 <- paste0("m04_",ttz$ni_m4)
m12 <- paste0("m12_",ttz$ni_m12)
m24 <- paste0("m24_",ttz$ni_m24)

sourcex <- c(m4,m12)
ciblex <-  c(m12,m24)
zz <- table(sourcex, ciblex)
 
zz <-
  data.frame(source = as.factor(sourcex),
             cible = as.factor(ciblex)
  )
zz <- na.omit(zz)
zzt <- table(zz$source, zz$cible)
llf <- levels(zz$source)
ccf <- levels(zz$cible)
ll <- NULL
cc <- NULL
vv <- NULL
for (l in 1:length(llf)) {
  for (c in 1:length(ccf)) {
    zzv <- zzt[l, c]
    if (zzv > 0) {
      ll <- c(ll, llf[l])
      cc <- c(cc, ccf[c])
      vv <- c(vv, zzv)
    }
  }
}
#
lli <- data.frame(ll, cc, vv)
nni <-
  data.frame(name = c(as.character(lli$ll), as.character(lli$cc)) %>% unique())
lli$idll <- match(lli$ll, nni$name) - 1
lli$idcc <- match(lli$cc, nni$name) - 1
#
pp <- sankeyNetwork(
  Links = lli,
  Nodes = nni,
  Source = "idll",
  Target = "idcc",
  Value = "vv",
  NodeID = "name",
  sinksRight = FALSE,
  fontSize = 20
)
pp <-
  htmlwidgets::prependContent(pp, htmltools::tags$h1("Suivi"))
pp <-
  htmlwidgets::appendContent(pp, htmltools::tags$p("intervention lors ddes trois consultations"))
pp
