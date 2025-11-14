# Librerías
library(readxl)
library(dplyr)
library(rpart)
library(rpart.plot)

# Cargar data
data <- read_excel("C:/Users/krenm/Downloads/base-de-datos-violencia-intrafamiliar-ano-2024_v3.xlsx")

data_model <- data %>% select(
  AGR_SEXO,        
  VIC_EDAD,
  VIC_SEXO,
  VIC_ESCOLARIDAD
)

# Eliminar NA
data_model <- na.omit(data_model)

data_model$AGR_SEXO <- as.factor(data_model$AGR_SEXO)

data_model$EDAD30 <- ifelse(data_model$VIC_EDAD >= 30, ">=30", "<30")
data_model$ESC_OK <- ifelse(data_model$VIC_ESCOLARIDAD != 99, "Valida", "Sin dato")

arbol_sexo <- rpart(
  AGR_SEXO ~ 
    EDAD30 + 
    VIC_SEXO + 
    ESC_OK,
  data = data_model,
  method = "class",
  cp = 0.01,
  minsplit = 60,
  maxdepth = 3
)

rpart.plot(
  arbol_sexo,
  type = 2,
  extra = 104,
  under = TRUE,
  fallen.leaves = TRUE,
  box.palette = "Blues",
  cex = 0.7,
  main = "Árbol de Decisión para Predecir el Sexo del Agresor"
)
