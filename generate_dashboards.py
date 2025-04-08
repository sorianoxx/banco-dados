import matplotlib.pyplot as plt
import seaborn as sns
import plotly.express as px
import plotly.graph_objects as go
import sqlalchemy
import polars as pl
import mysql.connector
import os
from dotenv import load_dotenv

load_dotenv()

def connect_to_dw():
    conn = mysql.connector.connect(
        host=os.getenv('DB_HOST'),
        port=int(os.getenv('DB_PORT')),
        user=os.getenv('DB_USER'),
        password=os.getenv('DB_PASSWORD'),
        database=os.getenv('DB_NAME')
    )
    return conn

def export_countries_pareto(conn):
    """Gráfico de Pareto: Países com maior volume de exportação"""
    query = """
    SELECT p.NomePais, SUM(f.ValorMonetarioUSD) as total_valor
    FROM FactTransacoes f
    JOIN DimPais p ON f.SK_PaisOrigem = p.SK_Pais
    JOIN DimTipoTransacao t ON f.SK_TipoTransacao = t.SK_TipoTransacao
    WHERE t.Descricao = 'EXPORTACAO'
    GROUP BY p.NomePais
    ORDER BY total_valor DESC
    """
    df = pl.read_database(query=query, connection=conn)
    
    fig, ax = plt.subplots(figsize=(12, 6))
    bars = ax.bar(df['NomePais'].to_list(), df['total_valor'].to_list())
    
    cumsum = df['total_valor'].cumsum()
    total = df['total_valor'].sum()
    cumperc = (cumsum / total * 100).to_list()
    
    ax2 = ax.twinx()
    ax2.plot(range(len(df)), cumperc, color='red', marker='o')
    
    plt.title('Pareto: Países com Maior Volume de Exportação')
    plt.savefig('pareto_exportacao.png')
    plt.close()

def export_product_distribution(conn):
    """Gráfico de Barras: Produtos mais comercializados"""
    query = """
    SELECT p.Descricao, SUM(f.Quantidade) as total_quantidade
    FROM FactTransacoes f
    JOIN DimProduto p ON f.SK_Produto = p.SK_Produto
    GROUP BY p.Descricao
    ORDER BY total_quantidade DESC
    LIMIT 10
    """
    df = pl.read_database(query=query, connection=conn)
    
    fig = px.bar(df.to_pandas(), x='Descricao', y='total_quantidade',
                 title='Top 10 Produtos Mais Comercializados')
    fig.write_html('produtos_comercializados.html')

def export_economic_blocks_evolution(conn):
    """Gráfico de Área Empilhada: Evolução por bloco econômico"""
    query = """
    SELECT 
        t.Ano,
        p.NomeBlocoEconomico,
        SUM(f.ValorMonetarioUSD) as total_valor
    FROM FactTransacoes f
    JOIN DimTempo t ON f.SK_Tempo = t.SK_Tempo
    JOIN DimPais p ON f.SK_PaisOrigem = p.SK_Pais
    GROUP BY t.Ano, p.NomeBlocoEconomico
    ORDER BY t.Ano
    """
    df = pl.read_database(query=query, connection=conn)
    
    df_pivot = df.pivot(
        values="total_valor",
        index="Ano",
        columns="NomeBlocoEconomico"
    )
    
    plt.figure(figsize=(12, 6))
    plt.stackplot(df_pivot['Ano'].to_list(), 
                 [df_pivot[col].to_list() for col in df_pivot.columns if col != 'Ano'])
    plt.title('Evolução do Comércio por Bloco Econômico')
    plt.legend([col for col in df_pivot.columns if col != 'Ano'])
    plt.savefig('evolucao_blocos.png')
    plt.close()

def export_trade_flow_sankey(conn):
    """Gráfico de Sankey: Fluxos de importação/exportação"""
    query = """
    SELECT 
        p1.NomePais as origem,
        p2.NomePais as destino,
        SUM(f.ValorMonetarioUSD) as valor
    FROM FactTransacoes f
    JOIN DimPais p1 ON f.SK_PaisOrigem = p1.SK_Pais
    JOIN DimPais p2 ON f.SK_PaisDestino = p2.SK_Pais
    GROUP BY p1.NomePais, p2.NomePais
    ORDER BY valor DESC
    LIMIT 20
    """
    df = pl.read_database(query=query, connection=conn)
    
    unique_countries = list(set(df['origem'].to_list() + df['destino'].to_list()))
    
    fig = go.Figure(data=[go.Sankey(
        node = dict(
            pad = 15,
            thickness = 20,
            line = dict(color = "black", width = 0.5),
            label = unique_countries,
        ),
        link = dict(
            source = [unique_countries.index(x) for x in df['origem'].to_list()],
            target = [unique_countries.index(x) for x in df['destino'].to_list()],
            value = df['valor'].to_list()
        )
    )])
    
    fig.write_html('fluxo_comercial.html')

def export_exchange_rate_impact(conn):
    """Gráfico de Linha: Variação cambial e volume de transações"""
    query = """
    SELECT 
        t.Data,
        AVG(f.TaxaCambio) as taxa_media,
        SUM(f.ValorMonetarioUSD) as volume_total
    FROM FactTransacoes f
    JOIN DimTempo t ON f.SK_Tempo = t.SK_Tempo
    GROUP BY t.Data
    ORDER BY t.Data
    """
    df = pl.read_database(query=query, connection=conn)
    
    fig, ax1 = plt.subplots(figsize=(12, 6))
    
    ax1.plot(df['Data'].to_list(), df['taxa_media'].to_list(), color='blue', label='Taxa de Câmbio')
    ax2 = ax1.twinx()
    ax2.plot(df['Data'].to_list(), df['volume_total'].to_list(), color='red', label='Volume de Transações')
    
    plt.title('Impacto da Variação Cambial no Volume de Transações')
    fig.legend()
    plt.savefig('impacto_cambial.png')
    plt.close()

def export_transport_distribution(conn):
    """Gráfico de Pizza: Distribuição dos meios de transporte"""
    query = """
    SELECT 
        t.Descricao,
        COUNT(*) as quantidade
    FROM FactTransacoes f
    JOIN DimTransporte t ON f.SK_Transporte = t.SK_Transporte
    GROUP BY t.Descricao
    """
    df = pl.read_database(query=query, connection=conn)
    
    plt.figure(figsize=(10, 10))
    plt.pie(df['quantidade'].to_list(), labels=df['Descricao'].to_list(), autopct='%1.1f%%')
    plt.title('Distribuição dos Meios de Transporte')
    plt.savefig('distribuicao_transporte.png')
    plt.close()

def main():
    conn = connect_to_dw()
    
    export_countries_pareto(conn)
    export_product_distribution(conn)
    export_economic_blocks_evolution(conn)
    export_trade_flow_sankey(conn)
    export_exchange_rate_impact(conn)
    export_transport_distribution(conn)
    
    conn.close()

if __name__ == '__main__':
    main() 