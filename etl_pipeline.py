import apache_beam as beam
from apache_beam.options.pipeline_options import PipelineOptions
import requests
from datetime import datetime
import sqlalchemy
import json
import os
from dotenv import load_dotenv

load_dotenv()

class TransactionTransform(beam.DoFn):
    def process(self, element):
        date = element['data']
        from_currency = element['moeda_origem']
        
        try:
            response = requests.get(
                f'https://api.frankfurter.app/{date}?from={from_currency}&to={to_currency}'
            )
            rate = response.json()['rates'][to_currency]
        except:
            
        date_obj = datetime.strptime(element['data'], '%Y-%m-%d')
        formatted_date = date_obj.strftime('%Y%m%d')
        
        element['pais_origem'] = element['pais_origem'].upper()
        element['pais_destino'] = element['pais_destino'].upper()
        element['descricao_produto'] = element['descricao_produto'].upper()
        
        valor_usd = float(element['valor_monetario']) * rate
        
        return [{
            'SK_Tempo': formatted_date,
            'SK_PaisOrigem': element['pais_origem_id'],
            'SK_PaisDestino': element['pais_destino_id'],
            'SK_Produto': element['produto_id'],
            'SK_Transporte': element['transporte_id'],
            'SK_MoedaOrigem': element['moeda_origem_id'],
            'SK_MoedaDestino': element['moeda_destino_id'],
            'SK_TipoTransacao': element['tipo_id'],
            'ValorMonetarioOriginal': element['valor_monetario'],
            'ValorMonetarioUSD': valor_usd,
            'Quantidade': element['quantidade'],
            'TaxaCambio': rate
        }]

def get_db_url():
    return f"mysql+mysqlconnector://{os.getenv('DB_USER')}:{os.getenv('DB_PASSWORD')}@{os.getenv('DB_HOST')}:{os.getenv('DB_PORT')}/{os.getenv('DB_NAME')}"

def run_pipeline():
    db_url = get_db_url()
    
    options = PipelineOptions()
    
    with beam.Pipeline(options=options) as p:
        transactions = p | 'ReadTransactions' >> beam.io.ReadFromSQL(
            db_url,
            query='SELECT * FROM transacoes'
        )
        
        transformed = (
            transactions 
            | 'TransformData' >> beam.ParDo(TransactionTransform())
        )
        
        transformed | 'WriteToFactTable' >> beam.io.WriteToDB(
            db_url,
            table_name='FactTransacoes',
            create_table=False
        )

if __name__ == '__main__':
    run_pipeline() 