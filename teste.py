import mysql.connector
import polars as pl

conn = mysql.connector.connect(
    host="127.0.0.1:3306",
    user="root",
    password="bizugao123",
    database="comex"
)

query = "SELECT * FROM transacoes JOIN outros_itens ..."
df = pl.read_database(query, conn)
