-- Pregunta 3: ¿Hay diferencia entre superficie sembrada y cosechada por cultivo y campaña?
-- Proxy de perdida: superficie perdida = sembrada - cosechada
-- Incluye porcentaje de pérdida para comparación histórica entre cultivos

SELECT 
    cu.nombre_cultivo,
    ca.nombre_campana,
    ca.anio_fin,
    ROUND(SUM(e.sup_sembrada), 0) AS total_sembrada_ha,
    ROUND(SUM(e.sup_cosechada), 0) AS total_cosechada_ha,
    ROUND(SUM(e.sup_sembrada) - SUM(e.sup_cosechada), 0) AS superficie_perdida_ha,
    ROUND((SUM(e.sup_sembrada) - SUM(e.sup_cosechada)) / NULLIF(SUM(e.sup_sembrada), 0) * 100, 1) AS pct_perdida
FROM estimaciones e
JOIN cultivos cu ON e.idcultivo = cu.idcultivo
JOIN campanas ca ON e.idcampana = ca.idcampana
WHERE e.sup_sembrada IS NOT NULL AND e.sup_cosechada IS NOT NULL
GROUP BY cu.nombre_cultivo, ca.nombre_campana, ca.anio_fin
ORDER BY cu.nombre_cultivo, ca.anio_fin;