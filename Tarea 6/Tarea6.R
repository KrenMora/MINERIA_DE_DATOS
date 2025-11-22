# ============================================================
#      RANDOM FOREST – VIOLENCIA INTRAFAMILIAR 2024
#      Variable a predecir: AGR_OCUP (ocupación del agresor)
# ============================================================

install.packages("readxl")
install.packages("randomForest")

library(dplyr)
library(readxl)
library(randomForest)

# -----------------------------
# 1. Cargar y preparar los datos
# -----------------------------
data <- read_excel("C:/Users/krenm/Downloads/base-de-datos-violencia-intrafamiliar-ano-2024_v3.xlsx")

# ===========================================
# 3. Seleccionar variables relevantes
# ===========================================
data <- data[, c(
  "AGR_OCUP",
  "AGR_EDAD",
  "VIC_EDAD",
  "VIC_SEXO",
  "AGR_SEXO",
  "HEC_MES",
  "VIC_ESCOLARIDAD",
  "VIC_TRABAJA",
  "AGR_ESCOLARIDAD"
)]

# ===========================================
# 4. Quitar NA para entrenar con datos limpios
# ===========================================
data$VIC_ESCOLARIDAD[is.na(data$VIC_ESCOLARIDAD)] <- 99
data$AGR_ESCOLARIDAD[is.na(data$AGR_ESCOLARIDAD)] <- 99
data$VIC_TRABAJA[is.na(data$VIC_TRABAJA)] <- 9
data$AGR_OCUP[is.na(data$AGR_OCUP)] <- 9999
data$AGR_EDAD[is.na(data$AGR_EDAD)] <- median(data$AGR_EDAD, na.rm = TRUE)
data$VIC_EDAD[is.na(data$VIC_EDAD)] <- median(data$VIC_EDAD, na.rm = TRUE)

# ===========================================
# 5. AGRUPACIÓN DE OCUPACIONES (Opción B)
# ===========================================
# Grupo basado en rangos ocupacionales
data <- data %>%
  mutate(AGR_OCUP2 = case_when(
    AGR_OCUP >= 6000 & AGR_OCUP <= 6999 ~ "Agricultura",
    AGR_OCUP >= 5000 & AGR_OCUP <= 5999 ~ "Servicios",
    AGR_OCUP >= 7000 & AGR_OCUP <= 7999 ~ "Construcción",
    AGR_OCUP >= 8000 & AGR_OCUP <= 8999 ~ "Comercio",
    AGR_OCUP >= 9000 & AGR_OCUP <= 9999 ~ "No calificado",
    TRUE ~ "Otro"
  ))

data$AGR_OCUP2 <- as.factor(data$AGR_OCUP2)

# ===========================================
# 6. Barajar datos
# ===========================================
set.seed(100)
data <- data[sample(1:nrow(data)), ]

# ===========================================
# 7. Train / Test Split
# ===========================================
index <- sample(1:nrow(data), 0.8 * nrow(data))
train <- data[index, ]
test  <- data[-index, ]

# ===========================================
# 8. Entrenar el Bosque Aleatorio
# ===========================================
bosque <- randomForest(
  AGR_OCUP2 ~ AGR_EDAD + VIC_EDAD + VIC_SEXO + AGR_SEXO +
    HEC_MES + VIC_ESCOLARIDAD + VIC_TRABAJA + AGR_ESCOLARIDAD,
  data = train,
  ntree = 400,
  mtry = 3
)

bosque  # para ver resumen

# ===========================================
# 9. Predicciones
# ===========================================
pred <- predict(bosque, test)

# ===========================================
# 10. Matriz de confusión
# ===========================================
matriz <- table(test$AGR_OCUP2, pred)
matriz

# ===========================================
# 11. Precisión del modelo
# ===========================================
precision <- sum(diag(matriz)) / sum(matriz)
precision

# ===========================================
# 12. Gráfico de error del modelo
# ===========================================
plot(bosque, main = "Error del modelo vs Árboles (Random Forest)")

# ===========================================
# 13. Predicción con un caso nuevo
# ===========================================
nuevo_caso <- data.frame(
  AGR_EDAD = 35,
  VIC_EDAD = 28,
  VIC_SEXO = 2,
  AGR_SEXO = 1,
  HEC_MES = 5,
  VIC_ESCOLARIDAD = 42,
  VIC_TRABAJA = 1,
  AGR_ESCOLARIDAD = 30
)

predict(bosque, nuevo_caso)
