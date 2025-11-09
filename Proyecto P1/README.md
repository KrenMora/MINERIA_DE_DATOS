# Análisis de Defunciones en Guatemala con Técnicas de Minería de Datos
**Autor:** Karen Morales  
**Lenguaje:** R (versión 4.3.2)  
**Librerías principales:** `arules`, `fim4r`, `dplyr`, `readxl`, `ggplot2`  
**Objetivo:** Aplicar técnicas de minería de datos (Apriori, FP-Growth y K-Means) sobre los registros de defunciones generales y fetales de Guatemala, con el fin de identificar patrones relevantes en causas de muerte, edad, sexo, tipo de parto y otros factores.



## Descripción General
Este proyecto forma parte del curso de **Minería de Datos** y tiene como objetivo aplicar técnicas de **descubrimiento de patrones y reglas de asociación** sobre los registros oficiales de **defunciones en Guatemala**, publicados por el **Instituto Nacional de Estadística (INE)**.  
El análisis permite identificar relaciones entre variables demográficas y sociales, así como patrones recurrentes en los casos registrados.



## Introducción

Mediante los algoritmos **Apriori** y **FP-Growth**, se identifican **reglas de asociación** que revelan comportamientos frecuentes en los datos, como la relación entre edad, sexo, nivel educativo, estado civil y causa de muerte.  El trabajo también incluye un proceso previo de **limpieza, integración y selección de variables relevantes**, seguido por la generación de patrones interpretables que faciliten la **identificación de segmentos de población con mayor vulnerabilidad**.

## Situación Actual en Guatemala

Guatemala enfrenta **desafíos estructurales en salud pública**, caracterizados por:

* Altos índices de **mortalidad materna e infantil**.
* **Desigualdad en el acceso** a servicios de salud, especialmente en áreas rurales.
* **Registros incompletos o tardíos** de defunciones, que limitan el análisis epidemiológico.

De acuerdo con el **Instituto Nacional de Estadística (INE)** y el **Ministerio de Salud Pública y Asistencia Social (MSPAS)**, las principales causas de defunción general están relacionadas con **enfermedades cardiovasculares, respiratorias y metabólicas**, mientras que las **defunciones fetales** se asocian a **complicaciones del embarazo, partos prolongados y falta de atención médica oportuna**.

El uso de técnicas de minería de datos permite **transformar los registros administrativos en conocimiento útil**, facilitando la **identificación de patrones de riesgo** y el diseño de **políticas públicas basadas en evidencia**.



## Datasets Utilizados

### 1. **Defunciones 2022-2023**
- **Fuente:** [INE Guatemala – Estadísticas Vitales: Defunciones](https://datos.ine.gob.gt/dataset/estadisticas-vitales-defunciones)
- **Archivos:** `defunciones-2022.xlsx - defunciones2023da.xlsx`
- **Descripción:** Contiene los registros de muertes generales ocurridas y registradas durante el año 2022 y 2023, incluyendo información de sexo, edad, causa de muerte, lugar de ocurrencia y asistencia médica.

### 2. **Defunciones Fetales 2022-2023**
- **Fuente:** [INE Guatemala – Estadísticas Vitales: Defunciones Fetales](https://datos.ine.gob.gt/dataset/estadisticas-vitales-defunciones-fetales)
- **Archivo:** `defunciones-fetales-2022.xlsx - bddefuncionesfetales2023.xlsx`
- **Descripción:** Contiene los registros más recientes de defunciones fetales reportadas en el año 2022 y 2023, con la misma estructura de variables que el dataset anterior agregando datos de la madre.

## Análisis de Reglas de Asociación – Defunciones 2022 y 2023

### 🔍 **Algoritmo Apriori**
- **Parámetros:**  supp = 0.002 | conf = 0.75

### Patrón 1

**Regla:** `{Caudef = X599} → {Sexo = 1}`

**Métricas:**
* **Soporte:** 0.0249
* **Confianza:** 0.8498
* **Lift:** 1.5469
* **Casos:** 4,764

**Interpretación:**
El código **X599** hace referencia a **causas de muerte no especificadas o exposición a factores no determinados**.
El patrón indica que el **85% de las muertes con esta causa corresponden a hombres**, evidenciando una **mayor incidencia masculina** en casos de muertes accidentales o sin causa clara. Sugiere que los hombres tienen **1.5 veces más probabilidad** de presentar este tipo de causa que el promedio general, lo que puede relacionarse con **riesgos laborales, accidentes o conductas de mayor exposición al peligro**.

### Patrón 2
**Regla:** `{Sexo = 2, Caudef = R54X} → {Edadif = Anciano}`

**Métricas:**

* **Soporte:** 0.0176
* **Confianza:** 0.8456
* **Lift:** 2.8000
* **Casos:** 3,375

**Interpretación:**
La causa **R54X** está asociada a **senilidad o envejecimiento avanzado**, es decir, muertes atribuibles al deterioro natural del organismo.
El patrón revela que **el 84.5% de las mujeres con esta causa pertenecen al grupo de edad “Anciano”**, lo que implica una **asociación casi tres veces más fuerte de lo esperado al azar**.
Esto refleja una tendencia demográfica clara: **las mujeres viven más que los hombres**, y por tanto, **presentan mayor incidencia de defunciones por envejecimiento natural**.

---
### 🔍 **Algoritmo FP-GROWTH**
- **Parámetros:**  supp = 0.002 | conf = 0.75

### Patrón 1

**Regla:** `{Sexo = 1, Caudef = R98X} → {Asist = 5}`

**Métricas:**

* **Soporte:** 0.0247
* **Confianza:** 0.9985
* **Lift:** 2.3125
* **Casos:** 4,733

**Interpretación:**
El código **R98X** corresponde a **Muerte sin asistencia**.
La regla muestra que el **99.8% de los casos con esta causa de muerte en hombres** se registraron con **“Asist = 5”**, lo que indica **ausencia de asistencia médica** al momento de la defunción. Demuestra que esta relación es **más del doble de lo esperado por azar**, lo que sugiere que muchos **hombres fallecen sin atención médica o fuera del sistema hospitalario**, posiblemente debido a **emergencias súbitas, accidentes o falta de acceso a servicios de salud**.


### Patrón 2

**Regla:** `{Asist = 1, Caudef = R99X} → {Puedif = 4}`

**Métricas:**

* **Soporte:** 0.0192
* **Confianza:** 0.7586
* **Lift:** 1.4106
* **Casos:** 3,676

**Interpretación:**
La causa **R99X** se asocia con **otras causas mal definidas o desconocidas**, y el valor **Asist = 1** indica que **sí hubo asistencia médica**.
El patrón revela que el **75.8% de estos casos** ocurrieron en personas cuyo **pueblo de pertenencia (Puedif = 4)** corresponde a **Ladino o mestizo**, según la codificación del dataset.
Una relación moderadamente fuerte, sugiriendo que **las defunciones de personas ladinas con atención médica tienden a clasificarse dentro de causas mal definidas**, probablemente reflejando **errores de registro o diagnósticos incompletos** en instituciones de salud.

---

### 🔍 **Agrupamiento K-Means**
- **Parámetros:**  supp = 0.002 | conf = 0.75

### **Interpretación del Mapa de Calor por Edad y Mes de Ocurrencia – Defunciones**

El **mapa de calor** representa la distribución de las **defunciones** según la **edad del fallecido** (eje X) y el **mes de ocurrencia** (eje Y).
Los colores más intensos (rojos) indican una **mayor frecuencia de muertes**, mientras que los tonos claros reflejan menor incidencia.

![Gráfico de K-Means](https://github.com/KrenMora/MINERIA_DE_DATOS/blob/main/Proyecto%20P1/Img/K1-Defuncion.png)

El análisis sugiere que la **mortalidad en Guatemala durante 2022–2023** se concentra en **adultos mayores**, con picos de incidencia durante los **meses medios del año (marzo–agosto)**.
Este patrón refleja la vulnerabilidad de este grupo etario frente a enfermedades crónicas y respiratorias, reforzando la necesidad de políticas de **prevención y atención médica especializada para la población de la tercera edad**.

---
###  **Interpretación del Boxplot – Edad promedio por Departamento y Clúster**

El gráfico de cajas muestra la **distribución de la edad promedio de los fallecidos** por **departamento**, agrupada en **tres clústeres** identificados mediante el algoritmo **K-Means**.
Cada color representa un grupo etario con características comunes en los registros de defunciones.

![Gráfico de K-Means](https://github.com/KrenMora/MINERIA_DE_DATOS/blob/main/Proyecto%20P1/Img/K2-Defuncion.png)

#### 🔴 Clúster 1 – Adultos jóvenes y adultos medios

* **Rango de edad:** entre 40 y 65 años.
* **Interpretación:** Este grupo concentra muertes de **personas en edad laboral activa**, posiblemente relacionadas con **enfermedades crónicas no transmisibles** (como diabetes o hipertensión), **accidentes laborales** o causas externas.



#### 🟢 Clúster 2 – Población infantil y juvenil

* **Rango de edad:** de 0 a 30 años.
* **Interpretación:** Agrupa **muertes tempranas**, especialmente en **niños, adolescentes y jóvenes adultos**.
  Este clúster puede reflejar causas asociadas a **condiciones perinatales, desnutrición o accidentes**.



#### 🔵 Clúster 3 – Adultos mayores

* **Rango de edad:** de 70 a 95 años.
* **Interpretación:** Representa la **población de la tercera edad**, en la cual predominan **enfermedades crónicas degenerativas** (cardiovasculares, respiratorias o metabólicas).



### Conclusión general

El gráfico revela **tres grupos etarios bien diferenciados**:

1. **Jóvenes (Clúster 2)** – mortalidad temprana.
2. **Adultos (Clúster 1)** – mortalidad asociada a la actividad económica.
3. **Adultos mayores (Clúster 3)** – mortalidad por enfermedades crónicas.

La **consistencia entre los departamentos** sugiere que la **edad es el principal factor determinante** de la mortalidad en Guatemala, más que el contexto geográfico.
Esto refuerza la importancia de diseñar **estrategias de salud pública específicas por grupo etario**, con énfasis en **prevención de enfermedades crónicas** y **atención infantil prioritaria**.


## Análisis de Reglas de Asociación – Defunciones Fetales 2022 y 2023

### 🔍 **Algoritmo Apriori**
- **Parámetros:**  supp = 0.002 | conf = 0.75

### Patrón 1

**Regla:** `{VIAPAR = 1, CLAPAR = 1, CAUDEF = P95X} → {TIPAR = 1}`

**Métricas:**

* **Soporte:** 0.2963
* **Confianza:** 0.9740
* **Lift:** 1.0147
* **Casos:** 1,350

**Interpretación:**
El código **P95X** se refiere a **muerte fetal de causa no especificada**.
El patrón muestra que **el 97% de los casos de muerte fetal con parto vaginal y único fueron partos simples**, lo que sugiere que **la mayoría de las defunciones fetales sin causa identificada ocurrieron en partos aparentemente normales**.
El **lift = 1** indica que esta relación es esperada, pero refuerza la necesidad de **mayor investigación médica en muertes fetales ocurridas en partos sin complicaciones visibles**.

### Patrón 2

**Regla:** `{SEMGES = Post-término, VIAPAR = 1, CLAPAR = 1} → {TIPAR = 1}`

**Métricas:**

* **Soporte:** 0.2603
* **Confianza:** 0.9966
* **Lift:** 1.0383
* **Casos:** 1,186

**Interpretación:**
Este patrón muestra que **el 99.6% de las muertes fetales ocurridas en embarazos post-término (más de 42 semanas)** se produjeron en **partos únicos, vaginales y catalogados como simples**.
Aunque clínicamente el parto no presentó complicaciones obstétricas (es decir, no fue múltiple ni quirúrgico), el **resultado fue la defunción fetal**, lo que sugiere que **el riesgo se asocia más al tiempo de gestación prolongado que al proceso del parto en sí**.

---

### 🔍 **Algoritmo FP-GROWTH**
- **Parámetros:**  supp = 0.002 | conf = 0.75

### Patrón 1

**Regla:** `{SEMGES = 3er trimestre avanzado, TOHINM = Ninguno} → {VIAPAR = [1,2]}`

**Métricas:**

* **Soporte:** 0.1528
* **Confianza:** 1.0000
* **Lift:** 1.0000
* **Casos:** 696

**Interpretación:**
El patrón muestra que **todas las muertes fetales ocurridas en el tercer trimestre avanzado y sin historial de hijos nacidos muertos (TOHINM = Ninguno)** se produjeron **mediante parto vaginal o cesárea**.
Esto implica que **la defunción fetal se detectó principalmente durante el proceso de parto asistido**, no antes.
La ausencia de antecedentes obstétricos y la coincidencia en partos asistidos podría señalar **una deficiencia en la vigilancia perinatal en etapas avanzadas del embarazo**, cuando el feto ya está completamente desarrollado.


### Patrón 2

**Regla:** `{CAUDEF = P209} → {VIAPAR = [1,2]}`

**Métricas:**

* **Soporte:** 0.3578
* **Confianza:** 1.0000
* **Lift:** 1.0000
* **Casos:** 1,630

**Interpretación:**
El código **P209** corresponde a *“muerte fetal de causa no especificada antes del inicio del trabajo de parto”*.
La regla indica que el **100% de las muertes fetales con esta causa ocurrieron en partos vaginales o cesáreas (VIAPAR=[1,2])**, es decir, dentro de procesos obstétricos asistidos.
Esto sugiere que **la mayoría de los fallecimientos fetales no ocurrieron de forma espontánea fuera del sistema médico**, sino durante o después del proceso de parto, resaltando la **importancia del control clínico durante la fase final del embarazo**.

---
###  🔍 **Algoritmo K-MEANS**
**Parámetros:**  supp = 0.002 | conf = 0.75

### **Interpretación del Clúster por Edad Materna y Semanas de Gestación**

El gráfico muestra el resultado del análisis de **agrupamiento K-Means**, aplicado a las variables **Edad de la Madre (EDADM)** y **Semanas de Gestación (SEMGES)** en casos de **defunciones fetales**.
Cada color representa un **clúster** con características similares entre los registros, mientras que los triángulos negros indican los **centros de cada grupo**.

![Gráfico de K-Means](https://github.com/KrenMora/MINERIA_DE_DATOS/blob/main/Proyecto%20P1/Img/K1-Fetal.png)


#### 🔴 Clúster 1 – Madres jóvenes con embarazos a término

* **Edad promedio:** entre 15 y 25 años.
* **Semanas de gestación:** entre 35 y 40 semanas (etapa final del embarazo).
* **Interpretación:** Este grupo representa a **madres adolescentes o jóvenes** que llegan al final de la gestación, pero presentan **mortalidad fetal cercana al parto**.
  Las causas pueden estar relacionadas con **falta de control prenatal, condiciones socioeconómicas vulnerables** o **atención médica insuficiente durante el parto**.


#### 🟢 Clúster 2 – Madres jóvenes con pérdidas en etapas intermedias

* **Edad promedio:** entre 20 y 30 años.
* **Semanas de gestación:** entre 20 y 30 semanas.
* **Interpretación:** Agrupa casos de **abortos espontáneos o muertes fetales prematuras**.
  Estas pérdidas suelen estar asociadas a **problemas infecciosos, malformaciones fetales o complicaciones obstétricas** durante el segundo trimestre.
  También podría reflejar **embarazos con seguimiento médico limitado**.


#### 🔵 Clúster 3 – Madres adultas con gestaciones prolongadas

* **Edad promedio:** entre 30 y 45 años.
* **Semanas de gestación:** entre 35 y 42 semanas.
* **Interpretación:** Corresponde a **madres adultas**, en su mayoría con gestaciones a término o post-término.
  La mortalidad fetal en este grupo puede estar asociada a **riesgos por edad avanzada**, como **hipertensión gestacional, diabetes o complicaciones del parto**.
  En este caso, el factor edad es determinante en el incremento del riesgo.


### Conclusión general

El análisis evidencia una **relación directa entre la edad materna y el momento de la pérdida fetal**:

1. Las **madres más jóvenes** concentran los casos de **pérdida al final del embarazo**.
2. Las **madres adultas jóvenes** presentan pérdidas **en la mitad de la gestación**.
3. Las **madres mayores** enfrentan mayor riesgo de **mortalidad fetal al final o después del término**.

Estos resultados refuerzan la importancia de **diferenciar las estrategias de control prenatal según el grupo etario**, enfocándose en la **detección temprana de riesgos obstétricos** y la **educación en salud reproductiva** para reducir la mortalidad fetal.

---

### **Interpretación del Clúster por Edad Materna y Tipo de Parto**

El gráfico muestra la distribución de la **edad de la madre** en relación con el **tipo de parto** (*1 = Parto Vaginal, 2 = Cesárea*), agrupadas en tres clústeres generados mediante el algoritmo **K-Means**.
Cada color representa un grupo de madres con características similares en cuanto a edad y tipo de parto.

![Gráfico de K-Means](https://github.com/KrenMora/MINERIA_DE_DATOS/blob/main/Proyecto%20P1/Img/K2-Fetal.png)

#### 🔴 Clúster 1 – Madres adolescentes o muy jóvenes

* **Edad promedio:** entre 15 y 22 años.
* **Tipo de parto predominante:** vaginal.
* **Interpretación:** Este grupo refleja casos de **madres adolescentes** o muy jóvenes, cuya mortalidad fetal ocurre principalmente en **partos naturales**.
  Esto puede asociarse a **embarazos no planificados, falta de control prenatal**, y **limitado acceso a servicios médicos especializados**, lo que incrementa el riesgo de complicaciones durante el parto.


#### 🟢 Clúster 2 – Madres adultas

* **Edad promedio:** entre 33 y 40 años.
* **Tipo de parto:** se observa tanto en partos vaginales como cesáreas, con predominio leve de cesárea.
* **Interpretación:** Este grupo representa a **madres adultas en edad avanzada reproductiva**, con una mayor probabilidad de **complicaciones obstétricas** que requieren **intervención quirúrgica (cesárea)**.
  Las causas podrían estar relacionadas con **riesgos gestacionales por edad**, como hipertensión, diabetes gestacional o problemas fetoplacentarios.


#### 🔵 Clúster 3 – Madres jóvenes-adultas

* **Edad promedio:** entre 25 y 30 años.
* **Tipo de parto predominante:** cesárea.
* **Interpretación:** Se agrupa a madres **jóvenes adultas** que, aunque se encuentran en una etapa reproductiva saludable, presentan **complicaciones médicas o fetales** que requieren cesárea.
  Esto podría reflejar un aumento de **procedimientos obstétricos preventivos** o **complicaciones intraparto controladas en centros hospitalarios**.


### Conclusión general

El análisis evidencia tres grupos bien diferenciados:

1. **Clúster 1:** Mortalidad fetal en madres adolescentes, partos vaginales y bajo control prenatal.
2. **Clúster 2:** Mortalidad fetal en madres adultas, con mayor incidencia de cesáreas por complicaciones asociadas a la edad.
3. **Clúster 3:** Mortalidad fetal en madres jóvenes-adultas, con intervenciones quirúrgicas posiblemente preventivas.

Estos resultados destacan la **relación entre la edad materna y el tipo de parto** como factores clave en los casos de defunción fetal.
Se recomienda fortalecer los **programas de atención prenatal diferenciados por edad** y garantizar **acceso equitativo a servicios obstétricos seguros**, especialmente para mujeres jóvenes y adolescentes.


## **Propuestas basadas en los resultados obtenidos**

### 1. Fortalecer la vigilancia obstétrica en embarazos post-término

Los resultados de las defunciones fetales muestran una alta incidencia en embarazos con más de 42 semanas. Se recomienda establecer **protocolos de inducción temprana del parto (antes de la semana 42)** y **monitoreo fetal intensivo** durante el tercer trimestre.

### 2. Control prenatal diferenciado por grupo etario

El análisis de clústeres evidencia distintos riesgos según la edad materna:

* **Madres adolescentes:** reforzar la educación sexual, el acceso a servicios de salud reproductiva y la atención temprana del embarazo.
* **Madres adultas mayores:** fortalecer la detección de enfermedades crónicas (hipertensión, diabetes) que incrementan el riesgo de muerte fetal.

### 3. Mejora en la calidad del registro médico

Las causas de muerte **no especificadas (R98X, R99X, P95X)** representan un porcentaje significativo en los registros. Se sugiere **capacitación continua para el personal médico y de registro civil**, y la implementación de **sistemas electrónicos estandarizados** para garantizar una mejor clasificación de causas.

### 4. Atención prioritaria a la población masculina en riesgo

En los datos de defunciones generales, los hombres presentan mayor incidencia en muertes accidentales y sin asistencia médica. Se propone impulsar **campañas de prevención de accidentes laborales y de tránsito**, así como **programas de atención médica preventiva** dirigidos a hombres adultos jóvenes.

### 5. Uso de analítica predictiva en salud pública

Los resultados demuestran que los algoritmos de minería de datos pueden identificar grupos de riesgo. Se recomienda **implementar sistemas predictivos a nivel institucional (MSPAS, INE)** que permitan anticipar tendencias de mortalidad y orientar políticas de prevención.



## Bibliografía
De, S., & Materna, L. M. (s/f). Unfpa.org. Recuperado el 9 de noviembre de 2025, de https://guatemala.unfpa.org/sites/default/files/pub-pdf/informe_de_pais_mortalidad_materna.pdf

Informes de MM 2022 y 2023 y normas de atención. (s/f). Osarguatemala.org. Recuperado el 9 de noviembre de 2025, de https://osarguatemala.org/informes/

Maternal mortality ratio (modeled estimate, per 100,000 live births) - Guatemala. (s/f). World Bank Open Data. Recuperado el 9 de noviembre de 2025, de https://data.worldbank.org/indicator/SH.STA.MMRT?locations=GT

Ministerio de Salud Pública y Asistencia Social (MSPAS). (2023). *Informe Nacional de Salud Materno Infantil 2023.*  
  Guatemala: MSPAS.

Organización Mundial de la Salud (OMS). (2022). *Trends in maternal mortality 2000 to 2020: Estimates by WHO, UNICEF, UNFPA, World Bank Group and UNDESA/Population Division.*  
  Geneva: OMS.

(S/f-a). Gob.gt. Recuperado el 9 de noviembre de 2025, de https://datos.ine.gob.gt

(S/f-b). Unicef.org. Recuperado el 9 de noviembre de 2025, de https://www.unicef.org/guatemala/informes/situacion-ninez-2023

(S/f-c). Paho.org. Recuperado el 9 de noviembre de 2025, de https://www.paho.org/es/documentos/analisis-situacion-salud-guatemala-2022







