
SELECT CONCAT(YEAR(f1.fact_fecha), '') AS 'Periodo', SUM(f1.fact_total) AS 'Ventas totales',

(SELECT COUNT(DISTINCT prod_rubro) FROM Item_Factura
JOIN Producto ON prod_codigo = item_producto
JOIN Factura f2 ON f2.fact_numero = item_numero AND f2.fact_sucursal = item_sucursal AND f2.fact_tipo = item_tipo
WHERE YEAR(F2.fact_fecha) = YEAR(f1.fact_fecha)) AS 'Cant rubros',
/*
Hace un subselect para contar los prod_rubro distintos que se vendieron en el mismo año que la consulta
Esto se hace haciendo que f2 sea igual al año de f1 que es el general
*/
(SELECT COUNT(DISTINCT prod_codigo) FROM Item_Factura 
JOIN Producto ON prod_codigo = item_producto
JOIN Composicion ON comp_producto = prod_codigo
JOIN Factura f2 ON f2.fact_numero = item_numero AND f2.fact_sucursal = item_sucursal AND f2.fact_tipo = item_tipo
WHERE YEAR(F2.fact_fecha) = YEAR(f1.fact_fecha)) AS 'Cant productos compuestos',
/*Este subselect cuenta los productos distintos que son componentes (en la tabla componentes figura su cod como
comp_producto  y repite que sea el mismo año */
COUNT(f1.fact_cliente) AS 'Clientes del año'
FROM Factura f1
GROUP BY YEAR(f1.fact_fecha)

