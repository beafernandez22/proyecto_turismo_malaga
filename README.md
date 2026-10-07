Tema: turismo sostenible en Málaga.
Problema: presión turística y percepción de los residentes.
Pregunta principal: ¿Qué factores están asociados con una mayor percepción negativa del turismo entre los residentes de Málaga y dónde se concentra esa presión?
Hipótesis principal: las zonas con mayor presión turística podrían presentar una percepción más negativa.


# Turismo sostenible en Málaga: presión turística y percepción de los residentes

## 1. Objetivo del proyecto

Analizar la presión turística en Málaga capital y estudiar su relación con la percepción de los residentes durante 2023, con especial atención a la concentración de viviendas de uso turístico (VUT) en los distintos distritos.

El objetivo es identificar posibles desequilibrios territoriales que puedan ayudar a orientar decisiones relacionadas con la gestión sostenible del turismo.


## 2. Contexto del negocio

Este proyecto se plantea desde la perspectiva de una administración pública local, como el Ayuntamiento de Málaga, responsable de compatibilizar el desarrollo turístico de la ciudad con la calidad de vida de sus residentes.

El crecimiento turístico puede generar beneficios económicos, pero también diferentes niveles de presión sobre los barrios de la ciudad. Por ello, resulta relevante identificar:

- dónde se concentra la oferta de viviendas turísticas;
- qué distritos presentan una percepción más negativa del turismo;
- si ambas variables están relacionadas;
- y qué zonas podrían requerir un análisis más detallado antes de tomar decisiones de gestión turística.


## 3. Dataset

El proyecto combina diferentes fuentes de datos públicos para analizar el turismo en Málaga desde tres perspectivas: actividad turística, concentración territorial de viviendas turísticas y percepción de los residentes.

### Fuentes de datos

**1. Instituto Nacional de Estadística (INE)**  
Datos mensuales de la Encuesta de Ocupación Hotelera para Málaga capital durante 2023, obtenidos mediante la API del INE.

Variables principales:
- Mes
- Residencia del viajero: España / Extranjero
- Número de viajeros
- Número de pernoctaciones

Estos datos se utilizan para contextualizar el nivel y la evolución de la actividad turística de la ciudad durante 2023.

**2. OpenRTA – Junta de Andalucía**  
Registro de viviendas de uso turístico (VUT) localizadas en Málaga capital.

Variables principales:
- Código de registro
- Fecha de inscripción
- Coordenadas geográficas

A partir de las coordenadas y los límites geográficos de los distritos municipales se asigna cada VUT a uno de los 11 distritos de Málaga y se calcula el número de VUT por distrito.

**3. Observatorio de Turismo Sostenible de Málaga (STO Málaga)**  
Datos de percepción del turismo entre los residentes de los 11 distritos de Málaga durante 2023.

Variables principales:
- Distrito
- Percepción positiva (%)
- Percepción negativa (%)
- Sin respuesta (%)

### Calidad y tratamiento de los datos

Los datos procedentes de las distintas fuentes requirieron procesos de limpieza y homogeneización antes de poder analizarlos conjuntamente.

En los datos de OpenRTA se detectaron registros con coordenadas ausentes o localizaciones que no podían asignarse correctamente a ningún distrito. Tras aplicar el filtro temporal hasta el 31/12/2023 y realizar la asignación geográfica, se utilizaron 9.991 registros VUT con distrito válido.

Además, los datos de OpenRTA representan establecimientos actualmente presentes en el registro cuya fecha de inscripción es igual o anterior al 31/12/2023, por lo que no deben interpretarse como el stock histórico exacto de VUT existente en 2023.


## 4. Preguntas clave

El análisis busca responder principalmente a la siguiente pregunta:

**¿Existe una relación entre la concentración de viviendas de uso turístico (VUT) y la percepción negativa del turismo entre los residentes de los distritos de Málaga?**

Para responderla, se plantean las siguientes preguntas secundarias:

- ¿En qué distritos se concentra el mayor número de VUT?
- ¿Qué distritos presentan una mayor percepción negativa del turismo?
- ¿Coinciden los distritos con mayor concentración de VUT con aquellos donde la percepción negativa es más elevada?
- ¿Qué relación estadística existe entre el número de VUT y el porcentaje de percepción negativa?
- ¿Cómo se distribuyen territorialmente ambas variables en Málaga?
- ¿Cómo se comportó la actividad turística de Málaga durante 2023 en términos de viajeros y pernoctaciones?


## 5. Proceso de análisis

El proyecto se desarrolló combinando Python, análisis geoespacial y SQL.

### 1. Extracción y preparación de datos
- Obtención de datos de viajeros y pernoctaciones mediante la API del INE.
- Extracción programática de los datos de percepción de residentes del informe de STO Málaga.
- Obtención y procesamiento de los registros de VUT de OpenRTA.
- Incorporación de los límites geográficos oficiales de los 11 distritos de Málaga.

### 2. Limpieza y transformación
Se realizaron diferentes procesos de limpieza, entre ellos:
- Conversión y homogeneización de tipos de datos.
- Tratamiento de fechas y porcentajes.
- Gestión de valores ausentes.
- Homogeneización de diferentes estructuras de registros de OpenRTA.
- Selección de las variables relevantes para el análisis.
- Filtrado temporal de los registros VUT hasta el 31/12/2023.

### 3. Análisis geoespacial
Las coordenadas de las VUT se transformaron en datos geográficos y se realizó un *spatial join* con los límites municipales para asignar cada alojamiento a su distrito correspondiente.

### 4. Análisis exploratorio (EDA)
Se analizaron:
- La evolución mensual de viajeros y pernoctaciones.
- La distribución de VUT entre los distritos.
- Los niveles de percepción positiva y negativa del turismo.
- Los distritos con valores superiores a la media de percepción negativa.

### 5. Análisis con SQL
Los datos agregados de VUT y percepción se almacenaron en MySQL para realizar consultas, joins, rankings, filtros, agregaciones, subconsultas y crear una vista conjunta por distrito.

### 6. Análisis estadístico y visualización
Finalmente, se combinaron los datos de VUT y percepción para estudiar su relación mediante:
- Número absoluto de VUT por distrito.
- Densidad de VUT por km² como indicador relativo de presión territorial.
- Correlación de Pearson entre VUT y percepción negativa.
- Comparación de rankings por distrito.
- Gráficos de dispersión y gráficos comparativos.
- Mapas territoriales de VUT y percepción negativa.


## 6. Resultados / Insights

El análisis muestra importantes diferencias territoriales en la distribución de las VUT y en la percepción del turismo entre los residentes de Málaga.

- **Fuerte concentración de VUT en Centro:** el distrito Centro registra 6.302 VUT, muy por encima del resto de distritos. Le siguen Carretera de Cádiz (1.191) y Este (1.058).

- **Churriana presenta la mayor percepción negativa:** alcanza un 39,47 %, a pesar de contar con únicamente 178 VUT. Esto indica que una elevada percepción negativa no coincide necesariamente con una alta concentración absoluta de viviendas turísticas.

- **La percepción negativa media entre los distritos es del 12,42 %.** Churriana, Centro, Carretera de Cádiz, Cruz de Humilladero y Bailén-Miraflores se sitúan por encima de esta media.

- **La relación entre VUT y percepción negativa es débil:** la correlación de Pearson obtenida es de **r = 0,224**, indicando una asociación positiva débil entre ambas variables.

- **El resultado se mantiene al considerar la densidad territorial de VUT:** al calcular las VUT por km², la correlación con la percepción negativa es de **r = 0,205**, manteniéndose como una asociación positiva débil. Esto refuerza la idea de que la concentración de VUT, tanto en términos absolutos como en relación con la superficie del distrito, no explica por sí sola las diferencias en la percepción de los residentes.

- **La hipótesis inicial no queda claramente respaldada:** los distritos con mayor número de VUT no presentan necesariamente una percepción más negativa del turismo.

- **El turismo internacional tiene un peso relevante en la actividad turística de Málaga:** durante todos los meses analizados de 2023, los viajeros y las pernoctaciones de residentes en el extranjero superan a los correspondientes a residentes en España.

### Insight principal

La concentración absoluta de viviendas de uso turístico, por sí sola, no parece explicar las diferencias en la percepción negativa del turismo entre los distritos de Málaga. Los resultados sugieren que pueden existir otros factores territoriales, sociales o relacionados con la intensidad turística que influyan en la percepción de los residentes.


## 7. Recomendaciones de negocio

A partir de los resultados obtenidos, se proponen las siguientes recomendaciones para apoyar una gestión turística más sostenible en Málaga:

- **No utilizar únicamente el número absoluto de VUT como indicador de presión turística.** La débil relación observada con la percepción negativa muestra que esta variable, por sí sola, no explica el nivel de rechazo al turismo entre los residentes.

- **Priorizar el análisis de los distritos con mayor percepción negativa**, especialmente Churriana, para identificar qué otros factores pueden estar influyendo en la valoración del turismo.

- **Complementar el análisis con indicadores relativos**, como VUT por habitante, por número de viviendas o por superficie, para comparar de forma más precisa distritos de diferente tamaño.

- **Incorporar otras variables territoriales y sociales**, como densidad de población, precios de la vivienda, intensidad turística, ruido, movilidad o concentración de alojamientos turísticos.

- **Realizar un seguimiento periódico por distrito** que permita detectar cambios en la presión turística y en la percepción de los residentes a lo largo del tiempo.

### Recomendación principal

La gestión turística no debería priorizar zonas únicamente por su número de VUT. Sería más adecuado combinar indicadores de presión turística con datos de percepción ciudadana para identificar los distritos que requieren mayor atención y estudiar las causas específicas de su percepción negativa antes de adoptar medidas.


## 8. Limitaciones

Este análisis presenta algunas limitaciones que deben tenerse en cuenta al interpretar los resultados:

- El análisis se realiza sobre los **11 distritos de Málaga**, por lo que la correlación obtenida debe interpretarse de forma descriptiva y exploratoria.

- El análisis incorpora tanto el número absoluto de VUT como su densidad por km². Sin embargo, no se dispone de indicadores normalizados por población o por número de viviendas, que podrían ofrecer una perspectiva adicional sobre la presión turística en cada distrito.

- Los datos de OpenRTA corresponden a establecimientos actualmente presentes en el registro cuya fecha de inscripción es igual o anterior al 31/12/2023. Por tanto, no representan necesariamente el stock histórico exacto de VUT existente en 2023.

- Algunos registros de VUT no pudieron utilizarse en el análisis geográfico debido a coordenadas ausentes o localizaciones que no correspondían correctamente con los límites de los distritos.

- La correlación entre VUT y percepción negativa muestra una asociación estadística, pero **no permite establecer causalidad**.

- La percepción de los residentes puede estar influida por otras variables sociales, económicas o territoriales que no se incluyen en este análisis.


## 9. Próximos pasos

Como continuación del proyecto, se podrían incorporar nuevas variables y ampliar el periodo de análisis para comprender mejor los factores asociados con la percepción del turismo en Málaga.

Algunas posibles líneas de trabajo serían:

- Calcular nuevos indicadores relativos, especialmente **VUT por cada 1.000 habitantes** o VUT por número de viviendas, para complementar el indicador de **VUT por km²** ya analizado.
- Incorporar variables como población, precios del alquiler y de la vivienda, densidad urbana, ruido o movilidad.
- Analizar otras formas de alojamiento turístico, además de las viviendas de uso turístico.
- Ampliar el análisis a varios años para estudiar la evolución de la presión turística y de la percepción de los residentes.
- Trabajar con unidades geográficas más pequeñas que los distritos, como barrios, si se dispone de datos suficientemente detallados.
- Desarrollar un dashboard interactivo que permita comparar los principales indicadores turísticos por distrito.


## 10. Cómo replicar el proyecto 

El proyecto se ha desarrollado utilizando **Python, Jupyter Notebook y MySQL**.

### Estructura del proyecto

data-wrangling-project/
│
├── proyecto_turismo_malaga.ipynb
├── cleaning.py
├── proyecto_turismo_malaga_sql.sql
└── README.md