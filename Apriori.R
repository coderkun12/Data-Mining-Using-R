rm(list=ls())
cat('\014')
data("Groceries")
#data=read.csv(file.choose())
install.packages('arules')
install.packages('arulesViz')
library(arules)
library(arulesViz)
library(RColorBrewer)

# With support 1% and confidence 30%
rules<-apriori(Groceries,parameter = list(supp=0.01,conf=0.3))
inspect(rules[1:10])

arules::itemFrequencyPlot(Groceries, topN = 20, 
                          col = brewer.pal(8, 'Pastel2'),
                          main = 'Relative Item Frequency Plot',
                          type = "relative",
                          ylab = "Item Frequency (Relative)")

# With support 2% and confidence 40%
rules2<-apriori(Groceries,parameter = list(supp=0.02,conf=0.4))
inspect(rules2[1:10])

# With support 3% and confidence 50%
rules3<-apriori(Groceries,parameter = list(supp=0.03,conf=0.5))
inspect(rules3[1:10])
