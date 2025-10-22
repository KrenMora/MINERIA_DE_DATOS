# Análisis de Patrones de Asociación con el Algoritmo FP Growth  
**Dataset:** Violencia intrafamiliar año 2024   
[Violencia intrafamiliar año 2024](https://datos.ine.gob.gt/dataset/violencia-intrafamiliar/resource/73875737-52c9-41b3-accf-37b44e534bec)
---

## 📘 Introducción
El presente análisis aplica el algoritmo **FP Growth** sobre los datos de Violencia intrafamiliar año 2024 en Guatemala, con el propósito de descubrir asociaciones entre variables. A continuación, se presentan tres patrones relevantes obtenidos con parámetros de soporte y confianza representativos del conjunto de datos.

---

## 🔹 Patrón 1
**Regla:**  
`{VIC_EST_CIV = [2,5]} → {VIC_SEXO = [1,2]}`  

**Métricas:**  
- Soporte: ` 0.5618`  
- Confianza: `1.0000`  

**Interpretación:**  
Entre las víctimas que tienen hijos, más de la mitad aprox.56 % están casadas o viven en unión libre(2,,5). Esto sugiere que la violencia intrafamiliar ocurre con mayor frecuencia dentro de relaciones formales o convivencias estables, donde hay hijos en común y, posiblemente, una relación de dependencia o convivencia prolongada.

---

## 🔹 Patrón 2
**Regla:**  
`{VIC_EDAD=[39,99]} →  {AGR_EDAD=[40,99]}`  

**Métricas:**  
- Soporte: `0.2184`  
- Confianza: `0.6481`  

**Interpretación:**  
Cuando el agresor trabaja y tiene entre **40 y 99  años**, la víctima suele tener entre 39 y 99 años. Esto sugiere relaciones con ***diferencia de edad leve donde el agresor posee estabilidad laboral***, pero puede mantener control económico o psicológico sobre la víctima.


---

## 🔹 Patrón 3
**Regla:**  
`{VIC_ESCOLARIDAD = [31,99]}  → {AGR_TRABAJA = [1,9]}`  

**Métricas:**  
- Soporte: `0.334206`  
- Confianza: `1.0000`  

**Interpretación:**  
El soporte del **33 % indica que un tercio de todos los casos rurales presentan esta combinación**, lo que lo convierte en un patrón frecuente y socialmente relevante para orientar programas de prevención en comunidades rurales.En los casos de violencia intrafamiliar ocurridos en área rural, todas las víctimas con ***nivel educativo entre 31 y 99*** tienen agresores que trabajan.



## 📬 Resultados 
```
     lhs                                                      rhs                           support   confidence coverage        
{VIC_EST_CIV=[2,5)}                                        => {VIC_SEXO=[1,2]}              0.5618602  1.0000000 1.000000
{VIC_EDAD=[39,99]}                                         => {AGR_EDAD=[40,99]}            0.2184474  0.6481064 1.7640974  
{VIC_ESCOLARIDAD=[31,99]}                                  => {AGR_TRABAJA=[1,9]}           0.3342406  1.0000000 1.000000  

```

