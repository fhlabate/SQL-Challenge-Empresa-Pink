#1.¿Cuál fue la cantidad total vendida de todos los productos?
SELECT SUM(qty) AS CantidadTotalVendida
FROM ventas;

#2.¿Cuál es el ingreso total generado por todos los productos antes de los descuentos?
SELECT SUM(precio*qty) AS TotalGenerado_$
FROM ventas;

#3.¿Cuál es el ingreso promedio generado por todos los productos antes de los descuentos?
SELECT ROUND(AVG(precio*qty),2) AS IngresoPromedio_$
FROM ventas;

#4.¿Cuál es el ingreso total generado por cada producto antes de los descuentos? Mostrar el nombre del producto y el ingreso, ordenar de mayor a menor por ingreso total
SELECT pd.id_producto AS idProducto, pd.nombre_producto AS Producto, SUM(v.precio*v.qty) AS IngresoTotalGenerado
FROM ventas v
JOIN producto_detalle pd
ON v.id_producto = pd.id_producto
GROUP BY pd.id_producto, pd.nombre_producto
ORDER BY IngresoTotalGenerado DESC;

#5.¿Cuál es el porcentaje total de descuento (sobre el ingreso total) para todos los productos?
SELECT ROUND(SUM(descuento)*100/SUM(qty*precio),2) AS Porcent
FROM ventas;

#6.¿Cuál es el porcentaje total de descuento (sobre el ingreso total) por cada producto?
SELECT * 
FROM ventas;
#7.¿Cuántas transacciones únicas hubo?
SELECT COUNT(DISTINCT id_txn) AS TransaccionesUnicas 
FROM ventas;

#8.¿Cuáles son las ventas totales brutas de cada transacción?
SELECT id_txn AS NumTransaccion, SUM(qty*precio) AS TotalBruto_$
FROM ventas
GROUP BY id_txn;

#9.¿Qué cantidad de productos totales se compran en cada transacción?
SELECT id_txn AS NumTransaccion, SUM(qty) AS CantidadProductos
FROM ventas
GROUP BY id_txn;

#10.¿Cuál es el valor de descuento promedio por transacción?
SELECT id_txn AS NumTransaccion, round(avg(descuento),0) AS DescuentoPromedio
FROM ventas
GROUP BY id_txn;

#11.¿Cuál es el ingreso promedio neto por transacción para miembros “t”?
SELECT id_txn, ROUND(AVG(qty*precio-descuento),2) AS IngresoPromedioNeto_$
FROM ventas
WHERE miembro = "t"
GROUP BY id_txn;

#12.¿Cuáles son los 3 productos mas vendidos en función a los ingresos totales?
SELECT v.id_producto AS IdProducto, pd.nombre_producto AS NombreProducto, SUM(v.qty*v.precio) AS TotalVendido_$ 
FROM ventas v
JOIN producto_detalle pd
ON v.id_producto = pd.id_producto
GROUP BY v.id_producto, pd.nombre_producto
ORDER BY TotalVendido_$ DESC
LIMIT 3;

#13. ¿Cuál es la cantidad total vendida, los ingresos brutos y el descuento de cada segmento de producto?
SELECT id_segmento, SUM(v.qty) AS CantidadTotalVendida, SUM(v.qty*v.precio) AS IngresosBrutos_$, SUM(v.descuento) AS Descuento_$
FROM ventas v
JOIN producto_detalle pd
ON v.id_producto = pd.id_producto
GROUP BY id_segmento;