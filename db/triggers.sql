
-- ============================================================
-- TRIGGERS
-- ============================================================

-- ============================================================
-- TRIGGER DE ALERTA DE STOCK BAJO
-- Este es el trigger encargado de al crear las alertas cuando
-- el stock de un platillo sea menor al 20%
-- ============================================================

CREATE OR REPLACE FUNCTION fn_revisar_alerta_stock()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.stock < OLD.stock AND NEW.stock <= (NEW.initial_stock * 0.20) THEN
        IF NOT EXISTS (
            SELECT 1 FROM notifications 
            WHERE ingredient_id = NEW.id AND DATE(created_at) = CURRENT_DATE
        ) THEN
            INSERT INTO notifications (ingredient_id, message)
            VALUES (NEW.id, 'Alerta Automática: Quedan ' || NEW.stock || ' unidades de ' || 
                    NEW.name || ' (menos del 20%).');
        END IF;
    END IF;
    RETURN NEW;
END;
$$;

CREATE TRIGGER trg_alerta_stock_bajo
AFTER UPDATE OF stock ON ingredients
FOR EACH ROW
EXECUTE FUNCTION fn_revisar_alerta_stock();