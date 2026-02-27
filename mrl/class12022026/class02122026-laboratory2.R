library(openxlsx)
library(ggplot2)
library(here)

sales <- read.xlsx(here("mrl/class12022026/sales_data.xlsx"), sheet = 1)

# dispersion plot
ggplot(sales, aes(x = Ventas, y = Renta)) +
    geom_point() +
    theme_linedraw()

# build model
mod_sales <- lm(Renta ~ Ventas, data = sales)
summary(mod_sales)

print('Intercepto')
mod_sales$coefficients[1]  # intercept

print('Pendiente')
mod_sales$coefficients[2]  # slope

print('Coeficiente de correlación')
# sigma(mod_sales)
summary(mod_sales)$sigma

print('R cuadrado')
summary(mod_sales)$r.squared

# dibuje los datos predictivos
ggplot(sales, aes(x = Ventas, y = Renta)) +
  geom_smooth(method = "lm", formula = y ~ x, se = FALSE, col = '#ffc600') +
  geom_point() +
  theme_linedraw()

sales$Predicted <- predict(mod_sales)

ggplot(sales, aes(x = Ventas, y = Renta)) +
  geom_point(aes(y = Predicted), col = 'red') +
  geom_smooth(method = "lm", formula = y ~ x, se = FALSE, col = 'blue') +
  geom_point() +
  theme_linedraw()