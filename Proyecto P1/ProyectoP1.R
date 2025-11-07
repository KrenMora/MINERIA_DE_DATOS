# Librerías necesarias
install.packages("readxl")
install.packages("dplyr")
install.packages("arules")
install.packages("fim4r")

library(readxl)
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


# Corrida 2 

# Seleccionar variables relevantes
data_apriori2 <- datos_unidos[, c("Depocu","Sexo","Edadif","Ecidif",
                                 "Escodif","Ciuodif","Caudef","Asist","Ocur")]

data_apriori2$Edadif <- cut(data_apriori2$Edadif,
                           breaks = c(0, 18, 30, 50, 70, 120),
                           labels = c("0-18", "19-30", "31-50", "51-70", "71+"))

data_guate <- subset(data_apriori2, Depocu == "Guatemala")
data_quiche <- subset(data_apriori2, Depocu == "Quiché")

# Generar reglas con soporte y confianza ajustados
reglas_guate <- apriori(data_guate, parameter = list(supp = 0.002, conf = 0.8))
reglas_quiche <- apriori(data_quiche, parameter = list(supp = 0.002, conf = 0.8))


# Aplicar FP-Growth con parámetros similares
reglas_fp2 <- fim4r(data_apriori2, method = "fpgrowth",
                   target = "rules", supp = 0.003, conf = 0.75)

rf <- as(reglas_fp2, "data.frame")

# Ver las primeras reglas
inspect(head(sort(reglas, by = "lift"), 10))
head(subset(rf, lift > 1.2), 10)


# ============================================================
dataF2023 <- read_excel("C:/Users/krenm/Desktop/MST/Cuarto T/Mineria/Proyecto P1/Dataset/bddefuncionesfetales2023.xlsx")
dataF2022 <- read_excel("C:/Users/krenm/Desktop/MST/Cuarto T/Mineria/Proyecto P1/Dataset/defunciones-fetales-2022.xlsx")

# Unir ambos años
datos_fetales <- bind_rows(dataF2023, dataF2022)

data_aprioriF <- datos_fetales[, c("DEPREG", "MUPREG", "MESREG", "DEPOCU", "MUPOCU",
                                  "SEXO", "EDADM", "ESCIVM", "ESCOLAM",
                                  "SEMGES", "ASISREC", "SITIOOCU", "TOHITE", "TOHINM")]

reglas_aprioriF <- apriori(data_aprioriF,
                          parameter = list(supp = 0.003, conf = 0.75, minlen = 2))

inspect(head(sort(reglas_aprioriF, by = "lift"), 10))

# Guardar en un dataframe
df_aprioriF <- as(reglas_aprioriF, "data.frame")

# Ejecutar FP-Growth 
reglas_fpF <- fim4r(data_aprioriF, method = "fpgrowth", target = "rules", 
                   supp = 0.003, conf = 0.75)

dffp <- as(reglas_fpF, "data.frame")

head(subset(dffp), 10)



