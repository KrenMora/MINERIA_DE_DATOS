

# **Interpretación del Árbol de Decisión — Predicción del Sexo del Agresor**

## 1. **Descripción General del Modelo**

El objetivo del modelo es **predecir el sexo del agresor (`AGR_SEXO`)** utilizando como variables predictoras:

* `VIC_EDAD` → Edad de la víctima
* `VIC_SEXO` → Sexo de la víctima
* `VIC_ESCOLARIDAD` → Nivel educativo de la víctima
* Variables creadas:

  * `EDAD30`: Categoriza si la víctima tiene **menos de 30** o **30 años o más**.
  * `ESC_OK`: Indica si la escolaridad es válida (`!= 99`) o no registrada.

El modelo se construyó con un **árbol de decisión** usando `rpart` y fue simplificado mediante los parámetros:

* `cp = 0.01`
* `minsplit = 60`
* `maxdepth = 3`

Esto garantiza un árbol **pequeño e interpretable**.


## 2. **Estructura General del Árbol**

El árbol divide los casos siguiendo esta lógica:

1. **Primer nodo**:

   ✔ Se analiza si la víctima es *mujer u hombre*.
   Esta es la variable que más aporta a predecir el sexo del agresor.

2. **Segundo nivel**:

   ✔ Se evalúa si la víctima tiene **30 años o más**.
  
   ✔ Se revisa si la escolaridad es válida o no registrada.

Estos atributos ayudan a identificar patrones sociodemográficos asociados a cada tipo de agresor.


## 3. **Interpretación de las Reglas del Árbol**

A continuación se explica cada rama del árbol de manera clara:

### ### 🌿 **Rama 1 – Víctima Mujer (`VIC_SEXO = 2`)**

**Predicción principal:**
➡️ **El agresor tiende a ser Hombre (`AGR_SEXO = 1`)**

Esto se debe a que en casos de violencia intrafamiliar,
la mayoría de agresores registrados son hombres cuando la víctima es mujer.

**Justificación del árbol:**

* Este grupo es el más grande en la base.
* Independientemente de edad o escolaridad, la agresión suele venir de un hombre.

**Interpretación social:**

✔ Existe una tendencia marcada hacia la violencia ejercida por hombres hacia mujeres.

✔ Confirma patrones ampliamente documentados en estudios de violencia doméstica.


### **Rama 2 – Víctima Hombre (`VIC_SEXO = 1`)**

Cuando la víctima es hombre, el árbol encuentra más variabilidad y crea divisiones adicionales:

### **2.1 Si la víctima es hombre y tiene ≥ 30 años (`EDAD30 = '>=30'`)**

**Predicción:**
 **Es más probable que el agresor sea Hombre**

**Interpretación:**

* Hombres adultos suelen ser victimizados por otros hombres (padres, hermanos, familiares masculinos).
* La agresión entre hombres es más frecuente en grupos etarios mayores.


### **2.2 Si la víctima es hombre y tiene < 30 años (`EDAD30 = '<30'`)**

El árbol usa ahora la escolaridad:

#### **2.2.1 Escolaridad válida (`ESC_OK = 'Valida'`)**

**Predicción:**
**Mayor probabilidad de agresor Hombre**

**Interpretación:**

* En víctimas jóvenes con escolaridad registrada,
  la agresión proviene más frecuentemente de figuras masculinas (padres, padrastros, hermanos).

---

#### **2.2.2 Escolaridad desconocida (`ESC_OK = 'Sin dato'`)**

**Predicción:**
➡️ **Aumenta la probabilidad de agresor Mujer (`AGR_SEXO = 2`)**

**Interpretación:**

* Cuando no se registra la escolaridad, el caso suele estar relacionado con agresoras mujeres.
* Estos casos suelen tener perfiles particulares:

  ✔ agresoras madres

  ✔ tías o responsables de cuidado

  ✔ cuidadores femeninos en ambientes domésticos



## 3. **Conclusión del Modelo**

El árbol muestra que:

* **La mayoría de agresiones son cometidas por hombres**, especialmente cuando la víctima es mujer.
* **Cuando la víctima es hombre**, factores como la edad y la escolaridad ayudan a detectar casos donde **el agresor es mujer**.
* El modelo es simple pero **refleja patrones reales de violencia intrafamiliar** observados en Guatemala.

Este análisis puede servir como base para:

* Identificar perfiles de riesgo.
* Crear estrategias de prevención.
* Orientar políticas públicas y trabajo social.

