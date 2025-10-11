# Análisis de Patrones de Asociación con el Algoritmo Apriori  
**Dataset:** Graduados de Educación Superior 2023  
https://datos.ine.gob.gt/dataset/educacion-superior-graduados
---

## 📘 Introducción
El presente análisis aplica el algoritmo **Apriori** sobre los datos de graduados de educación superior en Guatemala, con el propósito de descubrir asociaciones entre variables demográficas y el tipo de institución educativa (sector público o privado).  
A continuación, se presentan tres patrones relevantes obtenidos con parámetros de soporte y confianza representativos del conjunto de datos.

---

## 🔹 Patrón 1
**Regla:**  
`{Sector = Público}  →  {Pueblo_Pertenencia = Ladino}`  

**Métricas:**  
- Soporte: `0.2216`  
- Confianza: `0.7737`  

**Interpretación:**  
Existe una asociación significativa entre estudiar en una **institución pública** y pertenecer al grupo **Ladino**.  
Entre los graduados del sector público, aproximadamente el **77%** se identifican como Ladinos.  
Esto sugiere que la mayoría de estudiantes que se gradúan en el sector público pertenecen a este grupo étnico, posiblemente reflejando la **composición demográfica general del país**.

---

## 🔹 Patrón 2
**Regla:**  
`{Pueblo_Pertenencia = Ignorado}  →  {Sector = Privado}`  

**Métricas:**  
- Soporte: `0.3809`  
- Confianza: `0.9439`  

**Interpretación:**  
Cuando el valor de **Pueblo de Pertenencia** se registró como **“Ignorado”**, el **94%** de esos casos corresponden a **graduados del sector privado**.  
Esto podría deberse a **diferencias en los procesos administrativos** del sector privado al momento de recopilar los datos del estudiante, reflejando una menor uniformidad en la recolección de información étnica.

---

## 🔹 Patrón 3
**Regla:**  
`{Sexo = Mujer}  →  {Sector = Privado}`  

**Métricas:**  
- Soporte: `0.4095`  
- Confianza: `0.7009`  

**Interpretación:**  
Aproximadamente el **70% de las mujeres graduadas** lo hicieron en el **sector privado**, lo cual muestra una **tendencia predominante de mujeres en la educación privada**.  
Esto podría estar relacionado con factores como mayor cobertura geográfica y accesibilidad de universidades privadas en comparación con las públicas o de horarios más flexibles


## 📬 Resultados 
```
     lhs                                                      rhs                           support   confidence coverage  lift      count

[5]  {Sector=Público}                                      => {Pueblo_Pertenencia=Ladino}   0.2216029 0.7736914  0.2864229 1.4669313  3976

[13] {Pueblo_Pertenencia=Ignorado}                         => {Sector=Privado}              0.3808940 0.9439227  0.4035225 1.3228040  6834

[21] {Sexo=Mujer}                                          => {Sector=Privado}              0.4095419 0.7008775  0.5843273 0.9822030  7348

[50] {Departamento=Guatemala, Sector=Privado}              => {Sexo=Mujer}                  0.4095419 0.5739280  0.7135771 0.9822030  7348

```
