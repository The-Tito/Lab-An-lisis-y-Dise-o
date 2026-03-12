SELECT 
    s.name AS platillo,
    -- Calculamos cuántas veces cabe la cantidad de la receta en el stock actual.
    -- FLOOR redondea hacia abajo, porque no puedes vender "media" porción si te falta un ingrediente.
    FLOOR(MIN(i.stock / iid.quantity)) AS porciones_disponibles
FROM saucer s
JOIN ingredients_in_dish iid ON s.id = iid.saurce_id
JOIN ingredients i ON iid.ingredients_id = i.id
GROUP BY s.id, s.name
-- Solo mostramos los platillos de los que podemos preparar al menos 1 porción
HAVING FLOOR(MIN(i.stock / iid.quantity)) > 0
ORDER BY porciones_disponibles DESC;