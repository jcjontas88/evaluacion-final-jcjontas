-- 
-- Pregunta
-- ===========================================================================
--
-- Para resolver esta pregunta use el archivo `data.tsv`.
--
-- Escriba una consulta que devuelva los cinco valores diferentes más pequeños 
-- de la tercera columna.
--
-- Escriba el resultado a la carpeta `output` de directorio de trabajo.
--
-- >>> Escriba su respuesta a partir de este punto <<<
!hdfs dfs -rm -r -f /tmp/ejercicio;
!hdfs dfs -mkdir /tmp/ejercicio;
!hdfs dfs -copyFromLocal data.tsv  /tmp/ejercicio/data.tsv;
DROP TABLE IF EXISTS tabla;

CREATE TABLE tabla (columna1       STRING,
                    columna2        STRING,
                    columna3      INT)

ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
TBLPROPERTIES ("skip.header.line.count"="0");

LOAD DATA INPATH '/tmp/ejercicio/data.tsv' OVERWRITE
INTO TABLE tabla;

INSERT OVERWRITE DIRECTORY '/tmp/output'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','

SELECT DISTINCT 
columna3
    FROM tabla
ORDER BY columna3 ASC
LIMIT 5;


!hadoop fs -copyToLocal /tmp/output output;
