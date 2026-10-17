CREATE DATABASE IF NOT EXISTS vale_verde DEFAULT CHARACTER SET utf8mb4;
USE vale_verde;
SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS fato_metas;
DROP TABLE IF EXISTS fato_devolucoes;
DROP TABLE IF EXISTS fato_entregas;
DROP TABLE IF EXISTS fato_itens_pedido;
DROP TABLE IF EXISTS fato_pedidos;
DROP TABLE IF EXISTS dim_cliente;
DROP TABLE IF EXISTS dim_vendedor;
DROP TABLE IF EXISTS dim_produto;
DROP TABLE IF EXISTS dim_transportadora;
DROP TABLE IF EXISTS dim_centro_distribuicao;
DROP TABLE IF EXISTS dim_categoria;
DROP TABLE IF EXISTS dim_calendario;

SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE dim_calendario (
    data DATE NOT NULL,
    ano INT NOT NULL,
    trimestre INT NOT NULL,
    mes INT NOT NULL,
    nome_mes VARCHAR(12) NOT NULL,
    ano_mes VARCHAR(7) NOT NULL,
    dia INT NOT NULL,
    dia_semana_num INT NOT NULL,
    nome_dia_semana VARCHAR(15) NOT NULL,
    semana_iso INT NOT NULL,
    e_fim_de_semana TINYINT(1) NOT NULL,
    e_feriado TINYINT(1) NOT NULL,
    nome_feriado VARCHAR(40) NULL,
    e_dia_util TINYINT(1) NOT NULL,
    CONSTRAINT pk_dim_calendario PRIMARY KEY (data)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE dim_categoria (
    categoria_id INT NOT NULL,
    nome_categoria VARCHAR(40) NOT NULL,
    CONSTRAINT pk_dim_categoria PRIMARY KEY (categoria_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE dim_centro_distribuicao (
    cd_id INT NOT NULL,
    nome_cd VARCHAR(50) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    uf VARCHAR(2) NOT NULL,
    capacidade_pallets INT NOT NULL,
    data_inauguracao DATE NOT NULL,
    CONSTRAINT pk_dim_centro_distribuicao PRIMARY KEY (cd_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE dim_transportadora (
    transportadora_id INT NOT NULL,
    nome_transportadora VARCHAR(60) NOT NULL,
    uf_sede VARCHAR(2) NOT NULL,
    modalidade VARCHAR(20) NOT NULL,
    data_inicio_contrato DATE NOT NULL,
    CONSTRAINT pk_dim_transportadora PRIMARY KEY (transportadora_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE dim_produto (
    produto_id INT NOT NULL,
    sku VARCHAR(12) NOT NULL,
    nome_produto VARCHAR(80) NOT NULL,
    categoria_id INT NOT NULL,
    marca VARCHAR(40) NOT NULL,
    unidade_venda VARCHAR(30) NOT NULL,
    peso_kg DECIMAL(10,2) NOT NULL,
    custo_atual DECIMAL(12,2) NOT NULL,
    preco_tabela_atual DECIMAL(12,2) NOT NULL,
    ativo TINYINT(1) NOT NULL,
    CONSTRAINT pk_dim_produto PRIMARY KEY (produto_id),
    CONSTRAINT fk_dim_produto_categoria_id FOREIGN KEY (categoria_id) REFERENCES dim_categoria(categoria_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE dim_vendedor (
    vendedor_id INT NOT NULL,
    nome_vendedor VARCHAR(60) NOT NULL,
    gerente_regional VARCHAR(60) NOT NULL,
    regional VARCHAR(40) NOT NULL,
    cd_id INT NOT NULL,
    data_admissao DATE NOT NULL,
    CONSTRAINT pk_dim_vendedor PRIMARY KEY (vendedor_id),
    CONSTRAINT fk_dim_vendedor_cd_id FOREIGN KEY (cd_id) REFERENCES dim_centro_distribuicao(cd_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE dim_cliente (
    cliente_id INT NOT NULL,
    nome_cliente VARCHAR(90) NOT NULL,
    segmento VARCHAR(30) NOT NULL,
    cidade VARCHAR(50) NOT NULL,
    uf VARCHAR(2) NOT NULL,
    regiao VARCHAR(20) NOT NULL,
    cd_id INT NOT NULL,
    vendedor_id INT NOT NULL,
    data_cadastro DATE NOT NULL,
    status_cliente VARCHAR(10) NOT NULL,
    data_inativacao DATE NULL,
    limite_credito DECIMAL(12,2) NOT NULL,
    CONSTRAINT pk_dim_cliente PRIMARY KEY (cliente_id),
    CONSTRAINT fk_dim_cliente_cd_id FOREIGN KEY (cd_id) REFERENCES dim_centro_distribuicao(cd_id),
    CONSTRAINT fk_dim_cliente_vendedor_id FOREIGN KEY (vendedor_id) REFERENCES dim_vendedor(vendedor_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE fato_pedidos (
    pedido_id INT NOT NULL,
    data_pedido DATE NOT NULL,
    cliente_id INT NOT NULL,
    vendedor_id INT NOT NULL,
    cd_id INT NOT NULL,
    canal_venda VARCHAR(25) NOT NULL,
    condicao_pagamento VARCHAR(30) NOT NULL,
    status_pedido VARCHAR(25) NOT NULL,
    motivo_cancelamento VARCHAR(40) NULL,
    CONSTRAINT pk_fato_pedidos PRIMARY KEY (pedido_id),
    CONSTRAINT fk_fato_pedidos_data_pedido FOREIGN KEY (data_pedido) REFERENCES dim_calendario(data),
    CONSTRAINT fk_fato_pedidos_cliente_id FOREIGN KEY (cliente_id) REFERENCES dim_cliente(cliente_id),
    CONSTRAINT fk_fato_pedidos_vendedor_id FOREIGN KEY (vendedor_id) REFERENCES dim_vendedor(vendedor_id),
    CONSTRAINT fk_fato_pedidos_cd_id FOREIGN KEY (cd_id) REFERENCES dim_centro_distribuicao(cd_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE fato_itens_pedido (
    item_id INT NOT NULL,
    pedido_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(12,2) NOT NULL,
    desconto_pct DECIMAL(5,2) NOT NULL,
    custo_unitario DECIMAL(12,2) NOT NULL,
    valor_total DECIMAL(12,2) NOT NULL,
    CONSTRAINT pk_fato_itens_pedido PRIMARY KEY (item_id),
    CONSTRAINT fk_fato_itens_pedido_pedido_id FOREIGN KEY (pedido_id) REFERENCES fato_pedidos(pedido_id),
    CONSTRAINT fk_fato_itens_pedido_produto_id FOREIGN KEY (produto_id) REFERENCES dim_produto(produto_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE fato_entregas (
    entrega_id INT NOT NULL,
    pedido_id INT NOT NULL,
    transportadora_id INT NOT NULL,
    data_saida DATE NULL,
    data_prevista DATE NOT NULL,
    data_entrega DATE NULL,
    distancia_km INT NOT NULL,
    peso_total_kg DECIMAL(10,2) NOT NULL,
    tipo_veiculo VARCHAR(20) NOT NULL,
    custo_frete DECIMAL(12,2) NOT NULL,
    status_entrega VARCHAR(25) NOT NULL,
    dias_atraso INT NULL,
    ocorrencia VARCHAR(50) NULL,
    CONSTRAINT pk_fato_entregas PRIMARY KEY (entrega_id),
    CONSTRAINT fk_fato_entregas_pedido_id FOREIGN KEY (pedido_id) REFERENCES fato_pedidos(pedido_id),
    CONSTRAINT fk_fato_entregas_transportadora_id FOREIGN KEY (transportadora_id) REFERENCES dim_transportadora(transportadora_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE fato_devolucoes (
    devolucao_id INT NOT NULL,
    item_id INT NOT NULL,
    pedido_id INT NOT NULL,
    data_devolucao DATE NOT NULL,
    quantidade_devolvida INT NOT NULL,
    valor_devolvido DECIMAL(12,2) NOT NULL,
    motivo VARCHAR(40) NOT NULL,
    CONSTRAINT pk_fato_devolucoes PRIMARY KEY (devolucao_id),
    CONSTRAINT fk_fato_devolucoes_item_id FOREIGN KEY (item_id) REFERENCES fato_itens_pedido(item_id),
    CONSTRAINT fk_fato_devolucoes_pedido_id FOREIGN KEY (pedido_id) REFERENCES fato_pedidos(pedido_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE fato_metas (
    meta_id INT NOT NULL,
    vendedor_id INT NOT NULL,
    data_referencia DATE NOT NULL,
    meta_valor DECIMAL(12,2) NOT NULL,
    CONSTRAINT pk_fato_metas PRIMARY KEY (meta_id),
    CONSTRAINT fk_fato_metas_vendedor_id FOREIGN KEY (vendedor_id) REFERENCES dim_vendedor(vendedor_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

