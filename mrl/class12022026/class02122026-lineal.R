library(openxlsx)
library(ggplot2)
library(here)

data <- read.xlsx(here("mrl/class12022026/minimos_cuadrados_data.xlsx"), sheet = 1)
# ggplot(data, aes(x = Edad, y = Resistencia)) +
#   geom_point() +
#   theme_linedraw()

# build model
mod1 <- lm(Resistencia ~ Edad, data = data)

# graph with model
ggplot(data, aes(x = Edad, y = Resistencia)) +
  geom_smooth(method = "lm", formula = y ~ x, se = FALSE, col = '#ffc600') +
  geom_point() +
  theme_linedraw()

# mod1$fitted.values
predict(mod1, newdata = data.frame(Edad = 15.5))
data$Predicted <- predict(mod1)
data

ggplot(data, aes(x = Edad, y = Resistencia)) +
  geom_point(aes(y = Predicted), col = 'red') +
  geom_smooth(method = "lm", formula = y ~ x, se = FALSE, col = 'blue') +
  geom_point() +
  theme_linedraw()

# show differences between real and predicted
abs(data$Resistencia - data$Predicted)
