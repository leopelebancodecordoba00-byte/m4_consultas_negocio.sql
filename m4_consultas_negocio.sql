-- Entregable 4
-- Pre-entrega: Consultas SQL de negocio

-- Extrayendo métricas clave con SQL

USE Ventas_Tech_DB;

-- CONSULTA UNO

SELECT
	MONTH(fecha_venta) AS mes,
	SUM(cantidad * precio_unitario) AS total_facturado,
	COUNT (*) AS Total_pedidos,
	AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- CONSULTA DOS

SELECT TOP 5
	id_producto,
	SUM(cantidad) AS unidades_vendidas,
	SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;

-- CONSULTA TRES

SELECT
	id_cliente,
	count(*) AS cantidad_pedidos,
	SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT (*) > 1
ORDER BY total_gastado desc;

-- CONSULTA CUATRO

SELECT
    mes,
    total_facturado,
    CASE
        WHEN total_facturado > (
            SELECT AVG(total_mes)
            FROM (
                SELECT SUM(cantidad * precio_unitario) AS total_mes
                FROM ventas
                GROUP BY MONTH(fecha_venta)
            ) AS promedios
        )
            THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_promedio
FROM (
    SELECT
        MONTH(fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY MONTH(fecha_venta)
) AS totales_mensuales
ORDER BY mes;

-- EL PRODUCTO 2 ES EL MAS VENDIDO, REPRESENTA EL 44,83% DEL TOTAL DE LAS UNIDADES VENDIDAS.
-- TODOS LOS CLIENTES REALIZARON 2 COMPRAS EN EL MES.
-- EL CLIENTE 1 CONCENTRA EL 40,97% DE LA FACTURACION DEL MES 03.
-- EL PRODUCTO 1 CONCENTRA EL 55,87% DE LA FACTURACION DEL MES 03.
