# 🌮 Food Truck DB - Gestión de Inventario y Ventas

Este proyecto contiene la arquitectura de base de datos relacional (PostgreSQL) para el manejo de un Food Truck. El sistema está diseñado para gestionar ventas, calcular el consumo exacto de ingredientes basados en recetas dinámicas y prevenir errores de concurrencia en producción.

## ✨ Características Principales

- **Gestión de Recetas:** Relación N:M entre Platillos e Ingredientes. Cada venta descuenta automáticamente los gramos/piezas exactas del inventario.
- **Control de Concurrencia (Anti-Race Conditions):** Implementación de bloqueos a nivel de fila (`FOR UPDATE`) en los Procedimientos Almacenados para asegurar que el inventario no quede en números negativos si múltiples meseros cobran al mismo tiempo.
- **Alertas Automatizadas:** Uso de _Triggers_ para monitorear el inventario en tiempo real y generar notificaciones cuando un insumo cae por debajo del 20% de su capacidad inicial.
- **Procesamiento Transaccional:** Uso de `JSONB` para procesar pedidos completos de múltiples platillos en una sola llamada a la base de datos.

## 📂 Estructura de la Base de Datos

El sistema se compone de los siguientes elementos:

1. **Tablas Base:** `ingredients`, `saucer`, `ingredients_in_dish`, `employees`, `sales_record`, `notifications`.
2. **Funciones (`fn_max_porciones_disponibles`):** Para consultar disponibilidad antes de vender.
3. **Triggers (`trg_alerta_stock_bajo`):** Auditoría pasiva del inventario.
4. **Stored Procedures (`sp_procesar_pedido`):** Lógica central de negocio.
5. **Vistas (`vw_bestsellers`):** Reportes en tiempo real.

## 🚀 Instrucciones de Ejecución

Para evitar errores de dependencias, los scripts SQL deben ejecutarse estrictamente en el siguiente orden en tu cliente PostgreSQL:

1. Ejecutar el script de **Creación de Tablas** (DDL).
2. Ejecutar el **Seed** (Inserts iniciales de ingredientes, recetas y platillos).
3. Ejecutar la **Función** de lectura (`fn_max_porciones_disponibles`).
4. Ejecutar el **Trigger** de alertas y su función asociada.
5. Ejecutar los **Stored Procedures** de ventas.
6. Ejecutar la **Vista** de los más vendidos.

## 💻 Ejemplos de Uso (Backend)

**Procesar una venta desde la aplicación:**
Se envía un arreglo JSON con el ID del platillo y las porciones solicitadas, junto con el ID del empleado que atiende.

```sql
CALL sp_procesar_pedido(
    '[{"saurce_id": 1, "portions": 2}, {"saurce_id": 3, "portions": 1}]'::JSONB,
    1,
    0
);
```
