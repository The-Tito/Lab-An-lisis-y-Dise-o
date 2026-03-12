-- ============================================================
-- STORED PROCEDURES
-- ============================================================

-- ============================================================
-- PRCESAR PEDIDO
-- Este procedure se encarga de validad al procesar un pedido,
-- verifica que el stock sea suficiente y asi mismo realiza
-- el registro dentro de la venta.
-- ============================================================

CREATE OR REPLACE PROCEDURE sp_procesar_pedido (
    IN p_items JSONB,             
    IN p_empleado_id INT,         
    INOUT p_total NUMERIC         
)
LANGUAGE plpgsql AS $$ 
DECLARE 
    item RECORD;
    req RECORD;
BEGIN
    p_total := 0;

    FOR req IN 
        SELECT 
            i.id AS ingredient_id, 
            i.name AS ingredient_name, 
            i.stock AS stock_actual,
            SUM(iid.quantity * x.portions) AS cantidad_requerida
        FROM jsonb_to_recordset(p_items) AS x(saurce_id INT, portions INT)
        JOIN ingredients_in_dish iid ON iid.saurce_id = x.saurce_id
        JOIN ingredients i ON i.id = iid.ingredients_id
        GROUP BY i.id, i.name, i.stock
        ORDER BY i.id 
        FOR UPDATE OF i 
    LOOP
        IF req.stock_actual < req.cantidad_requerida THEN
            RAISE EXCEPTION 'Stock insuficiente de %. Requerido: %, Actual: %', 
                            req.ingredient_name, req.cantidad_requerida, req.stock_actual;
        END IF;

        UPDATE ingredients 
        SET stock = stock - CAST(req.cantidad_requerida AS INTEGER)
        WHERE id = req.ingredient_id;
    END LOOP;

    FOR item IN 
        SELECT x.saurce_id, x.portions, s.price 
        FROM jsonb_to_recordset(p_items) AS x(saurce_id INT, portions INT)
        JOIN saucer s ON s.id = x.saurce_id
    LOOP
        p_total := p_total + (item.price * item.portions);
        
        INSERT INTO sales_record (saurce_id, portions, employees_id)
        VALUES (item.saurce_id, item.portions, p_empleado_id);
    END LOOP;
END;
$$;