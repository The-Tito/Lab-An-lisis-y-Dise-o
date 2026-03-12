-- ============================================================
-- 1. INGREDIENTES (Unidades en gramos, mililitros o piezas)
-- ============================================================
INSERT INTO ingredients (id, name, stock, initial_stock, active) VALUES
(1, 'Carne al Pastor (g)', 5000, 5000, true),
(2, 'Carne de Cochito (g)', 5000, 5000, true),
(3, 'Carne de Res (g)', 4000, 4000, true),
(4, 'Pollo desmenuzado (g)', 3000, 3000, true),
(5, 'Tortillas de Maíz (pz)', 1000, 1000, true),
(6, 'Tortillas de Harina (pz)', 300, 300, true),
(7, 'Pan Telera (pz)', 100, 100, true),
(8, 'Piña (g)', 1500, 1500, true),
(9, 'Cebolla (g)', 2000, 2000, true),
(10, 'Cilantro (g)', 500, 500, true),
(11, 'Quesillo / Queso Oaxaca (g)', 3000, 3000, true),
(12, 'Salsa Verde (ml)', 2000, 2000, true),
(13, 'Salsa Roja (ml)', 2000, 2000, true),
(14, 'Limones (pz)', 150, 150, true),
(15, 'Frijoles Refritos (g)', 2500, 2500, true),
(16, 'Crema (ml)', 1500, 1500, true),
(17, 'Lechuga (g)', 1000, 1000, true),
(18, 'Masa para Empanadas (g)', 4000, 4000, true),
(19, 'Aceite (ml)', 5000, 5000, true),
(20, 'Polvo de Tascalate (g)', 1000, 1000, true),
(21, 'Masa de Pozol (g)', 2000, 2000, true),
(22, 'Azúcar (g)', 2000, 2000, true),
(23, 'Agua Purificada (ml)', 20000, 20000, true),
(24, 'Salchicha (pz)', 100, 100, true),
(25, 'Tocino (g)', 1000, 1000, true),
(26, 'Pan para Hot Dog (pz)', 100, 100, true),
(27, 'Mayonesa (g)', 1000, 1000, true),
(28, 'Mostaza (g)', 500, 500, true)
ON CONFLICT (id) DO NOTHING;

-- Reiniciar la secuencia para futuros inserts
SELECT setval('ingredients_id_seq', 28, true);

-- ============================================================
-- 2. PLATILLOS (15 Platillos)
-- ============================================================
INSERT INTO saucer (id, name, price) VALUES
(1, 'Orden de Tacos al Pastor', 60.00),
(2, 'Orden de Tacos de Cochito', 65.00),
(3, 'Gringa al Pastor', 55.00),
(4, 'Torta de Cochito', 45.00),
(5, 'Empanadas de Quesillo (3pz)', 40.00),
(6, 'Empanadas de Pollo (3pz)', 45.00),
(7, 'Burrito de Res', 70.00),
(8, 'Quesadilla Sencilla', 25.00),
(9, 'Quesadilla con Carne', 45.00),
(10, 'Tostadas de Pollo (2pz)', 40.00),
(11, 'Hot Dog Especial', 35.00),
(12, 'Nachos con Carne al Pastor', 65.00),
(13, 'Agua de Tascalate (1L)', 30.00),
(14, 'Pozol Blanco (1L)', 25.00),
(15, 'Pozol de Cacao (1L)', 30.00)
ON CONFLICT (id) DO NOTHING;

SELECT setval('saucer_id_seq', 15, true);

-- ============================================================
-- 3. RECETAS (Ingredientes por platillo: 3 a 8 insumos)
-- ============================================================
INSERT INTO ingredients_in_dish (saurce_id, ingredients_id, quantity) VALUES
-- 1. Tacos al Pastor
(1, 1, 200), (1, 5, 4), (1, 8, 30), (1, 9, 20), (1, 10, 10), (1, 12, 30), (1, 14, 1),
-- 2. Tacos de Cochito
(2, 2, 200), (2, 5, 4), (2, 9, 30), (2, 12, 30), (2, 14, 1),
-- 3. Gringa al Pastor
(3, 1, 150), (3, 6, 2), (3, 11, 100), (3, 8, 20), (3, 9, 15), (3, 13, 30),
-- 4. Torta de Cochito
(4, 7, 1), (4, 2, 150), (4, 15, 50), (4, 17, 30), (4, 12, 30), (4, 27, 15),
-- 5. Empanadas de Quesillo
(5, 18, 150), (5, 11, 120), (5, 19, 50), (5, 16, 30), (5, 17, 30), (5, 12, 20),
-- 6. Empanadas de Pollo
(6, 18, 150), (6, 4, 120), (6, 19, 50), (6, 16, 30), (6, 17, 30), (6, 13, 20),
-- 7. Burrito de Res
(7, 6, 2), (7, 3, 200), (7, 15, 50), (7, 11, 50), (7, 17, 20), (7, 12, 30),
-- 8. Quesadilla Sencilla
(8, 6, 1), (8, 11, 80), (8, 12, 20),
-- 9. Quesadilla con Carne
(9, 6, 1), (9, 11, 60), (9, 3, 80), (9, 13, 20),
-- 10. Tostadas de Pollo (Asumiendo tortilla frita)
(10, 5, 2), (10, 19, 30), (10, 15, 40), (10, 4, 100), (10, 17, 30), (10, 16, 20), (10, 11, 20),
-- 11. Hot Dog Especial
(11, 26, 1), (11, 24, 1), (11, 25, 30), (11, 9, 20), (11, 27, 15), (11, 28, 10),
-- 12. Nachos con Pastor (Totopos hechos con tortilla)
(12, 5, 4), (12, 19, 50), (12, 11, 100), (12, 1, 150), (12, 15, 50), (12, 13, 30),
-- 13. Agua de Tascalate
(13, 20, 80), (13, 22, 50), (13, 23, 1000),
-- 14. Pozol Blanco
(14, 21, 150), (14, 23, 1000), (14, 22, 20),
-- 15. Pozol de Cacao (Asumimos masa mezclada con cacao)
(15, 21, 150), (15, 23, 1000), (15, 22, 40);

-- ============================================================
-- 4. EMPLEADOS
-- ============================================================
INSERT INTO employees (id, name, last_name) VALUES
(1, 'Carlos', 'Gómez'),
(2, 'María', 'López'),
(3, 'Jorge', 'Pérez')
ON CONFLICT (id) DO NOTHING;

SELECT setval('employees_id_seq', 3, true);

-- ============================================================
-- 5. REGISTRO DE VENTAS (Ventas iniciales para probar)
-- ============================================================
INSERT INTO sales_record (saurce_id, portions, employees_id, created_at) VALUES
(1, 2, 1, CURRENT_TIMESTAMP - INTERVAL '2 days'),
(2, 1, 2, CURRENT_TIMESTAMP - INTERVAL '2 days'),
(13, 3, 1, CURRENT_TIMESTAMP - INTERVAL '1 day'),
(3, 1, 3, CURRENT_TIMESTAMP - INTERVAL '5 hours'),
(5, 2, 2, CURRENT_TIMESTAMP - INTERVAL '1 hour');