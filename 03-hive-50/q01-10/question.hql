-- 
-- Pregunta
-- ===========================================================================
--
-- Para resolver esta pregunta use el archivo `data.tsv`.
--
-- Compute la cantidad de registros por cada letra de la columna 1.
-- Escriba el resultado ordenado por letra. 
--
-- Escriba el resultado a la carpeta `output` de directorio de trabajo.
--
-- >>> Escriba su respuesta a partir de este punto <<<
!hdfs dfs -rm -r -f /tmp/ejercicio1;
!hdfs dfs -mkdir /tmp/ejercicio1;
!hdfs dfs -copyFromLocal data.tsv  /tmp/ejercicio1/data.tsv;
DROP TABLE IF EXISTS tabla;

CREATE TABLE tabla (columna1       STRING,
                           columna2        STRING,
                           columna3      STRING)

ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
TBLPROPERTIES ("skip.header.line.count"="0");

LOAD DATA INPATH '/tmp/ejercicio1/data.tsv' OVERWRITE
INTO TABLE tabla;

INSERT OVERWRITE DIRECTORY '/tmp/output'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','

SELECT 
columna1,
count(columna1)
    FROM tabla
group by 
    columna1
;


!hadoop fs -copyToLocal /tmp/output output;
