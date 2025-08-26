CREATE DATABASE db_revenda_analuiza;

create table clientesa (
    id serial PRIMARY KEY,
    nome VARCHAR(50) not null,
    email VARCHAR(60) unique not null,
    telefone VARCHAR(20),
    data_cadastro DATE
);

create table produtosa (
    id serial PRIMARY KEY,
    nome VARCHAR(50) not null,
    descricao TEXT,
    preco NUMERIC(10,2) not null,
    estoque INT not null
);

create table vendedoresa (
    id serial PRIMARY KEY,
    nome VARCHAR(50) not null,
    email VARCHAR(60) unique not null,
    telefone VARCHAR(20),
    data_contratacao DATE
);

create table pedidosa (
    id serial PRIMARY KEY,
    id_cliente INT not null,
    id_vendedor INT not null,
    data_pedido DATE
);

create table pagamentosa (
    id serial PRIMARY KEY,
    id_pedido INT not null,
    valor_pago NUMERIC(10,2) not null, 
    metodo_pagamento VARCHAR(30) not null,
    data_pagamento DATE
);

create table itens_pedidoa (
    id_pedido INT not null,
    id_produto INT not null,
    quantidade INT not null,
    preco_unitario NUMERIC(10,2) not null
);

alter table clientesa
add FOREIGN KEY (id_clientes) references clientesa(id_clientes);

alter table vendedoresa
add foreign key (id_vendedor) references vendedoresa(id_vendedor);

alter table pagamentosa
add foreign key (id_pedido) references pedidosa(id_pedido);

alter table itens_pedidoa 
add foreign key (id_pedido) references pedidosa(id_pedido);

alter table itens_pedidoa 
add foreign key (id_produto) references produtosa(id_produto);



insert into clientesa (nome, email, telefone) VALUES
('Ana Luiza', 'ana@email.com', '11999990000'),
('Carlos Silva', 'carlos@email.com', '11888887777'),
('Bruna Lima', 'bruna@email.com', '11777776666'),
('Marcos Reis', 'marcos@email.com', '11666665555'),
('Julia Rocha', 'julia@email.com', '11555554444'),
('Pedro Paulo', 'pedro@email.com', '11444443333'),
('Vanessa Souza', 'vanessa@email.com', '11333332222'),
('Tiago Nunes', 'tiago@email.com', '11222221111'),
('Rafaela Dias', 'rafaela@email.com', '11111110000'),
('Lucas Ramos', 'lucas@email.com', '11000009999');


insert into produtosa (nome, descricao, preco, estoque) VALUES
('Smartphone X', 'Smartphone com 128GB e câmera dupla', 1500.00, 52),
('Notebook Pro', 'Notebook com 16GB RAM e SSD 512GB', 4500.00, 38),
('Smart TV 50"', 'Televisão 4K com HDR', 2800.00, 20),
('Fone Bluetooth', 'Fone de ouvido sem fio', 300.00, 107),
('Tablet Y', 'Tablet 10" com 64GB', 1200.00, 40),
('Mouse Gamer', 'Mouse com LED e alta precisão', 150.00, 70),
('Teclado Mecânico', 'Teclado com switches azuis', 350.00, 60),
('Monitor 24"', 'Monitor Full HD', 900.00, 25),
('Câmera de Segurança', 'Câmera Wi-Fi com detecção de movimento', 600.00, 35),
('Carregador Turbo', 'Carregador rápido 30W', 100.00, 88);


insert into vendedoresa (nome, email, telefone) VALUES
('João Vitor', 'joao@email.com', '1442345678'),
('Camila Rocha', 'camila@email.com', '3123456789'),
('Felipe Alves', 'felipe@email.com', '1194567590'),
('Mariana Souza', 'mariana@email.com', '1145678901'),
('Gustavo Lima', 'gustavo@email.com', '4156789012'),
('Isabela Cruz', 'isabela@email.com', '1167890123'),
('Rogério Dias', 'rogerio@email.com', '1178901234'),
('Natália Alves', 'natalia@email.com', '1189012345'),
('Eduardo Silva', 'eduardo@email.com', '8190123456'),
('Fernanda Reis', 'fernanda@email.com', '2201234567');


insert into pedidosa(id_cliente, id_vendedor, data_pedido) VALUES
(20, 2, '2025-07-01 10:22:00'),
(12, 9, '2025-08-09 11:30:00'),
(9, 23, '2025-08-20 09:15:00'),
(43, 44, '2025-08-04 14:20:00'),
(8, 7, '2025-08-21 16:45:00'),
(23, 12, '2025-08-06 12:34:00'),
(7, 33, '2025-07-07 08:30:00'),
(11, 52, '2025-08-04 13:10:00'),
(21, 3, '2025-08-30 17:25:00'),
(10, 31, '2025-08-11 15:50:00');


insert into pagamentosa (id_pedido, valor_pago, metodo_pagamento, data_pagamento) VALUES
(1, 1500.00, 'Cartão de Crédito', '2025-08-30 10:30:00'),
(2, 300.00, 'Pix', '2025-08-02 11:45:00'),
(3, 4500.00, 'Boleto', '2025-08-03 09:50:00'),
(4, 1200.00, 'Cartão de Débito', '2025-08-02 14:50:00'),
(5, 900.00, 'Pix', '2025-08-05 16:55:00'),
(6, 150.00, 'Dinheiro', '2025-08-11 12:30:00'),
(7, 600.00, 'Cartão de Crédito', '2025-08-12 08:45:00'),
(8, 2800.00, 'Pix', '2025-08-22 13:30:00'),
(9, 350.00, 'Boleto', '2025-08-10 17:40:00'),
(10, 100.00, 'Pix', '2025-08-10 16:00:00');

insert into itens_pedidoa (id_pedido, id_produto, quantidade, preco_unitario) VALUES
(1, 1, 2, 1500.00),
(2, 4, 1, 300.00),
(3, 2, 3, 4500.00),
(4, 5, 1, 1200.00),
(5, 8, 1, 900.00),
(6, 6, 6, 150.00),
(7, 9, 11, 600.00),
(8, 3, 1, 2800.00),
(9, 7, 1, 350.00),
(10, 10, 15, 100.00);


CREATE VIEW vw_pedidos as
SELECT
    p.id_pedido,
    c.nome as cliente,
    p.data_pedido
FROM pedidos p
JOIN clientes c on p.id_cliente = c.id_cliente;



CREATE VIEW vw_produtos_fornecedores as
SELECT
    pr.nome as produto,
    f.nome as fornecedor
FROM produtos pr
JOIN fornecedores f on pr.id_fornecedor = f.id_fornecedor;


















