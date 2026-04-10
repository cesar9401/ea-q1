
datos <- airquality

#modelo 1
mod1 <- lm(Ozone ~ Solar.R, data = datos)
summary(mod1)

# El p-value de Solar.R = 0.000179 < 0.05, por lo tanto se rechaza la hipotesis nula.
# Esto significa que la radiacion solar influye significativamente
# en la concentracion de ozono.

#modelo 2
mod2 <- lm(Ozone ~ Wind, data = datos)
summary(mod2)

# El p-value de Wind = 9.272e-13 < 0.05, por lo tanto se rechaza la hipotesis nula.
# Esto indica que la velocidad del viento afecta significativamente
# la concentracion de ozono.

#modelo 3
mod3 <- lm(Ozone ~ Temp, data = datos)
summary(mod3)

# El p-value de Temp < 2.2e-16 < 0.05, por lo tanto se rechaza la hipotesis nula.
# Esto significa que la temperatura influye significativamente
# en la concentracion de ozono.

#modelo multiple
mod4 <- lm(Ozone ~ Solar.R + Wind + Temp, data = datos)
summary(mod4)

anova(mod4)

# En el modelo multiple (Solar.R + Wind + Temp) el p-value del modelo
# es < 2.2e-16 < 0.05, por lo que se rechaza la hipotesis nula.

# Esto indica que al menos una de las variables (radiacion solar,
# velocidad del viento o temperatura) explica significativamente
# la concentracion de ozono.
