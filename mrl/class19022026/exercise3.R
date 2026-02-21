library(openxlsx)
# data <- read.xlsx('weight_height.xlsx')
data <- read.xlsx('mrl/class19022026/weight_height.xlsx')

# a) Dibuje los puntos
# variable independiente: height_inches
# variable dependiente: weight_pounds

plot(
    data$height_inches,
    data$weight_pounds,
    main = "Peso vs Altura",
    xlab = "Altura (pulgadas)",
    ylab = "Peso (libras)",
    pch = 19,
    col = "blue"
)

# b) Aplique regresión simple, para construir un modelo exponencial
data$log_weight <- log(data$weight_pounds)
exponencial_model <- lm(log_weight ~ height_inches, data = data)

data$predicted_log_weight <- predict(exponencial_model)

# c) Determine los coeficientes del modelo
## Intercepto
cat('Intercepto:', exponencial_model$coefficients[[1]], '\n')

## Pendiente
cat('Pendiente:', exponencial_model$coefficients[[2]], '\n')

# d) Construya la fórmula del modelo exponencial
formula_exponential <- function(x) {
    exp(exponencial_model$coefficients[[1]] + exponencial_model$coefficients[[2]] * x)
}

# e) Dibuje los puntos y la gráfica del modelo exponencial
plot(
    data$height_inches,
    data$weight_pounds,
    main = "Peso vs Altura",
    xlab = "Altura (pulgadas)",
    ylab = "Peso (libras)",
    pch = 19,
    col = "blue"
)
par(new = T)
plot(
  data$height_inches,
  formula_exponential(data$height_inches),
  col = "red",
  type = "l",
  lwd = 2
)
#
# f) Dibuje los residuos y analice la dispersión

# g) Construya un modelo potencial y repita los incisos del a) al f)
data$log_height <- log(data$height_inches)
potencial_model <- lm(log_weight ~ log_height, data = data)
data$predicted_log_weight_potencial <- predict(potencial_model)

## Intercepto potencial
cat('Intercepto:', potencial_model$coefficients[[1]], '\n')

## Pendiente potencial
cat('Pendiente:', potencial_model$coefficients[[2]], '\n')

## Fórmula potencial
formula_potencial <- function(x) {
    exp(potencial_model$coefficients[[1]] + potencial_model$coefficients[[2]] * log(x))
}

## Gráfica potencial
plot(
    data$height_inches,
    data$weight_pounds,
    # main = "Peso vs Altura",
    xlab = "Altura (pulgadas)",
    ylab = "Peso (libras)",
    pch = 19,
    col = "red"
)
par(new = T)
plot(
    data$log_height,
    formula_potencial(data$height_inches),
    col = "blue",
    type = 'l',
    lwd = 1
)
