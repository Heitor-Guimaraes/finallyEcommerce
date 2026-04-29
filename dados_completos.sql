-- ============================================
-- DADOS COMPLETOS PARA ECOMMERCE API
-- ============================================
-- Arquivo com dados para todas as 6 tabelas
-- Pronto para importar direto no MySQL

USE ecommerce;

-- ============================================
-- LIMPAR DADOS ANTERIORES (OPCIONAL)
-- ============================================
-- DELETE FROM item_do_pedido;
-- DELETE FROM pagamento;
-- DELETE FROM pedido;
-- DELETE FROM produto;
-- DELETE FROM usuario;
-- DELETE FROM categoria;

-- ============================================
-- 1. INSERIR CATEGORIAS (5 registros)
-- ============================================

INSERT INTO categoria (id, nome) VALUES
('f47ac10b-58cc-4372-a567-0e02b2c3d479', 'Eletrônicos'),
('f47ac10b-58cc-4372-a567-0e02b2c3d480', 'Roupas'),
('f47ac10b-58cc-4372-a567-0e02b2c3d481', 'Alimentos'),
('f47ac10b-58cc-4372-a567-0e02b2c3d482', 'Livros'),
('f47ac10b-58cc-4372-a567-0e02b2c3d483', 'Móveis');

-- ============================================
-- 2. INSERIR USUÁRIOS (4 registros)
-- ============================================
-- Senha: senha123 (codificada em BCrypt)

INSERT INTO usuario (id, nome, email, telefone, senha, roles) VALUES
('f47ac10b-58cc-4372-a567-0e02b2c3d500', 'Admin User', 'admin@example.com', '11999999999', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcg7b3XeKeUxWdeS86E36gBS3FO', 'ADMIN'),
('f47ac10b-58cc-4372-a567-0e02b2c3d501', 'João Silva', 'joao@example.com', '11988888888', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcg7b3XeKeUxWdeS86E36gBS3FO', 'USER'),
('f47ac10b-58cc-4372-a567-0e02b2c3d502', 'Maria Santos', 'maria@example.com', '11987777777', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcg7b3XeKeUxWdeS86E36gBS3FO', 'USER'),
('f47ac10b-58cc-4372-a567-0e02b2c3d503', 'Pedro Oliveira', 'pedro@example.com', '11986666666', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcg7b3XeKeUxWdeS86E36gBS3FO', 'USER');

-- ============================================
-- 3. INSERIR PRODUTOS (20 registros)
-- ============================================

-- ELETRÔNICOS
INSERT INTO produto (id, nome, preco, quantidade, categoria_id) VALUES
('f47ac10b-58cc-4372-a567-0e02b2c3d600', 'Notebook Dell Inspiron', 2850.50, 15, 'f47ac10b-58cc-4372-a567-0e02b2c3d479'),
('f47ac10b-58cc-4372-a567-0e02b2c3d601', 'Mouse Logitech MX Master', 189.90, 45, 'f47ac10b-58cc-4372-a567-0e02b2c3d479'),
('f47ac10b-58cc-4372-a567-0e02b2c3d602', 'Teclado Mecânico RGB', 450.00, 28, 'f47ac10b-58cc-4372-a567-0e02b2c3d479'),
('f47ac10b-58cc-4372-a567-0e02b2c3d603', 'Monitor LG 24" Full HD', 799.99, 12, 'f47ac10b-58cc-4372-a567-0e02b2c3d479'),
('f47ac10b-58cc-4372-a567-0e02b2c3d604', 'Webcam Logitech 1080p', 125.50, 35, 'f47ac10b-58cc-4372-a567-0e02b2c3d479'),

-- ROUPAS
('f47ac10b-58cc-4372-a567-0e02b2c3d605', 'Camiseta Premium Básica', 89.90, 150, 'f47ac10b-58cc-4372-a567-0e02b2c3d480'),
('f47ac10b-58cc-4372-a567-0e02b2c3d606', 'Calça Jeans Slim Fit', 120.00, 80, 'f47ac10b-58cc-4372-a567-0e02b2c3d480'),
('f47ac10b-58cc-4372-a567-0e02b2c3d607', 'Jaqueta Impermeável', 250.00, 20, 'f47ac10b-58cc-4372-a567-0e02b2c3d480'),
('f47ac10b-58cc-4372-a567-0e02b2c3d608', 'Tênis Esportivo Confortável', 199.99, 50, 'f47ac10b-58cc-4372-a567-0e02b2c3d480'),

-- ALIMENTOS
('f47ac10b-58cc-4372-a567-0e02b2c3d609', 'Café Premium 500g', 35.00, 200, 'f47ac10b-58cc-4372-a567-0e02b2c3d481'),
('f47ac10b-58cc-4372-a567-0e02b2c3d610', 'Chocolate Belga Premium', 25.00, 150, 'f47ac10b-58cc-4372-a567-0e02b2c3d481'),
('f47ac10b-58cc-4372-a567-0e02b2c3d611', 'Azeite Extra Virgem 500ml', 45.00, 80, 'f47ac10b-58cc-4372-a567-0e02b2c3d481'),
('f47ac10b-58cc-4372-a567-0e02b2c3d612', 'Mel Orgânico 500g', 28.50, 100, 'f47ac10b-58cc-4372-a567-0e02b2c3d481'),

-- LIVROS
('f47ac10b-58cc-4372-a567-0e02b2c3d613', 'Clean Code', 89.90, 25, 'f47ac10b-58cc-4372-a567-0e02b2c3d482'),
('f47ac10b-58cc-4372-a567-0e02b2c3d614', 'Design Patterns', 95.00, 20, 'f47ac10b-58cc-4372-a567-0e02b2c3d482'),
('f47ac10b-58cc-4372-a567-0e02b2c3d615', 'The Pragmatic Programmer', 110.00, 18, 'f47ac10b-58cc-4372-a567-0e02b2c3d482'),

-- MÓVEIS
('f47ac10b-58cc-4372-a567-0e02b2c3d616', 'Mesa Escritório Gamer', 500.00, 12, 'f47ac10b-58cc-4372-a567-0e02b2c3d483'),
('f47ac10b-58cc-4372-a567-0e02b2c3d617', 'Cadeira Gamer com Encosto', 1200.00, 8, 'f47ac10b-58cc-4372-a567-0e02b2c3d483'),
('f47ac10b-58cc-4372-a567-0e02b2c3d618', 'Prateleira Flutuante', 85.00, 40, 'f47ac10b-58cc-4372-a567-0e02b2c3d483'),
('f47ac10b-58cc-4372-a567-0e02b2c3d619', 'Estante para Livros', 350.00, 15, 'f47ac10b-58cc-4372-a567-0e02b2c3d483');

-- ============================================
-- 4. INSERIR PEDIDOS (10 registros)
-- ============================================

INSERT INTO pedido (id, data_criacao, status, cliente_id) VALUES
('f47ac10b-58cc-4372-a567-0e02b2c3d700', '2024-03-15 10:30:45', 'PENDENTE', 'f47ac10b-58cc-4372-a567-0e02b2c3d501'),
('f47ac10b-58cc-4372-a567-0e02b2c3d701', '2024-03-16 14:20:12', 'CONFIRMADO', 'f47ac10b-58cc-4372-a567-0e02b2c3d502'),
('f47ac10b-58cc-4372-a567-0e02b2c3d702', '2024-03-17 09:15:33', 'ENVIADO', 'f47ac10b-58cc-4372-a567-0e02b2c3d503'),
('f47ac10b-58cc-4372-a567-0e02b2c3d703', '2024-03-18 16:45:22', 'ENTREGUE', 'f47ac10b-58cc-4372-a567-0e02b2c3d501'),
('f47ac10b-58cc-4372-a567-0e02b2c3d704', '2024-03-19 11:30:00', 'CONFIRMADO', 'f47ac10b-58cc-4372-a567-0e02b2c3d502'),
('f47ac10b-58cc-4372-a567-0e02b2c3d705', '2024-03-20 13:10:15', 'ENVIADO', 'f47ac10b-58cc-4372-a567-0e02b2c3d503'),
('f47ac10b-58cc-4372-a567-0e02b2c3d706', '2024-03-21 08:50:40', 'PENDENTE', 'f47ac10b-58cc-4372-a567-0e02b2c3d501'),
('f47ac10b-58cc-4372-a567-0e02b2c3d707', '2024-03-22 15:25:30', 'CONFIRMADO', 'f47ac10b-58cc-4372-a567-0e02b2c3d502'),
('f47ac10b-58cc-4372-a567-0e02b2c3d708', '2024-03-23 10:15:00', 'ENVIADO', 'f47ac10b-58cc-4372-a567-0e02b2c3d503'),
('f47ac10b-58cc-4372-a567-0e02b2c3d709', '2024-03-24 12:40:50', 'ENTREGUE', 'f47ac10b-58cc-4372-a567-0e02b2c3d501');

-- ============================================
-- 5. INSERIR ITENS DO PEDIDO (15 registros)
-- ============================================

-- Pedido 1: Eletrônicos
INSERT INTO item_do_pedido (pedido_id, produto_id, quantidade, preco_unitario) VALUES
('f47ac10b-58cc-4372-a567-0e02b2c3d700', 'f47ac10b-58cc-4372-a567-0e02b2c3d600', 1, 2850.50),
('f47ac10b-58cc-4372-a567-0e02b2c3d700', 'f47ac10b-58cc-4372-a567-0e02b2c3d601', 2, 189.90),
('f47ac10b-58cc-4372-a567-0e02b2c3d700', 'f47ac10b-58cc-4372-a567-0e02b2c3d602', 1, 450.00),

-- Pedido 2: Roupas
('f47ac10b-58cc-4372-a567-0e02b2c3d701', 'f47ac10b-58cc-4372-a567-0e02b2c3d605', 3, 89.90),
('f47ac10b-58cc-4372-a567-0e02b2c3d701', 'f47ac10b-58cc-4372-a567-0e02b2c3d606', 1, 120.00),

-- Pedido 3: Livros
('f47ac10b-58cc-4372-a567-0e02b2c3d702', 'f47ac10b-58cc-4372-a567-0e02b2c3d613', 2, 89.90),
('f47ac10b-58cc-4372-a567-0e02b2c3d702', 'f47ac10b-58cc-4372-a567-0e02b2c3d614', 1, 95.00),

-- Pedido 4: Móveis
('f47ac10b-58cc-4372-a567-0e02b2c3d703', 'f47ac10b-58cc-4372-a567-0e02b2c3d616', 1, 500.00),
('f47ac10b-58cc-4372-a567-0e02b2c3d703', 'f47ac10b-58cc-4372-a567-0e02b2c3d618', 2, 85.00),

-- Pedido 5: Mix de Alimentos
('f47ac10b-58cc-4372-a567-0e02b2c3d704', 'f47ac10b-58cc-4372-a567-0e02b2c3d609', 3, 35.00),
('f47ac10b-58cc-4372-a567-0e02b2c3d704', 'f47ac10b-58cc-4372-a567-0e02b2c3d610', 2, 25.00),

-- Pedido 6: Eletrônicos
('f47ac10b-58cc-4372-a567-0e02b2c3d705', 'f47ac10b-58cc-4372-a567-0e02b2c3d603', 1, 799.99),

-- Pedido 7: Roupas
('f47ac10b-58cc-4372-a567-0e02b2c3d706', 'f47ac10b-58cc-4372-a567-0e02b2c3d608', 2, 199.99),

-- Pedido 8: Diversos
('f47ac10b-58cc-4372-a567-0e02b2c3d707', 'f47ac10b-58cc-4372-a567-0e02b2c3d604', 1, 125.50),
('f47ac10b-58cc-4372-a567-0e02b2c3d707', 'f47ac10b-58cc-4372-a567-0e02b2c3d611', 1, 45.00);

-- ============================================
-- 6. INSERIR PAGAMENTOS (10 registros)
-- ============================================

INSERT INTO pagamento (id, metodo, status, valor, data_pagamento, pedido_id) VALUES
('f47ac10b-58cc-4372-a567-0e02b2c3d800', 'CARTAO_CREDITO', 'APROVADO', 3800.30, '2024-03-15 10:35:00', 'f47ac10b-58cc-4372-a567-0e02b2c3d700'),
('f47ac10b-58cc-4372-a567-0e02b2c3d801', 'PIX', 'APROVADO', 369.85, '2024-03-16 14:22:00', 'f47ac10b-58cc-4372-a567-0e02b2c3d701'),
('f47ac10b-58cc-4372-a567-0e02b2c3d802', 'BOLETO', 'PENDENTE', 284.90, '2024-03-17 09:16:00', 'f47ac10b-58cc-4372-a567-0e02b2c3d702'),
('f47ac10b-58cc-4372-a567-0e02b2c3d803', 'TRANSFERENCIA', 'APROVADO', 670.00, '2024-03-18 16:46:00', 'f47ac10b-58cc-4372-a567-0e02b2c3d703'),
('f47ac10b-58cc-4372-a567-0e02b2c3d804', 'CARTAO_CREDITO', 'APROVADO', 135.00, '2024-03-19 11:31:00', 'f47ac10b-58cc-4372-a567-0e02b2c3d704'),
('f47ac10b-58cc-4372-a567-0e02b2c3d805', 'PIX', 'APROVADO', 799.99, '2024-03-20 13:11:00', 'f47ac10b-58cc-4372-a567-0e02b2c3d705'),
('f47ac10b-58cc-4372-a567-0e02b2c3d806', 'CARTAO_CREDITO', 'PENDENTE', 399.98, '2024-03-21 08:51:00', 'f47ac10b-58cc-4372-a567-0e02b2c3d706'),
('f47ac10b-58cc-4372-a567-0e02b2c3d807', 'BOLETO', 'REJEITADO', 170.50, '2024-03-22 15:26:00', 'f47ac10b-58cc-4372-a567-0e02b2c3d707'),
('f47ac10b-58cc-4372-a567-0e02b2c3d808', 'PIX', 'APROVADO', 210.00, '2024-03-23 10:16:00', 'f47ac10b-58cc-4372-a567-0e02b2c3d708'),
('f47ac10b-58cc-4372-a567-0e02b2c3d809', 'CARTAO_CREDITO', 'APROVADO', 585.00, '2024-03-24 12:41:00', 'f47ac10b-58cc-4372-a567-0e02b2c3d709');

-- ============================================
-- RESUMO DOS DADOS INSERIDOS
-- ============================================

SELECT 'CATEGORIAS' as Tabela, COUNT(*) as Total FROM categoria
UNION
SELECT 'USUARIOS', COUNT(*) FROM usuario
UNION
SELECT 'PRODUTOS', COUNT(*) FROM produto
UNION
SELECT 'PEDIDOS', COUNT(*) FROM pedido
UNION
SELECT 'ITENS DO PEDIDO', COUNT(*) FROM item_do_pedido
UNION
SELECT 'PAGAMENTOS', COUNT(*) FROM pagamento;

-- ============================================
-- DADOS DE LOGIN PARA TESTE
-- ============================================
-- Email: admin@example.com | Senha: senha123
-- Email: joao@example.com | Senha: senha123
-- Email: maria@example.com | Senha: senha123
-- Email: pedro@example.com | Senha: senha123

