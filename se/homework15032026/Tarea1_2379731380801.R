# Nombre: César Reginaldo Tzoc Alvardo
# DPI: 2379731380801

# Ejercicio 1:
# - Instala y carga la libreria randonNames

# install.packages('randomNames')
library(randomNames)

# - Establece la semilla con set.seed(semilla) como primera línea de tu código.
dpi_numbers <- as.numeric(strsplit("2379731380801", "")[[1]])
dpi_sum <- sum(dpi_numbers)
set.seed(dpi_sum)

# Ejercicio 2:
# - Crea un vector de nombres para 20 hombres y 20 mujeres, almacenándolo en la variable Nombres.
# - Usa la función randomNames() con los siguientes valores: Para hombres: n = 20, ethnicity = 4, gender = 1. Para mujeres: n = 20, ethnicity = 4, gender = 0.
# - Concatena ambos vectores y almacénalos en Nombres.

nombres_hombres <- randomNames(n = 20, ethnicity = 4, gender = 0)
nombres_mujeres <- randomNames(n = 20, ethnicity = 4, gender = 1)
Nombres <- c(nombres_hombres, nombres_mujeres)

# Ejercicio 3:
# - Crea un vector numérico Peso con el peso en libras de las 40 personas generadas.
# - Usa la función runif() para generar valores aleatorios con distribución uniforme y redondea al entero más cercano con round().
# - Usa los argumentos: n = 40, min = 100, max = 220.

Peso <- round(runif(n = 40, min = 100, max = 220))

# Ejercicio 4:
# - Crea una variable de tipo factor llamada Genero, que almacene el género de las personas generadas.
# - Asigna "Hombre" o "Mujer" según corresponda (puedes usar rep()).

Genero <- factor(c(rep("Hombre", 20), rep("Mujer", 20)))

# Ejercicio 5:
# - Crea la variable Edad, generando valores aleatorios con distribución normal mediante rnorm().
# - Redondea los valores al entero más cercano con round().
# - Usa los argumentos: mean = suma de los dígitos de tu DPI, sd = 4.

Edad <- round(rnorm(n = 40, mean = dpi_sum, sd = 4))

# Ejercicio 6:
# - Crea la variable Estatura, siguiendo el mismo procedimiento que en el ejercicio anterior.
# - Modifica los parámetros a mean = 1.70, sd = 0.1 y redondea a la centésima más cercana.

Estatura <- round(rnorm(n = 40, mean = 1.70, sd = 0.1), 2)

# Ejercicio 7:
# - Crea una variable de tipo factor llamada Estado_civil.
# - Usa rbinom() para generar valores aleatorios con los argumentos n = 40, size = 1, prob = 0.5.
# - Convierte los valores a factor con labels = c("Soltero", "Casado").

Estado_civil <- factor(rbinom(n = 40, size = 1, prob = 0.5), labels = c("Soltero", "Casado"))

# Ejercicio 8:
# - Crea una variable de tipo factor llamada Nivel_Escolaridad.
# - Usa rbinom() con los argumentos n = 40, size = 4, prob = 0.5.
#- Convierte los valores a factor con labels = c("Sin escolaridad", "Primaria", "Básico", "Diversificado", "Universitario") y ordered = TRUE.
# rbinom(n = 40, size = 3, prob = 0.5)
# rbinom(n = 40, size = 4, prob = 0.5)
# rbinom(n = 40, size = 5, prob = 0.5)

Nivel_Escolaridad <- factor(
  rbinom(n = 40, size = 4, prob = 0.5),
  levels = 0:4,
  labels = c("Sin escolaridad", "Primaria", "Básico", "Diversificado", "Universitario"),
  ordered = TRUE
)

# Ejercicio 9:
# - Crea un data.frame con todas las variables anteriores utiliza el mismo orden en el que creaste las variables y almacénalo en Muestra.
Muestra <- data.frame(Nombres, Peso, Genero, Edad, Estatura, Estado_civil, Nivel_Escolaridad)

# Ejercicio 10:
# - Agrega una nueva variable lógica llamada Mayor_Cuarenta a Muestra.
# - La variable debe ser TRUE si la edad es mayor de 40 años y FALSE en caso contrario. Usa ifelse().

Muestra$Mayor_Cuarenta <- ifelse(Muestra$Edad > 40, TRUE, FALSE)

# Ejercicio 11:
# - Agrega una nueva variable numérica llamada Ingreso_salarial.
# - Genera valores aleatorios con distribución normal usando rnorm(), con mean = 5000 y sd = 500.

Muestra$Ingreso_salarial <- rnorm(n = 40, mean = 5000, sd = 500)

# Parte 2: Cálculo de estadísticas descriptivas

# Ejercicio 12:
# - Filtra los datos para obtener un data.frame con hombres casados mayores de 30 años y almacénalo en S1.
# - Calcula la media y la desviación estándar de la variable Ingreso_salarial y almacena los valores en m1 y sd1, respectivamente.

S1 <- subset(Muestra, Genero == "Hombre" & Estado_civil == "Casado" & Edad > 30)
m1 <- mean(S1$Ingreso_salarial)
sd1 <- sd(S1$Ingreso_salarial)

# Ejercicio 13
# - Filtra los datos para obtener un data.frame con mujeres solteras mayores de 40 años y almacénalo en S2.
# - Calcula la media y la desviación estándar de Ingreso_salarial y almacena los valores en m2 y sd2.

S2 <- subset(Muestra, Genero == "Mujer" & Estado_civil == "Soltero" & Edad > 40)
m2 <- mean(S2$Ingreso_salarial)
sd2 <- sd(S2$Ingreso_salarial)

# Ejercicio 14
# - Filtra los datos para obtener un data.frame con personas con nivel de escolaridad inferior a "Universitario" y almacénalo en S3.
# - Calcula la media y la desviación estándar de Ingreso_salarial y almacena los valores en m3 y sd3.

S3 <- subset(Muestra, Nivel_Escolaridad < "Universitario")
m3 <- mean(S3$Ingreso_salarial)
sd3 <- sd(S3$Ingreso_salarial)

# Ejercicio 15
# - Filtra los datos para obtener un data.frame con personas cuya estatura sea mayor a 1.70 m y cuyo peso sea menor a 169 lb, y almacénalo en S4.
# - Calcula la media y la desviación estándar de la variable Edad y almacena los valores en m4 y sd4.

S4 <- subset(Muestra, Estatura > 1.70 & Peso < 169)
m4 <- mean(S4$Edad)
sd4 <- sd(S4$Edad)

# Ejercicio 16
# Crea una lista con las variables siguientes: Muestra,m1,sd1,m2,sd2,m3,sd3,m4,sd4
# Almacena la lista en la variable SALIDA
# Para hacer tu lista SALIDA coloca nombres a los elementos ejemplo: SALIDA=list(Muestra=Muestra,m1=m1,….)

SALIDA <- list(
  Muestra = Muestra,
  m1 = m1,
  sd1 = sd1,
  m2 = m2,
  sd2 = sd2,
  m3 = m3,
  sd3 = sd3,
  m4 = m4,
  sd4 = sd4
)
