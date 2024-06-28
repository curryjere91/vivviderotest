Documentación del Pipeline y Mantenimiento

Carga y Transformación de Datos:

Los datos del CSV se cargan en un DataFrame de Pandas para su manipulación y transformación.

Conexión a la Base de Datos:

Se utiliza psycopg para establecer la conexión con PostgreSQL. Es importante manejar las credenciales de forma segura, por ejemplo, utilizando variables de entorno. En este caso esta hecho de forma cruda, pero idealmente la contraseña debería ser un input del usuario, y el resto de los datos estar en un archivo aparte.

Creación de la Tabla:

La tabla SalesTransactions se crea si no existe, asegurando que la estructura de la tabla esté en línea con los datos a insertar.

Inserción de Datos:

Se insertan los datos en la tabla y se manejan los conflictos para evitar duplicados para asegurar la integridad de los datos.

Consulta y Presentación de Datos:

Se ejecuta una consulta SQL para obtener información agregada de las ventas, agrupadas por categoría de producto y región.

Mantenimiento:

Se monitorea la estructura del CSV y la tabla de base de datos, ya que cualquier cambio en el CSV debe reflejarse en la transformación y mapeo de columnas en el DataFrame.
La tabla debe monitorearse para asegurar que no se acumulen datos duplicados y que la estructura siga siendo adecuada para las necesidades de consulta.
Este pipeline se podría automatizar utilizando scripts y herramientas de programación, permitiendo una carga y actualización periódica de los datos de ventas en la base de datos PostgreSQL.


Hay 3 posibles optimizaciones en la consulta a optimizar, que van a depender del tipo de configuración de PostgreSQL, para saber cual es la mejor deberia correrse con EXPLAIN, para asegurar que se use la que tenga el mejor rendimiento.
