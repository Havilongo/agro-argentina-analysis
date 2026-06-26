-- Pregunta 2: ¿Qué provincias son más productivas para soja y maíz?
-- Calcula rendimiento promedio histórico y producción total por provincia y cultivo
-- Filtra provincias con al menos 10 campañas con datos para garantizar consistencia


SELECT 
    p.nombre_provincia,
    cu.nombre_cultivo,
    ROUND(AVG(e.rendimiento), 2) AS rend_promedio,
    ROUND(AVG(e.produccion), 0) AS prod_promedio_tn,
    COUNT(DISTINCT e.idcampana) AS campanas_con_datos
FROM estimaciones e
JOIN provincias p ON e.idprovincia = p.idprovincia
JOIN cultivos cu ON e.idcultivo = cu.idcultivo
JOIN campanas ca ON e.idcampana = ca.idcampana
WHERE cu.nombre_cultivo IN ('Soja', 'Maiz')
  AND e.rendimiento IS NOT NULL
GROUP BY p.nombre_provincia, cu.nombre_cultivo
HAVING campanas_con_datos >= 10
ORDER BY cu.nombre_cultivo, rend_promedio DESC;