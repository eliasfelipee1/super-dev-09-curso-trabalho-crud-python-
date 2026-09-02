DROP DATABASE IF EXISTS aurum_colecao;

CREATE DATABASE aurum_colecao;

USE aurum_colecao;

CREATE TABLE categorias(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(25) NOT NULL
);

INSERT INTO categorias (nome) VALUES
('Esportivo'),
('Sedan de Luxo'),
('SUV de Luxo'),
('Conversível'),
('Hypercar'),
('Coupé'),
('Clássico'),
('Elétrico');

CREATE TABLE produtos(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    categoria_id INT,
    preco FLOAT NOT NULL,
    disponivel BOOLEAN NOT NULL DEFAULT(1),
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

ALTER TABLE produtos
ADD COLUMN marca VARCHAR(50) NOT NULL
AFTER nome;

INSERT INTO produtos (nome, marca, categoria_id, preco) VALUE ('Huracán', 'Lamborghini', 1, 899990.99);

SELECT 
    produtos.id,
    produtos.nome,
    produtos.marca,
    categorias.nome AS categoria,
    produtos.preco,
    produtos.disponivel
FROM produtos
JOIN categorias ON produtos.categoria_id = categorias.id;

CREATE TABLE clientes(
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(20) NOT NULL,
    idade INT NOT NULL,
    sexo ENUM('F', 'M', 'NB') NOT NULL
);

INSERT INTO clientes (nome, idade, sexo) VALUE ('Ricardo', 45, 'M');

CREATE TABLE enderecos(
    id INT PRIMARY KEY AUTO_INCREMENT,
    rua VARCHAR(20),
    bairro VARCHAR(25),
    cidade VARCHAR(32),
    estado VARCHAR(2),
    cliente_id INT,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

INSERT INTO enderecos (rua, bairro, cidade, estado, cliente_id) VALUE ('Av. Brasil', 'Centro', 'São Paulo', 'SP', 1);

SELECT 
    enderecos.id,
    enderecos.rua,
    enderecos.bairro,
    enderecos.cidade,
    enderecos.estado,
    clientes.nome AS 'nome do cliente'
FROM enderecos
JOIN clientes ON enderecos.cliente_id = clientes.id;

CREATE TABLE estoque(
    id INT PRIMARY KEY AUTO_INCREMENT,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL DEFAULT 0,
    cliente_id INT,
    endereco_id INT,
    FOREIGN KEY (produto_id) REFERENCES produtos(id),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (endereco_id) REFERENCES enderecos(id)
);

SELECT 
    estoque.id,
    produtos.nome AS produto,
    categorias.nome AS categoria,
    estoque.quantidade,
    clientes.nome AS cliente,
    enderecos.cidade,
    enderecos.estado
FROM estoque
JOIN produtos ON estoque.produto_id = produtos.id
JOIN categorias ON produtos.categoria_id = categorias.id
LEFT JOIN clientes ON estoque.cliente_id = clientes.id
LEFT JOIN enderecos ON estoque.endereco_id = enderecos.id;

INSERT INTO estoque (produto_id, quantidade, cliente_id, endereco_id) 
VALUES (1, 3, NULL, NULL);

INSERT INTO estoque (produto_id, quantidade, cliente_id, endereco_id) 
VALUES (1, 1, 1, 1);