
-- ============================================================
-- VIEWS
-- ============================================================

-- ============================================================
-- PLATILLOS QUE SE PUEDEN PREPARAR
-- Este reporte calcula todos los platillos que son posibles a
-- preparar.
-- ============================================================
CREATE OR REPLACE VIEW vw_dishes_can_prepared AS
SELECT 
    s.name AS platillo,
    -- Calculamos cuántas veces cabe la cantidad de la receta en el stock actual.
    -- FLOOR redondea hacia abajo.
    FLOOR(MIN(i.stock / iid.quantity)) AS porciones_disponibles
FROM saucer s
JOIN ingredients_in_dish iid ON s.id = iid.saurce_id
JOIN ingredients i ON iid.ingredients_id = i.id
GROUP BY s.id, s.name
-- Solo mostramos los platillos de los que podemos preparar al menos 1 porción
HAVING FLOOR(MIN(i.stock / iid.quantity)) > 0
ORDER BY porciones_disponibles DESC;


-- ============================================================
-- PLATILLOS CON MAS VENTAS
-- Este reporte obtiene todos los platillos y los ordena para 
-- visualizar cual fue el que tuvo mas ventas.
-- ============================================================

CREATE OR REPLACE VIEW vw_bestsellers AS
SELECT
    s.id AS platillo_id,
    s.name AS platillo,
    SUM(sr.portions) AS porciones_vendidas,
    SUM(sr.portions * s.price) AS ventas_total 
FROM saucer s
JOIN sales_record sr ON sr.saurce_id = s.id 
GROUP BY s.id, s.name
HAVING SUM(sr.portions) >= 1
ORDER BY porciones_vendidas DESC; 