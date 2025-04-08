import polars as pl
import mysql.connector


conn = mysql.connector.connect(
    host="127.0.0.1",
    user="root",
    password="bizugao123",
    database="comex"
)

# Query completa de extração
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

# Lendo os dados com Polars (via fetchall temporariamente)
import pandas as pd  # apenas para fetch, pois polars não lê direto via mysql.connector
cursor = conn.cursor()
cursor.execute(query)
columns = [desc[0] for desc in cursor.description]
rows = cursor.fetchall()
cursor.close()
conn.close()

# Convertendo para DataFrame Polars
df = pl.DataFrame(data=rows, schema=columns)
