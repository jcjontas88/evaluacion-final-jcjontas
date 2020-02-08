-- 
-- Pregunta
-- ===========================================================================
--
-- Para resolver esta pregunta use el archivo `data.tsv`.
--
-- Construya una consulta que ordene la tabla por letra y valor (3ra columna).
--
-- Escriba el resultado a la carpeta `output` de directorio de trabajo.
--
-- >>> Escriba su respuesta a partir de este punto <<<
!hdfs dfs -rm -r -f /tmp/ejercicio;
!hdfs dfs -rm -r -f /tmp/output;
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

SELECT 
columna1,
columna2,
columna3
    FROM tabla
ORDER BY columna1,columna3 ASC;


!hadoop fs -copyToLocal /tmp/output output;
