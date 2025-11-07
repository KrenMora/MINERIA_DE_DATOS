# Proyecto – Parte 1: Análisis de Defunciones en Guatemala con Técnicas de Minería de Datos

## 📘 Descripción General
Este proyecto forma parte del curso de **Minería de Datos** y tiene como objetivo aplicar técnicas de **descubrimiento de patrones y reglas de asociación** sobre los registros oficiales de **defunciones en Guatemala**, publicados por el **Instituto Nacional de Estadística (INE)**.  
El análisis permite identificar relaciones entre variables demográficas y sociales, así como patrones recurrentes en los casos registrados.

---

## 🧭 Introducción

El presente proyecto tiene como finalidad **aplicar técnicas de minería de datos** sobre los registros de defunciones de Guatemala, con el propósito de **descubrir patrones y relaciones entre variables demográficas, sociales y médicas**.  

Mediante los algoritmos **Apriori** y **FP-Growth**, se identifican **reglas de asociación** que revelan comportamientos frecuentes en los datos, como la relación entre edad, sexo, nivel educativo, estado civil y causa de muerte.  

El trabajo también incluye un proceso previo de **limpieza, integración y selección de variables relevantes**, seguido por la generación de patrones interpretables que faciliten la **identificación de segmentos de población con mayor vulnerabilidad**.

---

## 📊 Datasets Utilizados

### 1. **Defunciones 2022-2023**
- **Fuente:** [INE Guatemala – Estadísticas Vitales: Defunciones](https://datos.ine.gob.gt/dataset/estadisticas-vitales-defunciones)
- **Archivos:** `defunciones-2022.xlsx - defunciones2023da.xlsx`
- **Descripción:** Contiene los registros de muertes generales ocurridas y registradas durante el año 2022 y 2023, incluyendo información de sexo, edad, causa de muerte, lugar de ocurrencia y asistencia médica.

### 2. **Defunciones Fetales 2022-2023**
- **Fuente:** [INE Guatemala – Estadísticas Vitales: Defunciones Fetales](https://datos.ine.gob.gt/dataset/estadisticas-vitales-defunciones-fetales)
- **Archivo:** `defunciones-fetales-2022.xlsx - bddefuncionesfetales2023.xlsx`
- **Descripción:** Contiene los registros más recientes de defunciones fetales reportadas en el año 2022 y 2023, con la misma estructura de variables que el dataset anterior agregando datos de la madre.

## 🩺 Análisis de Reglas de Asociación – Defunciones 2022 y 2023

## 🔹 Algoritmo Apriori
**Parámetros:** supp = 0.01 | conf = 0.7

### Patrón 1
**Regla:** `{Edadif=[0,49], Ecidif=[1,2], Escodif=[1,2], Ciuodif=99, Ocur=[1,6]} → {Perdif=[1,3]}`  
**Soporte:** 0.01879 | **Confianza:** 0.8341 | **Lift:** 11.85  
**Interpretación:** Las defunciones se concentran en **adultos jóvenes** con **bajo nivel educativo** (primaria o secundaria), **estado civil casado o unión libre** y sin registro laboral.  
El alto valor de *lift* (11.95) indica una **fuerte asociación** entre estas características y el grupo etario [1,3], que corresponde a personas jóvenes y de mediana edad.

### Patrón 2
**Regla:** `{Sexo=[1,2], Edadif=[0,49], Escodif=[1,2], Ciuodif=99, Ocur=[1,6]} → {Perdif=[1,3]}`  
**Soporte:** 0.01879 | **Confianza:** 0.8108 | **Lift:** 11.52  
**Interpretación:** Tanto hombres como mujeres menores de 50 años, con **educación básica** y **ocupación no registrada**, tienden a fallecer dentro del grupo etario [1,3].  
La relación evidencia una tendencia en los **adultos jóvenes** con **condiciones socioeconómicas precarias**, posiblemente vinculada a riesgos laborales o falta de atención médica oportuna.


### Corrida 2 para encontrar patrones mas generales



## Resultados 1 Apriori / defuncion Parámetros:** supp = 0.01 | conf = 0.7
| # | LHS (Condición) | RHS (Resultado) | Soporte | Confianza | Cobertura | Lift | Casos |
|---|------------------|-----------------|----------|------------|------------|-------|--------|
| 1 | {Edadif=[0,49), Ecidif=[1,2), Escodif=[1,2), Ciuodif=99, Ocur=[1,6)} | {Perdif=[1,3)} | 0.01879959 | 0.8341837 | 0.02253651 | 11.85088 | 3597 |
| 2 | {Edadif=[0,49), Escodif=[1,2), Ciuodif=99, Asist=[1,5), Ocur=[1,6)} | {Perdif=[1,3)} | 0.01856440 | 0.8254706 | 0.02248947 | 11.72710 | 3552 |
| 3 | {Edadif=[0,49), Escodif=[1,2), Ciuodif=99, Nacdif=[320,1e+04], Ocur=[1,6)} | {Perdif=[1,3)} | 0.01879959 | 0.8165721 | 0.02302257 | 11.60068 | 3597 |
| 4 | {Edadif=[0,49), Puedif=[4,9], Escodif=[1,2), Ciuodif=99, Ocur=[1,6)} | {Perdif=[1,3)} | 0.01801039 | 0.8146572 | 0.02210794 | 11.57348 | 3446 |
| 5 | {Edadif=[0,49), Escodif=[1,2), Ciuodif=99, Ocur=[1,6)} | {Perdif=[1,3)} | 0.01879959 | 0.8108656 | 0.02318459 | 11.51961 | 3597 |
| 6 | {Sexo=[1,2], Edadif=[0,49), Escodif=[1,2), Ciuodif=99, Ocur=[1,6)} | {Perdif=[1,3)} | 0.01879959 | 0.8108656 | 0.02318459 | 11.51961 | 3597 |
| 7 | {Añoocu=[2022,2023], Edadif=[0,49), Escodif=[1,2), Ciuodif=99, Ocur=[1,6)} | {Perdif=[1,3)} | 0.01879959 | 0.8108656 | 0.02318459 | 11.51961 | 3597 |
| 8 | {Ecidif=[1,2), Escodif=[1,2), Ciuodif=99, Nacdif=[320,1e+04], Ocur=[1,6)} | {Perdif=[1,3)} | 0.01879959 | 0.8072262 | 0.02328912 | 11.46791 | 3597 |
| 9 | {Ecidif=[1,2), Escodif=[1,2), Ciuodif=99, Asist=[1,5), Ocur=[1,6)} | {Perdif=[1,3)} | 0.01856440 | 0.8069060 | 0.02300689 | 11.46336 | 3552 |
| 10 | {Puedif=[4,9], Ecidif=[1,2), Escodif=[1,2), Ciuodif=99, Ocur=[1,6)} | {Perdif=[1,3)} | 0.01801039 | 0.8055166 | 0.02235881 | 11.44362 | 3446 |

## Resultado 2 FP-Growth Parámetros:** supp = 0.01 | conf = 0.7
| # | Regla | Soporte | Confianza | Lift | Casos |
|---|--------|----------|------------|------|--------|
| 1 | `{ } → {Sexo=[1,2]}` | 1.0000000 | 1.0000000 | 1.00 | 191,334 |
| 2 | `{Añoocu=[2022,2023]} → {Sexo=[1,2]}` | 1.0000000 | 1.0000000 | 1.00 | 191,334 |
| 3 | `{Sexo=[1,2]} → {Añoocu=[2022,2023]}` | 1.0000000 | 1.0000000 | 1.00 | 191,334 |
| 4 | `{ } → {Añoocu=[2022,2023]}` | 1.0000000 | 1.0000000 | 1.00 | 191,334 |
| 5 | `{Nacdif=[320,1e+04]} → {Sexo=[1,2]}` | 0.9951498 | 1.0000000 | 1.00 | 190,406 |
| 6 | `{Sexo=[1,2]} → {Nacdif=[320,1e+04]}` | 0.9951498 | 0.9951498 | 1.00 | 190,406 |
| 7 | `{Añoocu=[2022,2023], Nacdif=[320,1e+04]} → {Sexo=[1,2]}` | 0.9951498 | 1.0000000 | 1.00 | 190,406 |
| 8 | `{Sexo=[1,2], Nacdif=[320,1e+04]} → {Añoocu=[2022,2023]}` | 0.9951498 | 1.0000000 | 1.00 | 190,406 |
| 9 | `{Sexo=[1,2], Añoocu=[2022,2023]} → {Nacdif=[320,1e+04]}` | 0.9951498 | 0.9951498 | 1.00 | 190,406 |
| 10 | `{Nacdif=[320,1e+04]} → {Añoocu=[2022,2023]}` | 0.9951498 | 1.0000000 | 1.00 | 190,406 |








