library(readxl)
library(ggplot2)

data <- read_excel("C:\\Users\\krenm\\Downloads\\base-de-datos-violencia-intrafamiliar-ano-2024_v3.xlsx")

data_cluster <- data[, c("VIC_EDAD", "AGR_EDAD", "HEC_DEPTO", "HEC_MES")]

data_cluster[is.na(data_cluster)] <- -1  
data_cluster <- subset(data_cluster, VIC_EDAD != 99 & AGR_EDAD != 99)

cluster_edades <- kmeans(data_cluster[, c("VIC_EDAD", "AGR_EDAD")], centers = 3)

ggplot(data_cluster, aes(x = VIC_EDAD, y = AGR_EDAD, color = as.factor(cluster_edades$cluster))) +
  geom_point(size = 2, alpha = 0.7) +
  geom_point(data = as.data.frame(cluster_edades$centers), 
             aes(x = VIC_EDAD, y = AGR_EDAD), color = "black", size = 5, shape = 17) +
  scale_color_manual(values = c("red", "green", "blue")) +
  labs(title = "Agrupación por Edad de Víctima y Agresor", 
       x = "Edad de la Víctima", y = "Edad del Agresor") +
  theme_minimal() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"))
