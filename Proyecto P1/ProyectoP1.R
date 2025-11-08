# ============================================================
# LIBRERIAS NECESARIAS
# ============================================================
install.packages("readxl")
install.packages("dplyr")
install.packages("arules")
install.packages("fim4r")

library(readxl)
library(dplyr)
library(arules)
library(fim4r)

# ============================================================
#  DATASET DEFUNCION 2022-2023
# ============================================================

# 1. Leer los datos
data2023 <- read_excel("C:/Users/krenm/Desktop/MST/Cuarto T/Mineria/Proyecto P1/Dataset/defunciones2023da.xlsx")
data2022 <- read_excel("C:/Users/krenm/Desktop/MST/Cuarto T/Mineria/Proyecto P1/Dataset/defunciones-2022.xlsx")

# 2. Unir datasets
datos_unidos <- bind_rows(data2023, data2022)

# ============================================================
#  APLICACION DE REGLAS APRIORI Y FP-GROWTH
#  supp = 0.01, conf = 0.7
# ============================================================

# 3. Seleccionar variables relevantes
data_apriori <- datos_unidos[, c("Depocu","Mupocu","Sexo","Diaocu","Mesocu","Añoocu","Edadif","Perdif","Puedif","Ecidif","Escodif","Ciuodif","Nacdif","Caudef","Asist","Ocur")]

# 4. Generar reglas Apriori 
reglas <- apriori(data_apriori, parameter = list(supp = 0.01, conf = 0.7))

# 5. Aplicar FP-Growth
reglas_fp <- fim4r(data_apriori, method = "fpgrowth", target = "rules", supp = 0.01, conf = 0.7)
rf <- as(reglas_fp, "data.frame")

# 6. Ver las primeras reglas
inspect(head(sort(reglas, by = "lift"), 10))
head(rf, 10)

# ============================================================
#  APLICACION DE REGLAS APRIORI Y FP-GROWTH
#  supp = 0.002, conf = 0.8
# ============================================================

# ============================================================
#  APLICACION DE REGLAS APRIORI 
# ============================================================

# 3. Variables con significado demográfico y médico
data_apriori2 <- datos_unidos[, c("Sexo", "Edadif", "Ecidif", "Escodif", "Caudef")]

# 4. La edad se convierte en rango
data_apriori2$Edadif <- cut(data_apriori2$Edadif,
                         breaks = c(0, 12, 18, 30, 45, 60, 75, 100),
                         labels = c("Niñez", "Adolescente", "Joven adulto", "Adulto", "Mediana edad", "Adulto mayor", "Anciano"),
                         include.lowest = TRUE)

# 5. Convertir todas las columnas a factores
data_apriori2[] <- lapply(data_apriori2, as.factor)

# 6. Algoritmo apriori
reglas_apriori <- apriori(data_apriori2,
                          parameter = list(supp = 0.002, conf = 0.75, minlen = 2))

# ============================================================
#  APLICACION DE REGLAS FP-GROWTH
# ============================================================

# 3.. Aplicar FP-Growth 
data_FP <- datos_unidos[, c("Sexo", "Edadif", "Asist", "Puedif", "Caudef")]

# 4. La edad se convierte en rango
data_FP$Edadif <- cut(data_FP$Edadif,
                            breaks = c(0, 12, 18, 30, 45, 60, 75, 100),
                            labels = c("Niñez", "Adolescente", "Joven adulto", "Adulto", "Mediana edad", "Adulto mayor", "Anciano"),
                            include.lowest = TRUE)

# 5. Convertir todas las columnas a factores
data_FP[] <- lapply(data_FP, as.factor)

# 6. Algoritmo fp/growth
reglas_fp2 <- fim4r(data_FP, method = "fpgrowth",
                   target = "rules", supp = 0.002, conf = 0.75)
rff <- as(reglas_fp2, "data.frame")


# ============================================================
#  Visualizar resultados
# ============================================================

inspect(head(sort(reglas_apriori), 25))
inspect(head(sort(reglas_apriori, by = "lift"), 25))
head(subset(rff,by = "lift" > 1.2), 50)


# ============================================================
# =====================================================
#  DATASET DEFUNCION FETAL 2022-2023
# =====================================================
# ============================================================

# 1. Leer los datos
dataF2023 <- read_excel("C:/Users/krenm/Desktop/MST/Cuarto T/Mineria/Proyecto P1/Dataset/bddefuncionesfetales2023.xlsx")
dataF2022 <- read_excel("C:/Users/krenm/Desktop/MST/Cuarto T/Mineria/Proyecto P1/Dataset/defunciones-fetales-2022.xlsx")

# 2. Unir ambos años
datos_fetales <- bind_rows(dataF2023, dataF2022)

# ============================================================
#  APLICACION DE REGLAS APRIORI Y FP-GROWTH
#  supp = 0.003, conf = 0.75, minlen = 2
# ============================================================


# ============================================================
#  APLICACION DE REGLAS APRIORI
# ============================================================

# 3. Seleccionar variables relevantes
data_aprioriF <- datos_fetales[, c("EDADM", "SEMGES", "SEXO", "VIAPAR", "CLAPAR", "TIPAR", "CAUDEF", "TOHINM")]


# Edad de la madre
data_aprioriF$EDADM <- cut(data_aprioriF$EDADM,
                        breaks = c(10, 19, 25, 30, 35, 40, 45, 60),
                        labels = c("Adolescente", "Joven", "Adulto joven", "Adulto", "Maduro", "Mayor", "Avanzado"),
                        include.lowest = TRUE)

# Semana de gestación
data_aprioriF$SEMGES <- cut(data_aprioriF$SEMGES,
                         breaks = c(0, 12, 20, 28, 37, 42),
                         labels = c("1er trimestre", "2do trimestre", "3er trimestre inicial", "3er trimestre avanzado", "Post-término"),
                         include.lowest = TRUE)

# Cantidad de hijos nacidos muertos
data_aprioriF$TOHINM <- cut(data_aprioriF$TOHINM,
                         breaks = c(0, 1, 3, 5, 10, 20),
                         labels = c("Ninguno", "1-3", "4-5", "6-10", "Más de 10"),
                         include.lowest = TRUE)

data_aprioriF[] <- lapply(data_aprioriF, as.factor)

# 4. Generar reglas Apriori 
reglas_aprioriF <- apriori(data_aprioriF,
                          parameter = list(supp = 0.003, conf = 0.75, minlen = 2))


# ============================================================
#  APLICACION DE REGLAS FP-GROWTH
# ============================================================

# 3. Seleccionar variables relevantes
data_FPF <- datos_fetales[, c("EDADM", "SEMGES", "VIAPAR", "CAUDEF", "TOHINM")]


# Edad de la madre
data_FPF$EDADM <- cut(data_FPF$EDADM,
                           breaks = c(10, 19, 25, 30, 35, 40, 45, 60),
                           labels = c("Adolescente", "Joven", "Adulto joven", "Adulto", "Maduro", "Mayor", "Avanzado"),
                           include.lowest = TRUE)

# Semana de gestación
data_FPF$SEMGES <- cut(data_FPF$SEMGES,
                            breaks = c(0, 12, 20, 28, 37, 42),
                            labels = c("1er trimestre", "2do trimestre", "3er trimestre inicial", "3er trimestre avanzado", "Post-término"),
                            include.lowest = TRUE)

# Cantidad de hijos nacidos muertos
data_FPF$TOHINM <- cut(data_FPF$TOHINM,
                            breaks = c(0, 1, 3, 5, 10, 20),
                            labels = c("Ninguno", "1-3", "4-5", "6-10", "Más de 10"),
                            include.lowest = TRUE)


# 5. Aplicar FP-Growth
reglas_fpF <- fim4r(data_FPF, method = "fpgrowth", target = "rules", 
                    supp = 0.003, conf = 0.75)

dffp <- as(reglas_fpF, "data.frame")

# ============================================================
#  Visualizar resultados
# ============================================================

inspect(head(sort(reglas_aprioriF), 75))
inspect(head(sort(reglas_aprioriF, by = "lift"), 25))
head(dffp, 50)
