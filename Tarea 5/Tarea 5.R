# Librerías
library(readxl)
library(dplyr)
library(rpart)
library(rpart.plot)

# Cargar data
data <- read_excel("C:/Users/krenm/Downloads/base-de-datos-violencia-intrafamiliar-ano-2024_v3.xlsx")


data_model <- data %>%
  select(AGR_SEXO, VIC_EDAD, VIC_ESCOLARIDAD, VIC_TRABAJA)

# Eliminar NA
data_model <- na.omit(data_model)



data$EDAD30 <- ifelse(data$VIC_EDAD >= 30, ">=30", "<30")


data$ESC_OK <- ifelse(data$VIC_ESCOLARIDAD != 99, "Valida", "99")


arbol5 <- rpart(AGR_SEXO ~
                  EDAD30 + 
                  VIC_TRABAJA +
                  ESC_OK ,
                data = data, method = "class"
)


rpart.plot(
  arbol5,
  type = 2,
  extra = 0,
  under = TRUE,
  fallen.leaves = TRUE,
  box.palette = "BuGn",
  main = "Ciudad o no",
  cex = 0.7
)
