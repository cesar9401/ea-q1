# multiplicative potential model
library(openxlsx)
vehicles <- read.xlsx("mrl/class19022026/distancia_frenado.xlsx", sheet = 1)

vehicles$log_distance <- log(vehicles$distancia)
vehicles$log_velocity <- log(vehicles$velocidad)

model <- lm(log_distance ~ log_velocity, data = vehicles)
model
summary(model)

vehicles$predicted_log_distance <- predict(model)

formula <- function(x) {
    exp(model$coefficients[[1]] + model$coefficients[[2]] * log(x))
}

plot(
    vehicles$velocidad,
    vehicles$distancia,
    xlim = c(4, 25),
    ylim = c(0, 120),
    main = "Distancia de Frenado vs Velocidad",
    xlab = "Velocidad (km/h)",
    ylab = "Distancia de Frenado (m)",
    pch = 19,
    col = "red"
)
par(new = T)
plot(
    vehicles$log_velocity,
    formula(vehicles$velocidad),
    col = "green",
    type = "l",
    lwd = 2
)
