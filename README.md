# Agro Argentina Analysis

Análisis de rendimientos y superficies de cultivos agrícolas en Argentina a partir de datos históricos sobre Información Agropecuaria del Ministerio de Agricultura, Ganadería y Pesca de la Nación.

## Objetivo

Explorar la evolución productiva del agro argentino desde 1969/70 hasta la actualidad, identificando tendencias de rendimiento por provincia, cultivos más competitivos y patrones de perdidas histórica.

## Dataset

- **Fuente:** https://datosestimaciones.magyp.gob.ar/reportes.php?reporte=Estimaciones
- **Cultivos:** Soja, Maíz, Trigo, Girasol, Maní
- **Período:** Campañas 1969/70 a 2024/25
- **Granularidad:** Por provincia y campaña agrícola
- **Variables:** Superficie sembrada (ha), superficie cosechada (ha), producción (tn), rendimiento (kg/ha)

## Modelo de datos

Base de datos SQLite con 4 tablas relacionales:

```
campanas     (idcampana, nombre_campana, anio_inicio, anio_fin)
cultivos     (idcultivo, nombre_cultivo)
provincias   (idprovincia, nombre_provincia)
estimaciones (idcultivo, idprovincia, idcampana, sup_sembrada, sup_cosechada, produccion, rendimiento)
```

## Preguntas analíticas

### 1. ¿Qué cultivo tuvo mayor crecimiento de rendimiento en los últimos 20 años por provincia?

Compara el rendimiento promedio al inicio y al final del período reciente para identificar qué cultivo mejoró más en cada provincia.

**Hallazgos destacados:**
- Maíz lidera el crecimiento en varias provincias (Corrientes +127%, La Pampa +61%, Misiones +379%)
- Trigo muestra crecimiento sólido en Buenos Aires (+29%), Córdoba (+26%) y San Luis (+39%)
- Casos negativos en Tucumán (Trigo -7%) y Catamarca (Soja -13%), señalando reconversión productiva

→ [`Query_1.sql`](Query_1.sql)

### 2. ¿Qué provincias son consistentemente más productivas para soja y maíz?

Ranking histórico de rendimiento promedio por provincia, filtrado a provincias con presencia sostenida (mínimo 10 campañas).

**Hallazgos destacados:**
- **Maíz:** Santa Fe (5.684 kg/ha), Buenos Aires (5.620 kg/ha) y Córdoba (4.939 kg/ha) lideran rendimiento histórico
- **Soja:** Santa Fe (2.501 kg/ha), Córdoba (2.312 kg/ha) y Buenos Aires (2.260 kg/ha) concentran volumen y rendimiento
- La región pampeana mantiene ventaja estructural en ambos cultivos

→ [`Query_2.sql`](Query_1.sql)

### 3. ¿Hay diferencia entre superficie sembrada y cosechada por cultivo y campaña?

Medida de perdida agrícola: la brecha entre lo sembrado y lo cosechado refleja pérdidas por factores climáticos, plagas u otros eventos.

**Hallazgos destacados:**
- Maíz registra las mayores pérdidas absolutas, con picos en campañas 1971/72 (29%) y 1988/89 (37%)
- Soja muestra baja siniestralidad en general (<5%), con excepción de 1988/89 (15%) y 2022/23 (10%)
- Maní tiene siniestralidad muy baja en los últimos 15 años (<3%), con mejora sostenida

→ [`Query_3.sql`](Query_3.sql)

## Stack tecnológico

- **Base de datos:** SQLite
- **Análisis:** SQL (window functions, CTEs, aggregations)
- **Visualización:** Power BI *(en desarrollo)*

## Estructura del repositorio

```
agro-argentina-analysis/
├── README.md
├── queries/
│   ├── Query_1.sql
│   ├── Query_2.sql
│   └── Query_3.sql
└── agro_argentina.db          # base de datos SQLite
```

## Autor

**Ernesto Javier Campilongo Mancilla**  
Biólogo | Data Scientist | PhD en Ciencias Biológicas (CONICET-INTA)  
[GitHub](https://github.com/Havilongo) · [LinkedIn](https://www.linkedin.com/in/)
