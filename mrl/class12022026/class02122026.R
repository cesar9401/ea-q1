# intall packages only first time
# install.packages("openxlsx")
# install.packages('ggplot2')

library(openxlsx)
library(ggplot2)

data <- read.xlsx("mrl/class12022026/Estatura.xlsx", sheet = 1)
ggplot(data, aes(x = Edad, y = Estatura)) +
geom_point() +
theme_light() +
geom_segment(aes(xend = 7, yend = 1.4), color = "#ffc600", lty='dashed')
