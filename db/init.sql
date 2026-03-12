
-- ============================================================
-- TABLAS DE INGREDIENTES
-- Contiene todos los ingredientes existentes y sus cantidades actuales.
-- ============================================================

CREATE TABLE IF NOT EXISTS ingredients(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    initial_stock INTEGER NOT NULL DEFAULT 0 CHECK (initial_stock >= 0),
    stock INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),
    active BOOLEAN DEFAULT TRUE,
);

-- ============================================================
-- TABLAS DE PLATILLOS
-- Contiene los 15 platillos existentes.
-- ============================================================

CREATE TABLE IF NOT EXISTS saucer(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    price DECIMAL(12, 2) NOT NULL DEFAULT 0 CHECK (price >= 0),
); 

-- ============================================================
-- TABLAS DE INGREDIENTES POR PLATILLO
-- Hace la relacione entre el platillo y sus ingredientes, 
-- teniendo en cuenta sus porciones
-- ============================================================

CREATE TABLE IF NOT EXISTS ingredients_in_dish(
    id SERIAL PRIMARY KEY,
    saurce_id INTEGER NOT NULL REFERENCES saucer(id),
    ingredients_id INTEGER NOT NULL REFERENCES ingredients(id),
    quantity DECIMAL(12, 2) NOT NULL DEFAULT 0 CHECK (quantity >= 0),
);

-- ============================================================
-- TABLAS DE EMPLEADOS
-- Contiene todos los empleados, los cuales pueden antender.
-- ============================================================

CREATE TABLE IF NOT EXISTS employees(
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
);

-- ============================================================
-- TABLAS DE REGISTRO DE VENTAS
-- Contiene todos los registro de las ventas realizadas y quien
-- atendio.
-- ============================================================

CREATE TABLE IF NOT EXISTS sales_record(
    id SERIAL PRIMARY KEY,
    saurce_id INTEGER NOT NULL REFERENCES saucer(id),
    portions INTEGER NOT NULL DEFAULT 0 CHECK (portions >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    employees_id INTEGER NOT NULL REFERENCES employees(id),
); 

-- ============================================================
-- TABLAS DE REGISTRO DE NOTIFICACIONES
-- Realizara el registro de las alertas de stock bajo.
-- ============================================================

CREATE TABLE IF NOT EXISTS notifications(
    id SERIAL PRIMARY KEY,
    ingredient_id INTEGER REFERENCES ingredients(id),
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ============================================================
-- Funciones
-- ============================================================
