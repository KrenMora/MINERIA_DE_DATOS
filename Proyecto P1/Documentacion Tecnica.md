# Proyecto de Minería de Datos: Análisis de Defunciones y Defunciones Fetales en Guatemala (2022–2023)

**Autor:** Karen Morales  
**Lenguaje:** R (versión 4.3.2)  
**Librerías principales:** `arules`, `fim4r`, `dplyr`, `readxl`, `ggplot2`  
**Objetivo:** Aplicar técnicas de minería de datos (Apriori, FP-Growth y K-Means) sobre los registros de defunciones generales y fetales de Guatemala, con el fin de identificar patrones relevantes en causas de muerte, edad, sexo, tipo de parto y otros factores.


## 1. Descripción general del proyecto

Este proyecto busca descubrir **patrones significativos en los registros de defunciones humanas y fetales** de los años 2022–2023, publicados por el Instituto Nacional de Estadística (INE) de Guatemala.

Los análisis realizados incluyen:

- **Reglas de asociación** (Apriori y FP-Growth)  
  Para encontrar relaciones frecuentes entre variables como causa de defunción, edad, sexo, tipo y vía del parto, etc.

- **Clustering K-Means**  
  Para identificar agrupamientos naturales entre edades, departamentos, meses de ocurrencia y tipo de parto.

El resultado de este análisis permite **identificar factores de riesgo y tendencias médicas**, así como **proporcionar información útil para políticas de salud pública y mejora de registros clínicos.**



## 2. Instalación y configuración en RStudio

###  Requisitos previos
- **R versión 4.3.2 o superior**
- **RStudio** 
- **Conexión a internet** para instalar paquetes

### Instalación de librerías necesarias

Ejecuta en la consola de RStudio:

```r
install.packages("readxl")
install.packages("dplyr")
install.packages("arules")
install.packages("fim4r")
install.packages("ggplot2")
```

### Cargar librerias al proyecto
```r
library(readxl)
library(dplyr)
library(arules)
library(fim4r)
library(ggplot2)
```

## 3. Descripción detallada del código

### 3.1 Carga y unión de datasets

Se importan los archivos Excel de los años 2022 y 2023 y se combinan en un único dataset:

```r
data2023 <- read_excel("Dataset/defunciones2023da.xlsx")
data2022 <- read_excel("Dataset/defunciones-2022.xlsx")
datos_unidos <- bind_rows(data2023, data2022)
```

##### *NOTA: El mismo procedimiento se realiza para los registros de defunciones fetales.*

---
### 3.2 Limpieza y selección de variables

Se seleccionan solo las columnas relevantes (edad, sexo, causa de muerte, tipo de parto, etc.) y se convierten a factores para permitir el procesamiento por los algoritmos de asociación:

```r
data_apriori2 <- datos_unidos[, c("Sexo", "Edadif", "Ecidif", "Escodif", "Caudef")]
data_apriori2[] <- lapply(data_apriori2, as.factor)
```

Las edades se agrupan en rangos para facilitar el análisis:

```r
data_apriori2$Edadif <- cut(data_apriori2$Edadif,
   breaks = c(0, 12, 18, 30, 45, 60, 75, 100),
   labels = c("Niñez", "Adolescente", "Joven adulto", "Adulto", 
              "Mediana edad", "Adulto mayor", "Anciano"),
   include.lowest = TRUE)
```

---

### 3.3 Reglas de Asociación - Apriori

Se aplica el algoritmo **Apriori** con un soporte y confianza mínimos de 0.002 y 0.75, respectivamente:

```r
reglas_apriori <- apriori(data_apriori2,
                          parameter = list(supp = 0.002, conf = 0.75, minlen = 2))
```

Se obtienen las reglas

```r
inspect(head(sort(reglas_apriori), 25))
```

---

### 3.4 Reglas de Asociación - FP-Growth

El algoritmo **FP-Growth** se aplica para optimizar la búsqueda de patrones frecuentes usando la librería `fim4r`:

```r
reglas_fp2 <- fim4r(data_FP, method = "fpgrowth", target = "rules", 
                    supp = 0.002, conf = 0.75)
rff <- as(reglas_fp2, "data.frame")
```
---

### 3.5 Agrupamiento K-Means

Se agrupan los datos por **edad** y **mes de ocurrencia** o **departamento**, para detectar concentraciones de casos:

```r
cluster_def <- kmeans(data_cluster[, c("Edadif", "Mesocu")], centers = 3)
```

Visualización con `ggplot2`:

```r
ggplot(data_cluster, aes(x = Edadif, y = Mesocu)) +
  stat_bin2d(bins = 30, aes(fill = ..count..)) +
  scale_fill_gradient(low = "lightyellow", high = "red") +
  scale_x_continuous(limits = c(0, 100)) +
  labs(title = "Mapa de Calor por Edad y Mes de Ocurrencia - Defunciones")
```

---

## 4. Visualización de resultados

Los gráficos generados permiten interpretar visualmente las asociaciones y clusters:

* **Mapa de calor:** Edad vs Mes de Ocurrencia
* **Boxplot:** Edad promedio por Departamento
* **Clusters fetales:** Edad Materna vs Semana de Gestación
* **Clusters de parto:** Edad Materna vs Tipo de Parto

Cada gráfico se genera con paletas de color personalizadas (`red`, `green`, `blue`) y títulos centrados.


## 5. Ejecución paso a paso

1. Descargar todos los archivos del proyecto en una carpeta local.
2. Abrir `ProyectoP1.R` en RStudio.
3. Instalar las librerías indicadas (solo la primera vez).
4. Ejecutar el bloque de carga y unión de datos.
5. Correr las secciones de **Apriori**, **FP-Growth**, y **K-Means**.
6. Visualizar las reglas en consola.
7. Revisar los gráficos generados directamente en RStudio (panel de “Plots”).
