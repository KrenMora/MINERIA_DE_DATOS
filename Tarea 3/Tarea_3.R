install.packages("rCBA")

# Establece la ruta de tu JDK (ajusta la versión)
Sys.setenv(JAVA_HOME = "C:/Program Files/Java/jdk-17")

# Reinstala rJava para vincular con ese JDK
install.packages("rJava", type = "binary")

# Ahora carga rCBA
library(rCBA)



library(readxl)

data <- read_excel("C:\\Users\\krenm\\Downloads\\base-de-datos-violencia-intrafamiliar-ano-2024_v3.xlsx")

data_fp <- data[, c("HEC_MES", "HEC_DEPTO", "VIC_EDAD", "VIC_ESCOLARIDAD", "VIC_EST_CIV", "VIC_GRUPET", "VIC_TRABAJA", "VIC_DEDICA", "AGR_EDAD", "AGR_ESCOLARIDAD")]

reglas_fp <- fim4r(data_fp, method="fpgrowth", target ="rules", supp =.2, conf=.5)

rf <- as(reglas_fp, "data.frame")

data_agresor_trabaja <- subset(data, AGR_TRABAJA == 1)

data_hijos <- subset(data, TOTAL_HIJOS > 0)

data_rural <- subset(data, HEC_AREA == 2)


data_agresor_fp <- data_agresor_trabaja[, c("VIC_EDAD", "VIC_ESCOLARIDAD", "VIC_EST_CIV", "AGR_EDAD", "AGR_ESCOLARIDAD", "AGR_EST_CIV")]
reglas_agresor <- fim4r(data_agresor_fp, method="fpgrowth", target="rules", supp=0.2, conf=0.5)
rf_agresor <- as(reglas_agresor, "data.frame")

head(rf_agresor, 26)

data_hijos_fp <- data_hijos[, c("VIC_SEXO", "VIC_EDAD", "VIC_ESCOLARIDAD", "VIC_EST_CIV", "VIC_TRABAJA", "AGR_SEXO", "AGR_EDAD")]
reglas_hijos <- fim4r(data_hijos_fp, method="fpgrowth", target="rules", supp=0.2, conf=0.5)
rf_hijos <- as(reglas_hijos, "data.frame")

head(rf_hijos, 26)

data_rural_fp <- data_rural[, c("VIC_EDAD", "VIC_ESCOLARIDAD", "VIC_EST_CIV", "AGR_EDAD", "AGR_TRABAJA")]
reglas_rural <- fim4r(data_rural_fp, method="fpgrowth", target="rules", supp=0.2, conf=0.5)
rf_rural <- as(reglas_rural, "data.frame")

head(rf_rural, 17)


