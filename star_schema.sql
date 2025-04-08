CREATE TABLE DimTempo (
    SK_Tempo INT PRIMARY KEY,
    Data DATE,
    Ano INT,
    Mes INT,
    Dia INT,
    DiaSemana INT,
    NomeMes VARCHAR(20),
    Trimestre INT,
    Semestre INT
) ENGINE=InnoDB;

CREATE TABLE DimPais (
    SK_Pais INT PRIMARY KEY,
    NomePais VARCHAR(100),
    BlocoEconomicoID INT,
    NomeBlocoEconomico VARCHAR(100)
) ENGINE=InnoDB;

CREATE TABLE DimProduto (
    SK_Produto INT PRIMARY KEY,
    Descricao VARCHAR(200),
    CodigoNCM VARCHAR(50),
    CategoriaID INT,
    NomeCategoria VARCHAR(100)
) ENGINE=InnoDB;

CREATE TABLE DimTransporte (
    SK_Transporte INT PRIMARY KEY,
    Descricao VARCHAR(100)
) ENGINE=InnoDB;

CREATE TABLE DimMoeda (
    SK_Moeda INT PRIMARY KEY,
    Descricao VARCHAR(50),
    Pais VARCHAR(100)
) ENGINE=InnoDB;

CREATE TABLE DimTipoTransacao (
    SK_TipoTransacao INT PRIMARY KEY,
    Descricao VARCHAR(50)
) ENGINE=InnoDB;

CREATE TABLE FactTransacoes (
    SK_Transacao INT PRIMARY KEY,
    SK_Tempo INT,
    SK_PaisOrigem INT,
    SK_PaisDestino INT,
    SK_Produto INT,
    SK_Transporte INT,
    SK_MoedaOrigem INT,
    SK_MoedaDestino INT,
    SK_TipoTransacao INT,
    ValorMonetarioOriginal DECIMAL(18,2),
    Quantidade DECIMAL(18,2),
    TaxaCambio DECIMAL(18,6),
    FOREIGN KEY (SK_Tempo) REFERENCES DimTempo(SK_Tempo),
    FOREIGN KEY (SK_PaisOrigem) REFERENCES DimPais(SK_Pais),
    FOREIGN KEY (SK_PaisDestino) REFERENCES DimPais(SK_Pais),
    FOREIGN KEY (SK_Produto) REFERENCES DimProduto(SK_Produto),
    FOREIGN KEY (SK_Transporte) REFERENCES DimTransporte(SK_Transporte),
    FOREIGN KEY (SK_MoedaOrigem) REFERENCES DimMoeda(SK_Moeda),
    FOREIGN KEY (SK_MoedaDestino) REFERENCES DimMoeda(SK_Moeda),
    FOREIGN KEY (SK_TipoTransacao) REFERENCES DimTipoTransacao(SK_TipoTransacao)
) ENGINE=InnoDB;

CREATE INDEX idx_fact_tempo ON FactTransacoes(SK_Tempo);
CREATE INDEX idx_fact_pais_origem ON FactTransacoes(SK_PaisOrigem);
CREATE INDEX idx_fact_pais_destino ON FactTransacoes(SK_PaisDestino);
CREATE INDEX idx_fact_produto ON FactTransacoes(SK_Produto); 