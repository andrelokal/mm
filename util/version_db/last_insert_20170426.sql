-- phpMyAdmin SQL Dump
-- version 4.4.15.9
-- https://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: 26-Abr-2017 às 05:38
-- Versão do servidor: 5.6.35
-- PHP Version: 7.0.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mm_bd`
--

--
-- Extraindo dados da tabela `acesso`
--

INSERT INTO `acesso` (`id`, `modulo_id`, `funcionario_id`, `nivel_acesso`) VALUES
(2, 1, 1, ''),
(6, 1, 9, NULL),
(7, 15, 9, NULL),
(8, 18, 9, NULL);

--
-- Extraindo dados da tabela `caixa`
--

INSERT INTO `caixa` (`id`, `valor_inicial`, `valor_fechamento`, `funcionario_id`, `dt_abertura`, `dt_fechamento`) VALUES
(35, 55.00, NULL, 1, '2017-04-26 05:23:26', NULL);

--
-- Extraindo dados da tabela `categoria`
--

INSERT INTO `categoria` (`id`, `nome`) VALUES
(23, 'Cueca Malha'),
(24, 'Cueca Box'),
(25, 'Sutien 1/2'),
(26, 'Tanga');

--
-- Extraindo dados da tabela `comanda_mesa`
--

INSERT INTO `comanda_mesa` (`id`, `codigo`, `active`) VALUES
(1, 'Balcão', 'y');

--
-- Extraindo dados da tabela `config`
--

INSERT INTO `config` (`id`, `nome_empresa`, `desc_cupom`, `print_port`) VALUES
(1, 'Nome do Comercio LTDA', NULL, NULL);

--
-- Extraindo dados da tabela `entrada_produto`
--

INSERT INTO `entrada_produto` (`id`, `tipo`, `produto_id`, `fornecedor_id`, `quantidade`, `lote`, `dt_compra`, `dt_validade`, `valor_unitario`, `valor_total`, `motivo_saida`) VALUES
(39, 'E', 52, NULL, 10, NULL, '2017-04-25', '2017-05-25', 6.90, 69.00, NULL),
(40, 'E', 49, 1, 10, NULL, '2017-04-25', '2017-05-25', 9.80, 99.99, NULL),
(41, 'E', 44, 1, 12, NULL, '2017-04-25', '2017-05-25', 9.60, 96.00, NULL),
(42, 'E', 50, 1, 8, NULL, '2017-04-25', '2017-05-25', 11.40, 120.00, NULL);

--
-- Extraindo dados da tabela `fisica`
--

INSERT INTO `fisica` (`id`, `pessoa_id`, `cpf`, `nome`, `rg`, `dt_nascimento`, `sexo`, `tem_conta`, `dia_mes_pagto`, `limite_conta`) VALUES
(43, 80, '361.591.058-33', 'Mizaele ', '', NULL, '', 'y', 15, 100.00);

--
-- Extraindo dados da tabela `forma_pagto`
--

INSERT INTO `forma_pagto` (`id`, `nome`, `active`, `active_c`) VALUES
(1, 'Dinheiro', 'y', 'y'),
(2, 'Cartao Debito', 'y', 'y'),
(3, 'Cartao Credito', 'y', 'y'),
(4, 'Conta Cliente', 'y', 'n');

--
-- Extraindo dados da tabela `funcionario`
--

INSERT INTO `funcionario` (`id`, `nome`, `tipo_us`, `pessoa_id`, `login`, `senha`) VALUES
(1, 'Ulisses Bueno', 'M', 1, 'ulisses', '0dd1219bf2c236a83bc362ffcdb02b50'),
(9, 'Misaele Matos', 'N', 79, 'misaelem', '3e764a08c4717e2db982d84f505616ad');

--
-- Extraindo dados da tabela `help`
--

INSERT INTO `help` (`id`, `title`, `description`, `modulo_id`, `order`) VALUES
(1, 'Introdução', 'Bem vindo ao Magazine Manager System!', 16, 1),
(3, 'Primeiros Passos', 'A primeira coisa à fazer é cadastrar os dados necessários para criar seu catálogo de produtos. Para isso é preciso categorizar os produtos.', 16, 2),
(4, 'Categorias', '...', 3, 3),
(5, 'Produtos', '...', 4, 4),
(6, 'Controle de Estoque', '...', 10, 5),
(8, 'Venda de Produtos', '...', 1, 6);

--
-- Extraindo dados da tabela `help_item`
--

INSERT INTO `help_item` (`id`, `help_id`, `title_item`, `resume`, `description_item`, `order_item`) VALUES
(1, 4, 'Nova Categoria', '', '...', 1),
(2, 4, 'Editando Categoria', '', '...', 2),
(3, 4, 'Excluindo Categoria', '', '...', 3),
(4, 5, 'Novo Produto', '', '...', 4),
(5, 5, 'Editando Produto', '', '...', 5),
(6, 5, 'Excluindo Produto', '', '...', 6),
(7, 6, 'Incluir Produto no Estoque', '', '...', 7),
(8, 6, 'Tirar Produto do Estoque', '', '...', 8),
(9, 6, 'Acerto Positivo do Estoque', '', '...', 9),
(10, 8, 'Adicionar Item na Venda', 'Digite o código ou o código de barra do produto que deseja adicionar a venda', '...', 10),
(11, 8, 'Definir Quantidade do Item na Venda', '', '...', 11),
(12, 8, 'Excluir um ou mais Itens da Venda', '', '...', 12),
(13, 8, 'Efetuar Pagamento da Venda', '', '...', 13),
(14, 8, 'Cancelar uma Venda', '', '...', 14),
(15, 8, 'Pesquisar Preço e/ou Estoque de Produto', '', '...', 15);

--
-- Extraindo dados da tabela `itens_venda`
--

INSERT INTO `itens_venda` (`id`, `venda_id`, `produto_id`, `quantidade`, `valor_unitario`) VALUES
(1, 148, 50, 1.00, 11.40),
(2, 148, 52, 2.00, 13.80),
(3, 148, 49, 1.00, 9.99),
(4, 149, 50, 1.00, 11.40),
(5, 149, 52, 2.00, 13.80),
(6, 149, 49, 1.00, 9.99),
(7, 150, 50, 1.00, 11.40),
(8, 150, 52, 2.00, 13.80),
(9, 150, 49, 1.00, 9.99);

--
-- Extraindo dados da tabela `juridica`
--

INSERT INTO `juridica` (`id`, `pessoa_id`, `cnpj`, `razao_social`, `nome_fantasia`, `inscricao_estadual`, `ccm`) VALUES
(1, 81, '22.661.263/0001-84', 'Marcos', 'Marcos', NULL, NULL);

--
-- Extraindo dados da tabela `log`
--

INSERT INTO `log` (`id`, `user`, `log`, `data`, `ip`) VALUES
(1, 1, 'INSERT INTO categoria (nome) VALUES (''Cueca Masculina'')', '2017-04-26 03:34:46', '192.168.1.244'),
(2, 1, 'INSERT INTO categoria (nome) VALUES (''Cueca malha 4 agulha'')', '2017-04-26 03:55:01', '192.168.1.244'),
(3, 1, 'INSERT INTO categoria (nome) VALUES (''Cueca Lycra Ad.'')', '2017-04-26 03:55:25', '192.168.1.244'),
(4, 1, 'UPDATE categoria SET nome = ''Cueca malha 4 agulha'' WHERE id = 6', '2017-04-26 03:55:32', '192.168.1.244'),
(5, 1, 'INSERT INTO categoria (nome) VALUES (''Cueca Box black jack'')', '2017-04-26 03:58:09', '192.168.1.244'),
(6, 1, 'INSERT INTO categoria (nome) VALUES (''Cueca Box Viscolycra'')', '2017-04-26 03:58:49', '192.168.1.244'),
(7, 1, 'INSERT INTO categoria (nome) VALUES (''Cueca Box Micro-fibra'')', '2017-04-26 03:59:17', '192.168.1.244'),
(8, 1, 'INSERT INTO categoria (nome) VALUES (''Cueca Malha c/ cos'')', '2017-04-26 04:00:01', '192.168.1.244'),
(9, 1, 'UPDATE categoria SET nome = ''Cueca Malha c/ cos Infantil'' WHERE id = 11', '2017-04-26 04:06:03', '192.168.1.244'),
(10, 1, 'INSERT INTO categoria (nome) VALUES (''Sutien ReforÃ§ado alÃ§a de espuma'')', '2017-04-26 04:06:42', '192.168.1.244'),
(11, 1, 'UPDATE categoria SET nome = ''Sutien Micro Forrado especial'' WHERE id = 12', '2017-04-26 04:07:21', '192.168.1.244'),
(12, 1, 'INSERT INTO categoria (nome) VALUES (''Toper Fitness Estampado'')', '2017-04-26 04:07:49', '192.168.1.244'),
(13, 1, 'INSERT INTO categoria (nome) VALUES (''Toper Micro c/ Tiras'')', '2017-04-26 04:08:17', '192.168.1.244'),
(14, 1, 'INSERT INTO categoria (nome) VALUES (''Toper Fitnes Bojo Juju'')', '2017-04-26 04:08:55', '192.168.1.244'),
(15, 1, 'INSERT INTO categoria (nome) VALUES (''Conj 1/2 Micro Renda'')', '2017-04-26 04:09:27', '192.168.1.244'),
(16, 1, 'UPDATE categoria SET nome = ''Conj 1/2 Micro Renda Flor'' WHERE id = 16', '2017-04-26 04:09:40', '192.168.1.244'),
(17, 1, 'INSERT INTO categoria (nome) VALUES (''Conj 1/2 Mel'')', '2017-04-26 04:09:53', '192.168.1.244'),
(18, 1, 'INSERT INTO categoria (nome) VALUES (''Sutien Sereia AlÃ§a Torcida'')', '2017-04-26 04:11:45', '192.168.1.244'),
(19, 1, 'INSERT INTO categoria (nome) VALUES (''Sutien 1/2 Beauty Estrep'')', '2017-04-26 04:12:14', '192.168.1.244'),
(20, 1, 'INSERT INTO categoria (nome) VALUES (''Sutien 1/2 TranÃ§ado Ilma'')', '2017-04-26 04:12:51', '192.168.1.244'),
(21, 1, 'INSERT INTO categoria (nome) VALUES (''Toper Micro c/ Tiras'')', '2017-04-26 04:13:57', '192.168.1.244'),
(22, 1, 'INSERT INTO categoria (nome) VALUES (''Cueca Masculina'')', '2017-04-26 04:19:03', '192.168.1.244'),
(23, 1, 'INSERT INTO categoria (nome) VALUES (''Cueca Malha'')', '2017-04-26 04:19:27', '192.168.1.244'),
(24, 1, 'INSERT INTO categoria (nome) VALUES (''Cueca Box'')', '2017-04-26 04:19:35', '192.168.1.244'),
(25, 1, 'INSERT INTO categoria (nome) VALUES (''Sutien 1/2'')', '2017-04-26 04:20:00', '192.168.1.244'),
(26, 1, 'INSERT INTO categoria (nome) VALUES (''Tanga'')', '2017-04-26 04:20:08', '192.168.1.244'),
(27, 1, 'INSERT INTO produto (codigo,codbar,categoria_id,nome,descricao,valor,unidade_id,estoque_min,estoque,tem_estoque) VALUES (''123'',NULL,''23'',''teste'',NULL,''11.11'',''1'',NULL,NULL,''y'')', '2017-04-26 04:40:54', '192.168.1.244'),
(28, 1, 'INSERT INTO produto (codigo,codbar,categoria_id,nome,descricao,valor,unidade_id,estoque_min,estoque,tem_estoque) VALUES (''000829'',NULL,''24'',''Cueca Black Jack'',NULL,''18.99'',''1'',NULL,NULL,''y'')', '2017-04-26 04:43:22', '192.168.1.244'),
(29, 1, 'INSERT INTO produto (codigo,codbar,categoria_id,nome,descricao,valor,unidade_id,estoque_min,estoque,tem_estoque) VALUES (''00007'',NULL,''24'',''Cueca Box Micro-fibra'',NULL,''18.99'',''1'',NULL,NULL,''y'')', '2017-04-26 04:44:41', '192.168.1.244'),
(30, 1, 'INSERT INTO produto (codigo,codbar,categoria_id,nome,descricao,valor,unidade_id,estoque_min,estoque,tem_estoque) VALUES (''00006'',NULL,''24'',''Cueca Box Viscolycra'',NULL,''12.99'',''1'',NULL,NULL,''y'')', '2017-04-26 04:45:51', '192.168.1.244'),
(31, 1, 'INSERT INTO produto (codigo,codbar,categoria_id,nome,descricao,valor,unidade_id,estoque_min,estoque,tem_estoque) VALUES (''00011'',NULL,''23'',''Cueca Malha c/ cos Infantil'',NULL,''4.99'',''1'',NULL,NULL,''n'')', '2017-04-26 04:46:28', '192.168.1.244'),
(32, 1, 'UPDATE produto SET codigo = ''00007'', codbar = '''', categoria_id = ''24'', nome = ''Cueca Box Micro-fibra'', descricao = '''', valor = ''18.99'', unidade_id = ''1'', estoque_min = ''6'', tem_estoque = ''y'' WHERE id = 36', '2017-04-26 04:51:30', '192.168.1.244'),
(33, 1, 'UPDATE produto SET codigo = ''000829'', categoria_id = ''24'', nome = ''Cueca Black Jack'', descricao = '''', valor = ''18.99'', unidade_id = ''1'', tem_estoque = ''y'' WHERE id = 35', '2017-04-26 04:59:32', '192.168.1.244'),
(34, 1, 'UPDATE produto SET codigo = ''00007'', categoria_id = ''24'', nome = ''Cueca Box Micro-fibra'', descricao = '''', valor = ''18.99'', unidade_id = ''1'', estoque_min = ''6'', tem_estoque = ''y'' WHERE id = 36', '2017-04-26 04:59:46', '192.168.1.244'),
(35, 1, 'UPDATE produto SET codigo = ''000829'', categoria_id = ''24'', nome = ''Cueca Black Jack'', descricao = '''', valor = ''18.99'', unidade_id = ''1'', estoque_min = ''5'', tem_estoque = ''y'' WHERE id = 35', '2017-04-26 05:00:27', '192.168.1.244'),
(36, 1, 'UPDATE produto SET codigo = ''00007'', categoria_id = ''24'', nome = ''Cueca Box Micro-fibra'', descricao = '''', valor = ''18.99'', unidade_id = ''1'', estoque_min = ''6'', tem_estoque = ''y'' WHERE id = 36', '2017-04-26 05:01:06', '192.168.1.244'),
(37, 1, 'UPDATE produto SET codigo = ''00006'', categoria_id = ''24'', nome = ''Cueca Box Viscolycra'', descricao = '''', valor = ''12.99'', unidade_id = ''1'', estoque_min = ''4'', tem_estoque = ''y'' WHERE id = 42', '2017-04-26 05:01:13', '192.168.1.244'),
(38, 1, 'UPDATE produto SET codigo = ''00011'', categoria_id = ''23'', nome = ''Cueca Malha c/ cos Infantil'', descricao = '''', valor = ''4.99'', unidade_id = ''1'', tem_estoque = ''n'' WHERE id = 43', '2017-04-26 05:01:24', '192.168.1.244'),
(39, 1, 'UPDATE produto SET codigo = ''00011'', categoria_id = ''23'', nome = ''Cueca Malha c/ cos Infantil'', descricao = '''', valor = ''4.99'', unidade_id = ''1'', estoque_min = ''2'', tem_estoque = ''n'' WHERE id = 43', '2017-04-26 05:01:49', '192.168.1.244'),
(40, 1, 'INSERT INTO produto (codigo,codbar,categoria_id,nome,descricao,valor,unidade_id,estoque_min,estoque,tem_estoque) VALUES (''01988'',NULL,''26'',''Tanga Poa Rosimeire'',NULL,''9.60'',''1'',''8'',NULL,''y'')', '2017-04-26 05:03:40', '192.168.1.244'),
(41, 1, 'INSERT INTO produto (codigo,codbar,categoria_id,nome,descricao,valor,unidade_id,estoque_min,estoque,tem_estoque) VALUES (''020174'',NULL,''26'',''Tanga doce encanto'',NULL,''9.99'',''1'',''8'',NULL,''y'')', '2017-04-26 05:04:21', '192.168.1.244'),
(42, 1, 'INSERT INTO produto (codigo,codbar,categoria_id,nome,descricao,valor,unidade_id,estoque_min,estoque,tem_estoque) VALUES (''00509'',NULL,''26'',''Tanga Sheila Micro c/ renda'',NULL,''9.60'',''1'',''8'',NULL,''y'')', '2017-04-26 05:04:57', '192.168.1.244'),
(43, 1, 'INSERT INTO produto (codigo,codbar,categoria_id,nome,descricao,valor,unidade_id,estoque_min,estoque,tem_estoque) VALUES (''02087'',NULL,''26'',''Tanga Marlu'',NULL,''10.40'',''1'',''9'',NULL,''y'')', '2017-04-26 05:05:37', '192.168.1.244'),
(44, 1, 'INSERT INTO produto (codigo,codbar,categoria_id,nome,descricao,valor,unidade_id,estoque_min,estoque,tem_estoque) VALUES (''01764'',NULL,''26'',''Tanga Micro Amarilis'',NULL,''9.60'',''1'',''9'',NULL,''y'')', '2017-04-26 05:06:14', '192.168.1.244'),
(45, 1, 'INSERT INTO produto (codigo,codbar,categoria_id,nome,descricao,valor,unidade_id,estoque_min,estoque,tem_estoque) VALUES (''02075'',NULL,''26'',''Tanga Fio Bebel'',NULL,''9.99'',''1'',''5'',NULL,''y'')', '2017-04-26 05:06:54', '192.168.1.244'),
(46, 1, 'INSERT INTO produto (codigo,codbar,categoria_id,nome,descricao,valor,unidade_id,estoque_min,estoque,tem_estoque) VALUES (''02085'',NULL,''26'',''Tanga Daiane'',NULL,''11.40'',''1'',''6'',NULL,''y'')', '2017-04-26 05:07:35', '192.168.1.244'),
(47, 1, 'INSERT INTO produto (codigo,codbar,categoria_id,nome,descricao,valor,unidade_id,estoque_min,estoque,tem_estoque) VALUES (''01792'',NULL,''25'',''Sutien 1;2 BojÃ£o Pamela'',NULL,''48.99'',''1'',''6'',NULL,''y'')', '2017-04-26 05:08:32', '192.168.1.244'),
(48, 1, 'INSERT INTO produto (codigo,codbar,categoria_id,nome,descricao,valor,unidade_id,estoque_min,estoque,tem_estoque) VALUES (''00002'',NULL,''23'',''Cueca c/ cos'',NULL,''6.90'',''1'',''3'',NULL,''y'')', '2017-04-26 05:09:19', '192.168.1.244'),
(49, 1, 'INSERT INTO entrada_produto (tipo,produto_id,fornecedor_id,quantidade,lote,dt_compra,dt_validade,valor_unitario,valor_total,motivo_saida) VALUES (''E'',''52'',NULL,''10'',NULL,STR_TO_DATE(''25/04/2017 20:46'', ''%d/%m/%Y %H:%i:%s''),STR_TO_DATE(''25/05/2017'', ''%d/%m/%Y %H:%i:%s''),''6.90'',''69.00'',NULL)', '2017-04-26 05:11:05', '192.168.1.244'),
(50, 1, ' UPDATE produto\n                                               SET estoque = (CASE WHEN estoque IS NULL THEN 10 ELSE (estoque + 10) END)\n                                               WHERE id = ''52'' ', '2017-04-26 05:11:05', '192.168.1.244'),
(51, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (''AT'','''','''','''','''','''','''','''','''','''',''mizaele.matos@gmail.com'')', '2017-04-26 05:16:09', '192.168.1.244'),
(52, 1, 'INSERT INTO funcionario (nome,tipo_us,pessoa_id,login,senha) VALUES (''Misaele Matos'',''N'',''79'',''misaelem'','''')', '2017-04-26 05:16:09', '192.168.1.244'),
(53, 1, '	INSERT INTO acesso ( modulo_id, funcionario_id, nivel_acesso ) VALUES \n					( 1, ''9'', NULL ),\n					( 15, ''9'', NULL ),\n					( 18, ''9'', NULL ) ', '2017-04-26 05:16:09', '192.168.1.244'),
(54, 1, 'UPDATE funcionario SET senha = ''3e764a08c4717e2db982d84f505616ad'' WHERE id = 9', '2017-04-26 05:16:21', '192.168.1.244'),
(55, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (''AT'',''F'','''','''','''','''','''','''','''',''(11) 98156-5348'',''misaele_matos@hotmail.com'')', '2017-04-26 05:17:45', '192.168.1.244'),
(56, 1, 'INSERT INTO fisica (pessoa_id,cpf,nome,rg,sexo,tem_conta,dia_mes_pagto,limite_conta) VALUES (''80'',''361.591.058-33'',''Mizaele '','''','''',''y'',''15'',''100.00'')', '2017-04-26 05:17:45', '192.168.1.244'),
(57, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (''AT'',''J'','''','''','''','''','''','''','''','''',NULL)', '2017-04-26 05:18:32', '192.168.1.244'),
(58, 1, 'INSERT INTO juridica (pessoa_id,cnpj,razao_social,nome_fantasia,inscricao_estadual,ccm) VALUES (''81'',''22.661.263/0001-84'',''Marcos'',''Marcos'',NULL,NULL)', '2017-04-26 05:18:32', '192.168.1.244'),
(59, 1, 'INSERT INTO entrada_produto (tipo,produto_id,fornecedor_id,quantidade,lote,dt_compra,dt_validade,valor_unitario,valor_total,motivo_saida) VALUES (''E'',''49'',''1'',''10'',NULL,STR_TO_DATE(''25/04/2017 20:55'', ''%d/%m/%Y %H:%i:%s''),STR_TO_DATE(''25/05/2017'', ''%d/%m/%Y %H:%i:%s''),''9.80'',''99.99'',NULL)', '2017-04-26 05:21:07', '192.168.1.244'),
(60, 1, ' UPDATE produto\n                                               SET estoque = (CASE WHEN estoque IS NULL THEN 10 ELSE (estoque + 10) END)\n                                               WHERE id = ''49'' ', '2017-04-26 05:21:07', '192.168.1.244'),
(61, 1, 'INSERT INTO entrada_produto (tipo,produto_id,fornecedor_id,quantidade,lote,dt_compra,dt_validade,valor_unitario,valor_total,motivo_saida) VALUES (''E'',''44'',''1'',''12'',NULL,STR_TO_DATE(''25/04/2017 20:57'', ''%d/%m/%Y %H:%i:%s''),STR_TO_DATE(''25/05/2017'', ''%d/%m/%Y %H:%i:%s''),''9.60'',''96.00'',NULL)', '2017-04-26 05:21:52', '192.168.1.244'),
(62, 1, ' UPDATE produto\n                                               SET estoque = (CASE WHEN estoque IS NULL THEN 12 ELSE (estoque + 12) END)\n                                               WHERE id = ''44'' ', '2017-04-26 05:21:52', '192.168.1.244'),
(63, 1, 'INSERT INTO entrada_produto (tipo,produto_id,fornecedor_id,quantidade,lote,dt_compra,dt_validade,valor_unitario,valor_total,motivo_saida) VALUES (''E'',''50'',''1'',''8'',NULL,STR_TO_DATE(''25/04/2017 20:57'', ''%d/%m/%Y %H:%i:%s''),STR_TO_DATE(''25/05/2017'', ''%d/%m/%Y %H:%i:%s''),''11.40'',''120.00'',NULL)', '2017-04-26 05:23:01', '192.168.1.244'),
(64, 1, ' UPDATE produto\n                                               SET estoque = (CASE WHEN estoque IS NULL THEN 8 ELSE (estoque + 8) END)\n                                               WHERE id = ''50'' ', '2017-04-26 05:23:01', '192.168.1.244'),
(65, 1, 'INSERT INTO caixa (valor_inicial,valor_fechamento,funcionario_id) VALUES (''55.00'',NULL,''1'')', '2017-04-26 05:23:26', '192.168.1.244'),
(66, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,NULL,''0'',STR_TO_DATE(''26/04/2017 02:29:00'', ''%d/%m/%Y %H:%i:%s''),''F'',''1'',''35'')', '2017-04-26 05:29:00', '192.168.1.244'),
(67, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (''148'',''50'',''1'',''11.4'')', '2017-04-26 05:29:00', '192.168.1.244'),
(68, 1, 'UPDATE produto SET codigo = ''02085'', categoria_id = ''26'', nome = ''Tanga Daiane'', valor = ''11.40'', unidade_id = ''1'', estoque_min = ''6'', estoque = ''7'', tem_estoque = ''y'' WHERE id = 50', '2017-04-26 05:29:00', '192.168.1.244'),
(69, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (''148'',''52'',''2'',''13.8'')', '2017-04-26 05:29:00', '192.168.1.244'),
(70, 1, 'UPDATE produto SET codigo = ''00002'', categoria_id = ''23'', nome = ''Cueca c/ cos'', valor = ''6.90'', unidade_id = ''1'', estoque_min = ''3'', estoque = ''8'', tem_estoque = ''y'' WHERE id = 52', '2017-04-26 05:29:00', '192.168.1.244'),
(71, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (''148'',''49'',''1'',''9.99'')', '2017-04-26 05:29:00', '192.168.1.244'),
(72, 1, 'UPDATE produto SET codigo = ''02075'', categoria_id = ''26'', nome = ''Tanga Fio Bebel'', valor = ''9.99'', unidade_id = ''1'', estoque_min = ''5'', estoque = ''9'', tem_estoque = ''y'' WHERE id = 49', '2017-04-26 05:29:00', '192.168.1.244'),
(73, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,''0'',''0'',STR_TO_DATE(''26/04/2017 02:30:15'', ''%d/%m/%Y %H:%i:%s''),''F'',''1'',''35'')', '2017-04-26 05:30:15', '192.168.1.244'),
(74, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (''149'',''50'',''1'',''11.4'')', '2017-04-26 05:30:15', '192.168.1.244'),
(75, 1, 'UPDATE produto SET codigo = ''02085'', categoria_id = ''26'', nome = ''Tanga Daiane'', valor = ''11.40'', unidade_id = ''1'', estoque_min = ''6'', estoque = ''6'', tem_estoque = ''y'' WHERE id = 50', '2017-04-26 05:30:15', '192.168.1.244'),
(76, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (''149'',''52'',''2'',''13.8'')', '2017-04-26 05:30:15', '192.168.1.244'),
(77, 1, 'UPDATE produto SET codigo = ''00002'', categoria_id = ''23'', nome = ''Cueca c/ cos'', valor = ''6.90'', unidade_id = ''1'', estoque_min = ''3'', estoque = ''6'', tem_estoque = ''y'' WHERE id = 52', '2017-04-26 05:30:15', '192.168.1.244'),
(78, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (''149'',''49'',''1'',''9.99'')', '2017-04-26 05:30:15', '192.168.1.244'),
(79, 1, 'UPDATE produto SET codigo = ''02075'', categoria_id = ''26'', nome = ''Tanga Fio Bebel'', valor = ''9.99'', unidade_id = ''1'', estoque_min = ''5'', estoque = ''8'', tem_estoque = ''y'' WHERE id = 49', '2017-04-26 05:30:15', '192.168.1.244'),
(80, 1, 'UPDATE venda SET desconto = ''0'', total = ''35.19'', status = ''F'', comanda_mesa_id = ''1'', caixa_id = ''35'' WHERE id = 149', '2017-04-26 05:30:15', '192.168.1.244'),
(81, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,''0'',''0'',STR_TO_DATE(''26/04/2017 02:30:29'', ''%d/%m/%Y %H:%i:%s''),''F'',''1'',''35'')', '2017-04-26 05:30:30', '192.168.1.244'),
(82, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (''150'',''50'',''1'',''11.4'')', '2017-04-26 05:30:30', '192.168.1.244'),
(83, 1, 'UPDATE produto SET codigo = ''02085'', categoria_id = ''26'', nome = ''Tanga Daiane'', valor = ''11.40'', unidade_id = ''1'', estoque_min = ''6'', estoque = ''5'', tem_estoque = ''y'' WHERE id = 50', '2017-04-26 05:30:30', '192.168.1.244'),
(84, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (''150'',''52'',''2'',''13.8'')', '2017-04-26 05:30:30', '192.168.1.244'),
(85, 1, 'UPDATE produto SET codigo = ''00002'', categoria_id = ''23'', nome = ''Cueca c/ cos'', valor = ''6.90'', unidade_id = ''1'', estoque_min = ''3'', estoque = ''4'', tem_estoque = ''y'' WHERE id = 52', '2017-04-26 05:30:30', '192.168.1.244'),
(86, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (''150'',''49'',''1'',''9.99'')', '2017-04-26 05:30:30', '192.168.1.244'),
(87, 1, 'UPDATE produto SET codigo = ''02075'', categoria_id = ''26'', nome = ''Tanga Fio Bebel'', valor = ''9.99'', unidade_id = ''1'', estoque_min = ''5'', estoque = ''7'', tem_estoque = ''y'' WHERE id = 49', '2017-04-26 05:30:30', '192.168.1.244'),
(88, 1, 'UPDATE venda SET desconto = ''0'', total = ''35.19'', status = ''F'', comanda_mesa_id = ''1'', caixa_id = ''35'' WHERE id = 150', '2017-04-26 05:30:30', '192.168.1.244'),
(89, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (''150'',NULL,''1'',''35.19'')', '2017-04-26 05:30:30', '192.168.1.244');

--
-- Extraindo dados da tabela `modulo`
--

INSERT INTO `modulo` (`id`, `text`, `pai`, `statusID`, `link`, `ordem`) VALUES
(1, 'Vender', NULL, '1', '/internals/sell.php', 1),
(2, 'Cadastro', NULL, '1', '', 2),
(3, 'Categorias', 2, '1', '/internals/categorias.php', 3),
(4, 'Produtos', 2, '1', '/internals/produtos.php', 4),
(5, 'Fornecedores', 2, '1', '/internals/pessoas.php', 5),
(6, 'Funcionários', 2, '1', '/internals/funcionarios.php', 6),
(7, 'Clientes', 2, '1', '/internals/clientes.php', 7),
(8, 'Unidades', 2, '1', '/internals/unidades.php', 8),
(9, 'Formas de Pagamento', 2, '1', '/internals/formas.php', 9),
(10, 'Controle de Estoque', NULL, '1', '/internals/estoque.php', 10),
(11, 'Relatórios', NULL, '1', '', 11),
(12, 'Vendas', 11, '1', '/internals/rel_vendas.php', 12),
(13, 'Caixa', 11, '0', '/internals/rel_caixa.php', 13),
(14, 'Configurações', NULL, '1', '', 14),
(15, 'Suporte', NULL, '1', NULL, 16),
(16, 'Ajuda', 15, '1', '/internals/ajuda.php', 17),
(17, 'Atendimento', 15, '1', '/internals/atendimento.php', 18),
(18, 'Alterar Senha', 15, '1', '/internals/alterar_senha.php', 19),
(19, 'Meus Créditos', 15, '1', '/internals/creditos.php', 20),
(20, 'Perfil', 14, '1', '/internals/perfil.php', 15);

--
-- Extraindo dados da tabela `pessoa`
--

INSERT INTO `pessoa` (`id`, `status`, `tipo`, `rua`, `numero`, `bairro`, `cidade`, `uf`, `cep`, `pais`, `telefone`, `email`, `dt_atualizacao`, `dt_cadastro`) VALUES
(1, 'AT', 'F', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'fsd@asdas.com', '2017-04-18 21:48:05', '2017-03-27 20:14:40'),
(79, 'AT', '', '', '', '', '', '', '', '', '', 'mizaele.matos@gmail.com', '2017-04-26 05:16:09', '2017-04-26 05:16:09'),
(80, 'AT', 'F', '', '', '', '', '', '', '', '(11) 98156-5348', 'misaele_matos@hotmail.com', '2017-04-26 05:17:45', '2017-04-26 05:17:45'),
(81, 'AT', 'J', '', '', '', '', '', '', '', '', NULL, '2017-04-26 05:18:32', '2017-04-26 05:18:32');

--
-- Extraindo dados da tabela `produto`
--

INSERT INTO `produto` (`id`, `codigo`, `codbar`, `categoria_id`, `nome`, `descricao`, `valor`, `unidade_id`, `estoque_min`, `estoque`, `tem_estoque`) VALUES
(35, '000829', NULL, 24, 'Cueca Black Jack', '', 18.99, 1, 5, NULL, 'y'),
(36, '00007', '', 24, 'Cueca Box Micro-fibra', '', 18.99, 1, 6, NULL, 'y'),
(42, '00006', NULL, 24, 'Cueca Box Viscolycra', '', 12.99, 1, 4, NULL, 'y'),
(43, '00011', NULL, 23, 'Cueca Malha c/ cos Infantil', '', 4.99, 1, 2, NULL, 'n'),
(44, '01988', NULL, 26, 'Tanga Poa Rosimeire', NULL, 9.60, 1, 8, 12, 'y'),
(45, '020174', NULL, 26, 'Tanga doce encanto', NULL, 9.99, 1, 8, NULL, 'y'),
(46, '00509', NULL, 26, 'Tanga Sheila Micro c/ renda', NULL, 9.60, 1, 8, NULL, 'y'),
(47, '02087', NULL, 26, 'Tanga Marlu', NULL, 10.40, 1, 9, NULL, 'y'),
(48, '01764', NULL, 26, 'Tanga Micro Amarilis', NULL, 9.60, 1, 9, NULL, 'y'),
(49, '02075', NULL, 26, 'Tanga Fio Bebel', NULL, 9.99, 1, 5, 7, 'y'),
(50, '02085', NULL, 26, 'Tanga Daiane', NULL, 11.40, 1, 6, 5, 'y'),
(51, '01792', NULL, 25, 'Sutien 1;2 BojÃ£o Pamela', NULL, 48.99, 1, 6, NULL, 'y'),
(52, '00002', NULL, 23, 'Cueca c/ cos', NULL, 6.90, 1, 3, 4, 'y');

--
-- Extraindo dados da tabela `unidade`
--

INSERT INTO `unidade` (`id`, `descricao`, `active`) VALUES
(1, 'Unidade', 'y'),
(2, 'Livre', 'y'),
(3, 'Kg', 'y');

--
-- Extraindo dados da tabela `venda`
--

INSERT INTO `venda` (`id`, `cliente_id`, `desconto`, `total`, `data`, `status`, `comanda_mesa_id`, `caixa_id`) VALUES
(148, NULL, NULL, 0.00, '2017-04-26 05:29:00', 'F', 1, 35),
(149, NULL, 0.00, 35.19, '2017-04-26 05:30:15', 'F', 1, 35),
(150, NULL, 0.00, 35.19, '2017-04-26 05:30:29', 'F', 1, 35);

--
-- Extraindo dados da tabela `venda_pagto`
--

INSERT INTO `venda_pagto` (`id`, `venda_id`, `fisica_conta_id`, `forma_pagto_id`, `valor`) VALUES
(1, 150, NULL, 1, 35.19);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
