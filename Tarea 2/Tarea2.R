# ==== 1) Paquetes ====
# install.packages("arules", type = "binary")
# install.packages("readxl")
library(arules)
library(readxl)


ruta <- "C:\\Users\\krenm\\Downloads\\graduados-superior-2023.xlsx"
datos <- read_excel(ruta)

usar_cols <- c("CARRERA","Departamento","Sexo","Edad","Grupos_Quinquenales",
               "Sector","Pueblo_Pertenencia")
datos <- datos[, usar_cols]
datos[] <- lapply(datos, function(x) factor(as.character(x)))
datos <- datos[, -1]
datos_Guatemala <- subset(datos, Departamento == "Guatemala")
reglas <- apriori(datos_Guatemala, parameter = list(support = 0.2, confidence = 0.5))
inspect(reglas[1:min(36, length(reglas))])

# Prueba 2
reglas2 <- apriori(datos_Guatemala, parameter = list(support = 0.05, confidence = 0.6))
inspect(reglas2[1:min(50, length(reglas2))])



