-- Pregunta 1: ¿Qué cultivo tuvo mayor crecimiento de rendimiento en los últimos 20 años por provincia?
-- Compara el rendimiento promedio de las primeras campañas del período vs las últimas
-- Calcula crecimiento absoluto (kg/ha) y porcentual por provincia

WITH rend_por_anio AS (
    SELECT 
        p.nombre_provincia,
        cu.nombre_cultivo,
        ca.anio_fin,
        AVG(e.rendimiento) AS rend_promedio
    FROM estimaciones e
    JOIN provincias p ON e.idprovincia = p.idprovincia
    JOIN cultivos cu ON e.idcultivo = cu.idcultivo
    JOIN campanas ca ON e.idcampana = ca.idcampana
    WHERE ca.anio_fin >= (SELECT MAX(anio_fin) - 20 FROM campanas)
    GROUP BY p.nombre_provincia, cu.nombre_cultivo, ca.anio_fin
),
rend_inicial AS (
    SELECT nombre_provincia, nombre_cultivo, AVG(rend_promedio) AS rend_inicio
    FROM rend_por_anio
    WHERE anio_fin <= (SELECT MIN(anio_fin) + 3 FROM rend_por_anio)
    GROUP BY nombre_provincia, nombre_cultivo
),
rend_final AS (
    SELECT nombre_provincia, nombre_cultivo, AVG(rend_promedio) AS rend_fin
    FROM rend_por_anio
    WHERE anio_fin >= (SELECT MAX(anio_fin) - 3 FROM rend_por_anio)
    GROUP BY nombre_provincia, nombre_cultivo
),
crecimiento AS (
    SELECT 
        i.nombre_provincia,
        i.nombre_cultivo,
        ROUND(f.rend_fin - i.rend_inicio, 2) AS crecimiento_abs,
        ROUND((f.rend_fin - i.rend_inicio) / NULLIF(i.rend_inicio, 0) * 100, 1) AS crecimiento_pct,
        RANK() OVER (PARTITION BY i.nombre_provincia ORDER BY (f.rend_fin - i.rend_inicio) DESC) AS rk
    FROM rend_inicial i
    JOIN rend_final f ON i.nombre_provincia = f.nombre_provincia 
                      AND i.nombre_cultivo = f.nombre_cultivo
)
SELECT nombre_provincia, nombre_cultivo, crecimiento_abs, crecimiento_pct
FROM crecimiento
WHERE rk = 1
ORDER BY nombre_provincia;