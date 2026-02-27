# Exponencial model

library(openxlsx)
library(here)

vehicles <- read.xlsx(here("mrl/class19022026/distancia_frenado.xlsx"), sheet = 1)

# plot distance vs speed
plot(
  vehicles$velocidad,
  vehicles$distancia,
  main = "Distancia de Frenado vs Velocidad",
  xlab = "Velocidad (km/h)",
  ylab = "Distancia de Frenado (m)",
  pch = 19,
  col = "blue"
)

vehicles$log_distance <- log(vehicles$distancia)

model <-lm(log_distance ~ velocidad, data = vehicles)

# model$coefficients[[1]] # Intercept
# model$coefficients[[2]] # Slope
# summary(model)

vehicles$predicted_log_distance <- predict(model)
plot(
  vehicles$velocidad,
  vehicles$predicted_log_distance,
  main = "Predicted Log Distance vs Velocidad",
  xlab = "Velocidad (km/h)",
  ylab = "Predicted Log Distance",
  pch = 19,
  col = "red"
)

formula <- function(x) {
  exp(model$coefficients[[1]] + model$coefficients[[2]] * x)
  # exp(model$coefficients[[1]]) * exp(model$coefficients[[2]] * x)
}

# plot real data and model
plot(
  vehicles$velocidad,
  vehicles$distancia,
  xlim = c(4, 25),
  ylim = c(0, 120),
  main = "Distancia de Frenado vs Velocidad",
  xlab = "Velocidad (km/h)",
  ylab = "Distancia de Frenado (m)",
  pch = 19,
  col = "red",
)
par(new = T)
plot(
  vehicles$velocidad,
  formula(vehicles$velocidad),
  col = "blue",
  type = "l",
  lwd = 2
)
