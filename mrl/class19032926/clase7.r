
mod1 = lm(Resistencia~Edad, data = datos)

mod1

summary(mod1)

new_dt <- data.frame(Edad=c(13, 2))
predict(object=mod1, newdata=new_dt, interval="confidence", level=0.95)
new_dt1 <- data.frame(Edad=c(13))
predict(object=mod1, newdata=new_dt1, interval="confidence", level=0.95)


new_dt2 <- data.frame(Edad=10)
predict(object=mod1, newdata=new_dt2, interval="prediction", level=0.90)

#datos futuros
future_y <- predict(object=mod1, interval="prediction", level=0.95)

nuevos_datos <- cbind(datos, future_y)

library(ggplot2)

ggplot(nuevos_datos, aes(x=Edad, y=Resistencia))+
  geom_point() +
  geom_line(aes(y=lwr), color="red", linetype="dashed") +
  geom_line(aes(y=upr), color="red", linetype="dashed") +
  geom_smooth(method=lm, formula=y~x, se=TRUE, level=0.95, col='blue', ﬁll='pink2') +
  theme_light()


#PARTE 2 DATOS DUMMy

Precio <- c(12, 15, 25, 11, 16, 7)
Area <- c(3, 4, 1, 6, 5, 3)
Pisci <- factor(x=c('Grande', 'Sin', 'Pequena', 'Pequena', 'Sin', 'Grande'),
                levels=c('Sin','Pequena','Grande'))


model.matrix(Precio ~ Area + Pisci)


library(MASS)
#MASS::

Cars93

str(Cars93[, c('Price', 'EngineSize','Type')])

levels(Cars93$Type)

#nivel de referencia mediante el carro peque;o

Cars93$Type <- relevel(Cars93$Type, ref = 'Small')

levels(Cars93$Type)

#modelo de regresion lineal
mod <- lm(Price~EngineSize+Type, data = Cars93)

mod

