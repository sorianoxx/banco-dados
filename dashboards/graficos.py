import polars as pl
import mysql.connector


conn = mysql.connector.connect(
    host="127.0.0.1",
    user="root",
    password="bizugao123",
    database="comex"
)


query = """
SELECT 
    t.id AS transacao_id,
    t.tipo_id,
    t.pais_origem,
    t.pais_destino,
    t.produto_id,
    t.valor_monetario,
    t.quantidade,
    t.transporte_id,
    t.cambio_id,
    c.data AS data_cambio,
    c.moeda_origem,
    c.moeda_destino
FROM transacoes t
JOIN cambios c ON t.cambio_id = c.id;
"""


import pandas as pd  
cursor = conn.cursor()
cursor.execute(query)
columns = [desc[0] for desc in cursor.description]
rows = cursor.fetchall()
cursor.close()
conn.close()


df = pl.DataFrame(data=rows, schema=columns)
