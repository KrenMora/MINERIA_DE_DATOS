# Librerías necesarias
library(readxl)
install.packages("dplyr")
library(dplyr)
library(arules)
library(fim4r)

# Leer los datos
data2023 <- read_excel("C:/Users/krenm/Desktop/MST/Cuarto T/Mineria/Proyecto P1/Dataset/defunciones2023da.xlsx")
data2022 <- read_excel("C:/Users/krenm/Desktop/MST/Cuarto T/Mineria/Proyecto P1/Dataset/defunciones-2022.xlsx")

# Unir datasets
datos_unidos <- bind_rows(data2023, data2022)

# Seleccionar variables relevantes
data_apriori <- datos_unidos[, c("Depocu","Mupocu","Sexo","Diaocu","Mesocu","Añoocu","Edadif","Perdif","Puedif","Ecidif","Escodif","Ciuodif","Nacdif","Caudef","Asist","Ocur")]

# Generar reglas con soporte y confianza ajustados
reglas <- apriori(data_apriori, parameter = list(supp = 0.01, conf = 0.7))
# Aplicar FP-Growth con parámetros similares
reglas_fp <- fim4r(data_apriori, method = "fpgrowth", target = "rules", supp = 0.01, conf = 0.7)
rf <- as(reglas_fp, "data.frame")

# Ver las primeras reglas
inspect(head(sort(reglas, by = "lift"), 10))
head(rf, 10)
