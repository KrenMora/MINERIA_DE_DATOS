# 📘 Diccionario de Datos — Defunciones (INE Guatemala)

**Fuente:** [https://datos.ine.gob.gt/dataset/14f547c3-ad37-4ea1-9e74-16a3ed50ff54](https://datos.ine.gob.gt/dataset/14f547c3-ad37-4ea1-9e74-16a3ed50ff54)

---

| Columna | Tipo | Descripción |
|----------|------|-------------|
| **Depreg** | Numérico | Código del **departamento donde se registró la defunción** (1 = Guatemala, 2 = El Progreso, etc.). |
| **Mupreg** | Numérico | Código del **municipio donde se registró la defunción**. |
| **Mesreg** | Numérico | **Mes del registro** de la defunción (1 = enero, 12 = diciembre). |
| **Añoreg** | Numérico | **Año del registro** |
| **Depocu** | Numérico | Código del **departamento donde ocurrió la defunción** (puede diferir del de registro). |
| **Mupocu** | Numérico | Código del **municipio donde ocurrió la defunción**. |
| **Sexo** | Numérico | **Sexo de la persona fallecida** (1 = Hombre, 2 = Mujer, 9 = Ignorado). |
| **Diaocu** | Numérico | Día del mes en que **ocurrió** la defunción. |
| **Mesocu** | Numérico | Mes en que **ocurrió** la defunción. |
| **Añoocu** | Numérico | Año en que **ocurrió** la defunción. |
| **Edadif** | Numérico | **Edad del fallecido** en años cumplidos (para menores de 1 año se puede registrar en meses o días según codificación del INE). |
| **Perdif** | Numérico | **Periodo de edad** del fallecido (por grupos etarios: por ejemplo, 1 = <1 año, 2 = 1-4 años, 3 = 5-9 años, etc.). |
| **Puedif** | Numérico | **Pueblo o grupo étnico** del fallecido (1 = Ladino, 2 = Maya, 3 = Xinka, 4 = Garífuna, 9 = Ignorado). |
| **Ecidif** | Numérico | **Estado civil del fallecido** (1 = Soltero, 2 = Casado, 3 = Unión libre, 4 = Viudo, 9 = Ignorado). |
| **Escodif** | Numérico | **Nivel educativo alcanzado** por el fallecido (1 = Ninguno, 2 = Primaria, 3 = Secundaria, 4 = Universitario, 9 = Ignorado). |
| **Ciuodif** | Numérico | **Condición de ocupación** (1 = Trabajando, 2 = Desempleado, 3 = Estudiante, 4 = Ama de casa, etc., depende del catálogo del INE). |
| **Pnadif** | Numérico | **País de nacimiento** del fallecido. |
| **Dnadif** | Numérico | **Departamento de nacimiento** del fallecido. |
| **Mnadif** | Numérico | **Municipio de nacimiento** del fallecido. |
| **Nacdif** | Numérico | **Nacionalidad** (1 = Guatemalteca, 2 = Extranjera, 9 = Ignorada). |
| **Predif** | Numérico | **País de residencia habitual** del fallecido. |
| **Dredif** | Numérico | **Departamento de residencia habitual**. |
| **Mredif** | Numérico | **Municipio de residencia habitual**. |
| **Caudef** | Texto | **Causa de defunción**, codificada según la **Clasificación Internacional de Enfermedades (CIE-10)**. |
| **Asist** | Numérico | **Tipo de asistencia médica recibida** antes o durante la muerte (1 = Médico, 2 = Partera, 3 = Ninguna, 9 = Ignorado). |
| **Ocur** | Numérico | **Lugar donde ocurrió la defunción** (1 = Hospital, 2 = Domicilio, 3 = Otro, 9 = Ignorado). |
| **Cerdef** | Numérico | **Certificado de defunción emitido por** (1 = Médico, 2 = Partera, 3 = Juez, 4 = Otro, 9 = Ignorado). |

---

**Notas:**  
- Los códigos de departamento y municipio siguen los catálogos oficiales del **INE** y del **RENAP**.  
- Las causas de muerte (`Caudef`) se basan en la **CIE-10**, por lo que pueden agruparse en categorías como enfermedades, accidentes, o causas externas.  
- Los valores **9 o 99** representan **dato no especificado** o **ignorado**.


