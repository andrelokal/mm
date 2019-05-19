-- --------------------------------------------------------
-- Servidor:                     127.0.0.1
-- Versão do servidor:           10.1.21-MariaDB - mariadb.org binary distribution
-- OS do Servidor:               Win32
-- HeidiSQL Versão:              9.3.0.4984
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Copiando estrutura do banco de dados para mm_bd
CREATE DATABASE IF NOT EXISTS `mm_bd` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `mm_bd`;


-- Copiando estrutura para tabela mm_bd.acesso
CREATE TABLE IF NOT EXISTS `acesso` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modulo_id` int(11) NOT NULL,
  `funcionario_id` int(11) NOT NULL,
  `nivel_acesso` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_acesso_funcionario1_idx` (`funcionario_id`),
  KEY `fk_acesso_modulo1` (`modulo_id`),
  CONSTRAINT `fk_acesso_funcionario1` FOREIGN KEY (`funcionario_id`) REFERENCES `funcionario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_acesso_modulo1` FOREIGN KEY (`modulo_id`) REFERENCES `modulo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela mm_bd.acesso: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `acesso` DISABLE KEYS */;
INSERT INTO `acesso` (`id`, `modulo_id`, `funcionario_id`, `nivel_acesso`) VALUES
	(2, 1, 1, ''),
	(3, 1, 8, NULL),
	(4, 15, 8, NULL),
	(5, 18, 8, NULL);
/*!40000 ALTER TABLE `acesso` ENABLE KEYS */;


-- Copiando estrutura para tabela mm_bd.caixa
CREATE TABLE IF NOT EXISTS `caixa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `valor_inicial` double(7,2) DEFAULT '0.00',
  `valor_fechamento` double(7,2) DEFAULT '0.00',
  `funcionario_id` int(11) NOT NULL DEFAULT '0',
  `dt_abertura` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `dt_fechamento` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_caixa_funcionario` (`funcionario_id`),
  CONSTRAINT `FK_caixa_funcionario` FOREIGN KEY (`funcionario_id`) REFERENCES `funcionario` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela mm_bd.caixa: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `caixa` DISABLE KEYS */;
INSERT INTO `caixa` (`id`, `valor_inicial`, `valor_fechamento`, `funcionario_id`, `dt_abertura`, `dt_fechamento`) VALUES
	(34, 15.20, NULL, 1, '2017-04-19 08:04:46', NULL);
/*!40000 ALTER TABLE `caixa` ENABLE KEYS */;


-- Copiando estrutura para tabela mm_bd.categoria
CREATE TABLE IF NOT EXISTS `categoria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL COMMENT 'label',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela mm_bd.categoria: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` (`id`, `nome`) VALUES
	(3, 'Teste'),
	(4, 'Geral');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;


-- Copiando estrutura para tabela mm_bd.comanda_mesa
CREATE TABLE IF NOT EXISTS `comanda_mesa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(50) NOT NULL,
  `active` enum('y','n') NOT NULL DEFAULT 'y',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela mm_bd.comanda_mesa: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `comanda_mesa` DISABLE KEYS */;
INSERT INTO `comanda_mesa` (`id`, `codigo`, `active`) VALUES
	(1, 'Balcão', 'y');
/*!40000 ALTER TABLE `comanda_mesa` ENABLE KEYS */;


-- Copiando estrutura para tabela mm_bd.config
CREATE TABLE IF NOT EXISTS `config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome_empresa` varchar(50) DEFAULT NULL,
  `desc_cupom` varchar(250) DEFAULT NULL,
  `print_port` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela mm_bd.config: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `config` DISABLE KEYS */;
INSERT INTO `config` (`id`, `nome_empresa`, `desc_cupom`, `print_port`) VALUES
	(1, 'Nome do Comercio LTDA', NULL, NULL);
/*!40000 ALTER TABLE `config` ENABLE KEYS */;


-- Copiando estrutura para tabela mm_bd.entrada_produto
CREATE TABLE IF NOT EXISTS `entrada_produto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` enum('E','S') NOT NULL DEFAULT 'E' COMMENT 'E=Entrada, S=Saida',
  `produto_id` int(11) NOT NULL,
  `fornecedor_id` int(11) DEFAULT NULL,
  `quantidade` decimal(10,0) NOT NULL,
  `lote` varchar(45) DEFAULT NULL,
  `dt_compra` date DEFAULT NULL,
  `dt_validade` date DEFAULT NULL,
  `valor_unitario` decimal(7,2) DEFAULT NULL,
  `valor_total` decimal(7,2) DEFAULT NULL,
  `motivo_saida` text,
  PRIMARY KEY (`id`),
  KEY `fk_entrada_produto_produto1_idx` (`produto_id`),
  KEY `fk_entrada_produto_pessoa1_idx` (`fornecedor_id`),
  CONSTRAINT `fk_entrada_produto_pessoa1` FOREIGN KEY (`fornecedor_id`) REFERENCES `pessoa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_entrada_produto_produto1` FOREIGN KEY (`produto_id`) REFERENCES `produto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela mm_bd.entrada_produto: ~9 rows (aproximadamente)
/*!40000 ALTER TABLE `entrada_produto` DISABLE KEYS */;
INSERT INTO `entrada_produto` (`id`, `tipo`, `produto_id`, `fornecedor_id`, `quantidade`, `lote`, `dt_compra`, `dt_validade`, `valor_unitario`, `valor_total`, `motivo_saida`) VALUES
	(29, 'E', 27, NULL, 10, NULL, '2017-03-29', '2017-03-29', 22.22, 22.22, NULL),
	(30, 'E', 27, NULL, 10, NULL, '2017-03-29', '2017-03-29', 22.22, 22.22, NULL),
	(31, 'E', 27, NULL, 20, NULL, '2017-03-29', '2017-03-29', 11.11, 11.11, NULL),
	(32, 'E', 27, NULL, 20, NULL, '2017-03-31', '2017-03-31', 15.12, 15.42, NULL),
	(33, 'E', 32, NULL, 10, NULL, '2017-03-31', '2017-03-31', 125.12, 12.12, NULL),
	(34, 'E', 27, NULL, 200, NULL, '2017-04-05', '2017-04-05', 2.22, 2.22, NULL),
	(35, 'E', 32, NULL, 45, NULL, '2017-04-06', '2017-04-06', 44.44, 44.44, NULL),
	(37, 'S', 32, NULL, 33, NULL, NULL, NULL, NULL, NULL, 'teste'),
	(38, 'E', 32, NULL, 200, NULL, '2017-04-19', '2017-04-19', 0.24, 2.34, NULL);
/*!40000 ALTER TABLE `entrada_produto` ENABLE KEYS */;


-- Copiando estrutura para tabela mm_bd.fisica
CREATE TABLE IF NOT EXISTS `fisica` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pessoa_id` int(11) NOT NULL,
  `cpf` varchar(20) NOT NULL,
  `nome` varchar(200) NOT NULL COMMENT 'label',
  `rg` varchar(20) DEFAULT NULL,
  `dt_nascimento` date DEFAULT NULL,
  `sexo` varchar(1) DEFAULT NULL COMMENT 'SEXO:\nH=HOMEM\nM=MULHER\n',
  `tem_conta` enum('y','n') DEFAULT 'y',
  `dia_mes_pagto` int(11) DEFAULT NULL,
  `limite_conta` double(7,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cpf_UNIQUE` (`cpf`),
  UNIQUE KEY `pessoa_id_UNIQUE` (`pessoa_id`),
  KEY `fk_fisica_pessoa2_idx` (`pessoa_id`),
  CONSTRAINT `fk_fisica_pessoa2` FOREIGN KEY (`pessoa_id`) REFERENCES `pessoa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela mm_bd.fisica: ~28 rows (aproximadamente)
/*!40000 ALTER TABLE `fisica` DISABLE KEYS */;
INSERT INTO `fisica` (`id`, `pessoa_id`, `cpf`, `nome`, `rg`, `dt_nascimento`, `sexo`, `tem_conta`, `dia_mes_pagto`, `limite_conta`) VALUES
	(2, 31, '301.625.408-50', 'Ulisses Bueno', '', NULL, '', 'y', NULL, 45.00),
	(3, 32, '132.132.132-13', '12321', '', NULL, '', 'n', NULL, NULL),
	(4, 33, '111.111.111-11', 'Teste', '', NULL, '', 'n', NULL, NULL),
	(5, 34, '222.222.222-22', 'test', '', NULL, '', 'n', NULL, NULL),
	(6, 35, '226.126.118-78', 'Andre Viado', '', NULL, '', 'n', NULL, NULL),
	(7, 36, '231.321.321-32', 'Teste', '', NULL, '', 'n', NULL, NULL),
	(8, 37, '346.452.675-58', 'Teste', '', NULL, '', 'n', NULL, NULL),
	(9, 38, '940.247.200-23', 'Teste', '', NULL, '', 'n', NULL, NULL),
	(10, 39, '457.769.167-12', 'Fulano', '', NULL, '', 'n', NULL, NULL),
	(13, 41, '869.454.630-28', 'Fulano', '', NULL, '', 'n', NULL, NULL),
	(14, 42, '968.266.843-30', 'Tatiane Cassia', '', NULL, '', 'n', NULL, NULL),
	(15, 43, '814.472.241-83', 'Teste', '', NULL, '', 'n', NULL, NULL),
	(16, 44, '482.146.185-41', 'Teste', '', NULL, '', 'n', NULL, NULL),
	(17, 45, '541.901.359-25', 'Teste 2', '', NULL, '', 'n', NULL, NULL),
	(18, 49, '480.040.065-15', 'Teste', '', NULL, '', 'n', 5, NULL),
	(19, 50, '233.968.327-01', 'Teste', '', NULL, '', 'n', 5, NULL),
	(20, 51, '578.374.415-83', 'Teste', '', NULL, '', 'n', 5, NULL),
	(21, 52, '152.278.242-74', 'Teste', '', NULL, '', 'n', 5, NULL),
	(22, 53, '376.707.748-51', 'Teste', '', NULL, '', 'n', 5, NULL),
	(23, 54, '988.174.938-72', 'teste', '', NULL, '', 'n', 5, NULL),
	(24, 55, '817.834.548-06', 'teste', '', NULL, '', 'n', 5, NULL),
	(25, 56, '210.354.616-41', 'sdfsd', '', NULL, '', 'n', 5, NULL),
	(28, 59, '887.648.618-64', 'teste', '', NULL, '', 'n', 5, NULL),
	(29, 60, '318.785.342-03', 'teste', '', NULL, '', 'n', 5, NULL),
	(35, 66, '447.024.545-36', 'teste', '', NULL, '', 'n', 5, NULL),
	(37, 68, '286.632.395-56', 'teste', '', NULL, '', 'n', 5, NULL),
	(41, 72, '862.672.633-39', 'teste', '', NULL, '', 'n', 5, NULL),
	(42, 73, '171.672.676-00', 'teste', '', NULL, '', 'n', 5, NULL);
/*!40000 ALTER TABLE `fisica` ENABLE KEYS */;


-- Copiando estrutura para tabela mm_bd.fisica_conta
CREATE TABLE IF NOT EXISTS `fisica_conta` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fisica_id` int(11) NOT NULL,
  `tipo` enum('D','C') NOT NULL,
  `valor` double(7,2) NOT NULL,
  `desconto` int(11) DEFAULT '0',
  `dt_cadastro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `caixa_id` int(11) NOT NULL,
  `venda_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK__fisica` (`fisica_id`),
  KEY `caixa_id` (`caixa_id`),
  KEY `FK_fisica_conta_venda` (`venda_id`),
  CONSTRAINT `FK__fisica` FOREIGN KEY (`fisica_id`) REFERENCES `fisica` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_fisica_conta_venda` FOREIGN KEY (`venda_id`) REFERENCES `venda` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fisica_conta_ibfk_1` FOREIGN KEY (`caixa_id`) REFERENCES `caixa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela mm_bd.fisica_conta: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `fisica_conta` DISABLE KEYS */;
INSERT INTO `fisica_conta` (`id`, `fisica_id`, `tipo`, `valor`, `desconto`, `dt_cadastro`, `caixa_id`, `venda_id`) VALUES
	(31, 2, 'D', 5.00, 0, '2017-04-26 15:38:52', 34, 147);
/*!40000 ALTER TABLE `fisica_conta` ENABLE KEYS */;


-- Copiando estrutura para tabela mm_bd.forma_pagto
CREATE TABLE IF NOT EXISTS `forma_pagto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(200) NOT NULL,
  `active` enum('y','n') DEFAULT NULL,
  `active_c` enum('y','n') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela mm_bd.forma_pagto: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `forma_pagto` DISABLE KEYS */;
INSERT INTO `forma_pagto` (`id`, `nome`, `active`, `active_c`) VALUES
	(1, 'Dinheiro', 'y', 'y'),
	(2, 'Cartao Debito', 'y', 'y'),
	(3, 'Cartao Credito', 'y', 'y'),
	(4, 'Conta Cliente', 'y', 'n');
/*!40000 ALTER TABLE `forma_pagto` ENABLE KEYS */;


-- Copiando estrutura para tabela mm_bd.funcionario
CREATE TABLE IF NOT EXISTS `funcionario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `tipo_us` enum('R','M','N') NOT NULL DEFAULT 'N',
  `pessoa_id` int(11) NOT NULL,
  `login` varchar(50) NOT NULL,
  `senha` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `login_UNIQUE` (`login`),
  KEY `fk_funcionario_pessoa1_idx` (`pessoa_id`),
  CONSTRAINT `fk_funcionario_pessoa1` FOREIGN KEY (`pessoa_id`) REFERENCES `pessoa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela mm_bd.funcionario: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `funcionario` DISABLE KEYS */;
INSERT INTO `funcionario` (`id`, `nome`, `tipo_us`, `pessoa_id`, `login`, `senha`) VALUES
	(1, 'Ulisses Bueno', 'M', 1, 'ulisses', '0dd1219bf2c236a83bc362ffcdb02b50'),
	(3, 'Teste', 'N', 47, 'teste', '698dc19d489c4e4db73e28a713eab07b'),
	(8, 'teste', 'N', 77, 'func', '698dc19d489c4e4db73e28a713eab07b');
/*!40000 ALTER TABLE `funcionario` ENABLE KEYS */;


-- Copiando estrutura para tabela mm_bd.funcionario_priv
CREATE TABLE IF NOT EXISTS `funcionario_priv` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `funcionario_id` int(11) NOT NULL DEFAULT '0',
  `priv_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_funcionario_priv_funcionario` (`funcionario_id`),
  KEY `FK_funcionario_priv_modulo_priv` (`priv_id`),
  CONSTRAINT `FK_funcionario_priv_funcionario` FOREIGN KEY (`funcionario_id`) REFERENCES `funcionario` (`id`),
  CONSTRAINT `FK_funcionario_priv_modulo_priv` FOREIGN KEY (`priv_id`) REFERENCES `modulo_priv` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela mm_bd.funcionario_priv: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `funcionario_priv` DISABLE KEYS */;
/*!40000 ALTER TABLE `funcionario_priv` ENABLE KEYS */;


-- Copiando estrutura para tabela mm_bd.help
CREATE TABLE IF NOT EXISTS `help` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(250) NOT NULL,
  `description` mediumtext NOT NULL,
  `modulo_id` int(11) NOT NULL,
  `order` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_help_modulo` (`modulo_id`),
  CONSTRAINT `FK_help_modulo` FOREIGN KEY (`modulo_id`) REFERENCES `modulo` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela mm_bd.help: ~7 rows (aproximadamente)
/*!40000 ALTER TABLE `help` DISABLE KEYS */;
INSERT INTO `help` (`id`, `title`, `description`, `modulo_id`, `order`) VALUES
	(1, 'Introdução', 'Bem vindo ao Magazine Manager System!', 16, 1),
	(3, 'Primeiros Passos', 'A primeira coisa à fazer é cadastrar os dados necessários para criar seu catálogo de produtos. Para isso é preciso categorizar os produtos.', 16, 2),
	(4, 'Categorias', '...', 3, 3),
	(5, 'Produtos', '...', 4, 4),
	(6, 'Controle de Estoque', '...', 10, 5),
	(8, 'Venda de Produtos', '...', 1, 6),
	(10, 'Testão', '', 1, 0);
/*!40000 ALTER TABLE `help` ENABLE KEYS */;


-- Copiando estrutura para tabela mm_bd.help_item
CREATE TABLE IF NOT EXISTS `help_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `help_id` int(11) NOT NULL,
  `title_item` varchar(250) NOT NULL,
  `resume` varchar(100) NOT NULL,
  `description_item` mediumtext NOT NULL,
  `order_item` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_help_item_help` (`help_id`),
  CONSTRAINT `FK_help_item_help` FOREIGN KEY (`help_id`) REFERENCES `help` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela mm_bd.help_item: ~15 rows (aproximadamente)
/*!40000 ALTER TABLE `help_item` DISABLE KEYS */;
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
/*!40000 ALTER TABLE `help_item` ENABLE KEYS */;


-- Copiando estrutura para tabela mm_bd.itens_venda
CREATE TABLE IF NOT EXISTS `itens_venda` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `venda_id` int(11) NOT NULL,
  `produto_id` int(11) NOT NULL,
  `quantidade` double(7,2) DEFAULT NULL,
  `valor_unitario` decimal(7,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_itens_venda_venda1_idx` (`venda_id`),
  KEY `fk_itens_venda_produto1_idx` (`produto_id`),
  CONSTRAINT `fk_itens_venda_produto1` FOREIGN KEY (`produto_id`) REFERENCES `produto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_itens_venda_venda1` FOREIGN KEY (`venda_id`) REFERENCES `venda` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela mm_bd.itens_venda: ~10 rows (aproximadamente)
/*!40000 ALTER TABLE `itens_venda` DISABLE KEYS */;
INSERT INTO `itens_venda` (`id`, `venda_id`, `produto_id`, `quantidade`, `valor_unitario`) VALUES
	(1, 138, 27, 1.00, 5.00),
	(2, 139, 27, 1.00, 5.00),
	(3, 140, 27, 1.00, 5.00),
	(4, 141, 32, 1.00, 15.21),
	(5, 142, 27, 5.00, 25.00),
	(6, 143, 33, 0.35, 11.20),
	(7, 144, 27, 2.00, 10.00),
	(8, 145, 27, 1.00, 5.00),
	(9, 146, 27, 1.00, 5.00),
	(10, 147, 27, 1.00, 5.00);
/*!40000 ALTER TABLE `itens_venda` ENABLE KEYS */;


-- Copiando estrutura para tabela mm_bd.juridica
CREATE TABLE IF NOT EXISTS `juridica` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pessoa_id` int(11) NOT NULL,
  `cnpj` varchar(100) NOT NULL,
  `razao_social` varchar(200) NOT NULL,
  `nome_fantasia` varchar(200) NOT NULL COMMENT 'label',
  `inscricao_estadual` varchar(100) DEFAULT NULL,
  `ccm` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cnpj_UNIQUE` (`cnpj`),
  UNIQUE KEY `pessoa_id_UNIQUE` (`pessoa_id`),
  KEY `fk_juridica_pessoa2_idx` (`pessoa_id`),
  CONSTRAINT `fk_juridica_pessoa2` FOREIGN KEY (`pessoa_id`) REFERENCES `pessoa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela mm_bd.juridica: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `juridica` DISABLE KEYS */;
INSERT INTO `juridica` (`id`, `pessoa_id`, `cnpj`, `razao_social`, `nome_fantasia`, `inscricao_estadual`, `ccm`) VALUES
	(1, 78, '55.073.636/0001-55', 'teste', 'Teste', NULL, NULL);
/*!40000 ALTER TABLE `juridica` ENABLE KEYS */;


-- Copiando estrutura para tabela mm_bd.log
CREATE TABLE IF NOT EXISTS `log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` int(11) NOT NULL,
  `log` longtext NOT NULL,
  `data` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `ip` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=710 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela mm_bd.log: ~704 rows (aproximadamente)
/*!40000 ALTER TABLE `log` DISABLE KEYS */;
INSERT INTO `log` (`id`, `user`, `log`, `data`, `ip`) VALUES
	(1, 1, 'INSERT INTO categoria (nome) VALUES (\'Teste\')', '2017-03-28 15:21:28', '127.0.0.1'),
	(2, 1, 'UPDATE categoria SET nome = \'Teste\' WHERE id = 3', '2017-03-28 15:22:17', '127.0.0.1'),
	(3, 1, 'UPDATE categoria SET nome = \'Teste\' WHERE id = 3', '2017-03-28 15:39:00', '127.0.0.1'),
	(4, 1, 'INSERT INTO produto (codigo,codbar,categoria_id,nome,descricao,valor,unidade_id,estoque_min,estoque,tem_estoque) VALUES (\'001\',\'\',\'3\',\'Teste\',NULL,\'5.00\',\'1\',NULL,\'\',\'y\')', '2017-03-28 15:39:30', '127.0.0.1'),
	(5, 1, 'INSERT INTO entrada_produto (tipo,produto_id,fornecedor_id,quantidade,lote,dt_compra,dt_validade,valor_unitario,valor_total,motivo_saida) VALUES (\'E\',\'27\',NULL,\'10\',NULL,STR_TO_DATE(\'29/03/2017 07:59\', \'%d/%m/%Y %H:%i:%s\'),STR_TO_DATE(\'29/03/2017\', \'%d/%m/%Y %H:%i:%s\'),\'22.22\',\'22.22\',NULL)', '2017-03-29 07:59:45', '127.0.0.1'),
	(6, 1, '', '2017-03-29 07:59:45', '127.0.0.1'),
	(7, 1, 'INSERT INTO entrada_produto (tipo,produto_id,fornecedor_id,quantidade,lote,dt_compra,dt_validade,valor_unitario,valor_total,motivo_saida) VALUES (\'E\',\'27\',NULL,\'10\',NULL,STR_TO_DATE(\'29/03/2017 07:59\', \'%d/%m/%Y %H:%i:%s\'),STR_TO_DATE(\'29/03/2017\', \'%d/%m/%Y %H:%i:%s\'),\'22.22\',\'22.22\',NULL)', '2017-03-29 07:59:51', '127.0.0.1'),
	(8, 1, '', '2017-03-29 07:59:51', '127.0.0.1'),
	(9, 1, 'INSERT INTO entrada_produto (tipo,produto_id,fornecedor_id,quantidade,lote,dt_compra,dt_validade,valor_unitario,valor_total,motivo_saida) VALUES (\'E\',\'27\',NULL,\'20\',NULL,STR_TO_DATE(\'29/03/2017 08:01\', \'%d/%m/%Y %H:%i:%s\'),STR_TO_DATE(\'29/03/2017\', \'%d/%m/%Y %H:%i:%s\'),\'11.11\',\'11.11\',NULL)', '2017-03-29 08:01:32', '127.0.0.1'),
	(10, 1, ' UPDATE produto\r\n                                               SET estoque = (CASE WHEN estoque IS NULL THEN 20 ELSE (estoque + 20) END)\r\n                                               WHERE id = \'27\' ', '2017-03-29 08:01:32', '127.0.0.1'),
	(11, 1, 'INSERT INTO categoria (nome) VALUES (\'\')', '2017-03-29 08:58:34', '127.0.0.1'),
	(12, 1, 'INSERT INTO categoria (nome) VALUES (\'\')', '2017-03-29 08:59:11', '127.0.0.1'),
	(13, 1, 'INSERT INTO caixa (valor_inicial,funcionario_id) VALUES (\'54.00\',\'1\')', '2017-03-29 09:03:21', '127.0.0.1'),
	(14, 1, 'INSERT INTO caixa (valor_inicial,funcionario_id) VALUES (\'54.12\',\'1\')', '2017-03-29 09:04:27', '127.0.0.1'),
	(15, 1, 'INSERT INTO caixa (valor_inicial,funcionario_id) VALUES (\'54.85\',\'1\')', '2017-03-29 09:06:54', '127.0.0.1'),
	(16, 1, 'INSERT INTO caixa (valor_inicial,funcionario_id) VALUES (\'46.54\',\'1\')', '2017-03-29 09:10:00', '127.0.0.1'),
	(17, 1, 'INSERT INTO caixa (valor_inicial,funcionario_id) VALUES (\'546.54\',\'1\')', '2017-03-29 09:11:00', '127.0.0.1'),
	(18, 1, 'INSERT INTO caixa (valor_inicial,funcionario_id) VALUES (\'546.54\',\'1\')', '2017-03-29 09:12:18', '127.0.0.1'),
	(19, 1, 'INSERT INTO caixa (valor_inicial,funcionario_id) VALUES (\'54.21\',\'1\')', '2017-03-29 09:18:28', '127.0.0.1'),
	(20, 1, 'INSERT INTO caixa (valor_inicial,valor_fechamento,funcionario_id) VALUES (\'54.87\',\'\',\'1\')', '2017-03-29 09:46:58', '127.0.0.1'),
	(21, 1, 'INSERT INTO caixa (valor_inicial,valor_fechamento,funcionario_id) VALUES (\'454.87\',\'\',\'1\')', '2017-03-29 09:55:04', '127.0.0.1'),
	(22, 1, 'INSERT INTO caixa (valor_inicial,valor_fechamento,funcionario_id) VALUES (\'45.47\',\'\',\'1\')', '2017-03-29 09:55:36', '127.0.0.1'),
	(23, 1, 'INSERT INTO caixa (valor_inicial,valor_fechamento,funcionario_id) VALUES (\'4.57\',\'\',\'1\')', '2017-03-29 10:17:10', '127.0.0.1'),
	(24, 1, 'INSERT INTO caixa (valor_inicial,valor_fechamento,funcionario_id) VALUES (\'54.87\',\'\',\'1\')', '2017-03-29 10:17:39', '127.0.0.1'),
	(25, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'29/03/2017 10:18:11\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'13\')', '2017-03-29 10:18:12', '127.0.0.1'),
	(26, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'70\',\'27\',\'2\',\'10\')', '2017-03-29 10:18:12', '127.0.0.1'),
	(27, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'38\', tem_estoque = \'y\' WHERE id = 27', '2017-03-29 10:18:12', '127.0.0.1'),
	(28, 1, 'UPDATE venda SET desconto = \'0\', total = \'10\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'13\' WHERE id = 70', '2017-03-29 10:18:12', '127.0.0.1'),
	(29, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'29/03/2017 10:37:08\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'13\')', '2017-03-29 10:37:08', '127.0.0.1'),
	(30, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'71\',\'27\',\'2\',\'10\')', '2017-03-29 10:37:09', '127.0.0.1'),
	(31, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'36\', tem_estoque = \'y\' WHERE id = 27', '2017-03-29 10:37:09', '127.0.0.1'),
	(32, 1, 'UPDATE venda SET desconto = \'0\', total = \'10\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'13\' WHERE id = 71', '2017-03-29 10:37:09', '127.0.0.1'),
	(33, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'30/03/2017 13:03:54\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'13\')', '2017-03-30 13:03:54', '127.0.0.1'),
	(34, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'72\',\'27\',\'6\',\'30\')', '2017-03-30 13:03:55', '127.0.0.1'),
	(35, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'30\', tem_estoque = \'y\' WHERE id = 27', '2017-03-30 13:03:56', '127.0.0.1'),
	(36, 1, 'UPDATE venda SET desconto = \'0\', total = \'30\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'13\' WHERE id = 72', '2017-03-30 13:03:56', '127.0.0.1'),
	(37, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'30/03/2017 13:05:48\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'13\')', '2017-03-30 13:05:49', '127.0.0.1'),
	(38, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'73\',\'27\',\'1\',\'5\')', '2017-03-30 13:05:49', '127.0.0.1'),
	(39, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'29\', tem_estoque = \'y\' WHERE id = 27', '2017-03-30 13:05:49', '127.0.0.1'),
	(40, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'13\' WHERE id = 73', '2017-03-30 13:05:50', '127.0.0.1'),
	(41, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'30/03/2017 14:06:10\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'13\')', '2017-03-30 14:06:11', '127.0.0.1'),
	(42, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'74\',\'27\',\'2\',\'10\')', '2017-03-30 14:06:12', '127.0.0.1'),
	(43, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'27\', tem_estoque = \'y\' WHERE id = 27', '2017-03-30 14:06:12', '127.0.0.1'),
	(44, 1, 'UPDATE venda SET desconto = \'0\', total = \'10\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'13\' WHERE id = 74', '2017-03-30 14:06:12', '127.0.0.1'),
	(45, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'30/03/2017 14:58:15\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'13\')', '2017-03-30 14:58:15', '127.0.0.1'),
	(46, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'75\',\'27\',\'1\',\'5\')', '2017-03-30 14:58:15', '127.0.0.1'),
	(47, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'26\', tem_estoque = \'y\' WHERE id = 27', '2017-03-30 14:58:15', '127.0.0.1'),
	(48, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'13\' WHERE id = 75', '2017-03-30 14:58:15', '127.0.0.1'),
	(49, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'30/03/2017 14:59:55\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'13\')', '2017-03-30 14:59:55', '127.0.0.1'),
	(50, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'76\',\'27\',\'1\',\'5\')', '2017-03-30 14:59:56', '127.0.0.1'),
	(51, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'25\', tem_estoque = \'y\' WHERE id = 27', '2017-03-30 14:59:56', '127.0.0.1'),
	(52, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'13\' WHERE id = 76', '2017-03-30 14:59:56', '127.0.0.1'),
	(53, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0.00\',\'0\',STR_TO_DATE(\'31/03/2017 15:46:46\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'13\')', '2017-03-31 15:46:47', '127.0.0.1'),
	(54, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'77\',\'27\',\'5\',\'25\')', '2017-03-31 15:46:48', '127.0.0.1'),
	(55, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'20\', tem_estoque = \'y\' WHERE id = 27', '2017-03-31 15:46:48', '127.0.0.1'),
	(56, 1, 'UPDATE venda SET desconto = \'0.00\', total = \'25\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'13\' WHERE id = 77', '2017-03-31 15:46:48', '127.0.0.1'),
	(57, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0.00\',\'0\',STR_TO_DATE(\'31/03/2017 16:03:39\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'13\')', '2017-03-31 16:03:39', '127.0.0.1'),
	(58, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'78\',\'27\',\'4\',\'20\')', '2017-03-31 16:03:40', '127.0.0.1'),
	(59, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'16\', tem_estoque = \'y\' WHERE id = 27', '2017-03-31 16:03:40', '127.0.0.1'),
	(60, 1, 'UPDATE venda SET desconto = \'0.00\', total = \'20\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'13\' WHERE id = 78', '2017-03-31 16:03:40', '127.0.0.1'),
	(61, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0.00\',\'0\',STR_TO_DATE(\'31/03/2017 16:04:07\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'13\')', '2017-03-31 16:04:07', '127.0.0.1'),
	(62, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'79\',\'27\',\'1\',\'5\')', '2017-03-31 16:04:08', '127.0.0.1'),
	(63, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'15\', tem_estoque = \'y\' WHERE id = 27', '2017-03-31 16:04:08', '127.0.0.1'),
	(64, 1, 'UPDATE venda SET desconto = \'0.00\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'13\' WHERE id = 79', '2017-03-31 16:04:08', '127.0.0.1'),
	(65, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0.00\',\'0\',STR_TO_DATE(\'31/03/2017 16:05:17\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'13\')', '2017-03-31 16:05:17', '127.0.0.1'),
	(66, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'80\',\'27\',\'1\',\'5\')', '2017-03-31 16:05:17', '127.0.0.1'),
	(67, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'14\', tem_estoque = \'y\' WHERE id = 27', '2017-03-31 16:05:17', '127.0.0.1'),
	(68, 1, 'UPDATE venda SET desconto = \'0.00\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'13\' WHERE id = 80', '2017-03-31 16:05:18', '127.0.0.1'),
	(69, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0.00\',\'0\',STR_TO_DATE(\'31/03/2017 16:11:08\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'13\')', '2017-03-31 16:11:09', '127.0.0.1'),
	(70, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'81\',\'27\',\'1\',\'5\')', '2017-03-31 16:11:09', '127.0.0.1'),
	(71, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'13\', tem_estoque = \'y\' WHERE id = 27', '2017-03-31 16:11:09', '127.0.0.1'),
	(72, 1, 'UPDATE venda SET desconto = \'0.00\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'13\' WHERE id = 81', '2017-03-31 16:11:09', '127.0.0.1'),
	(73, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0.00\',\'0\',STR_TO_DATE(\'31/03/2017 16:23:03\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'13\')', '2017-03-31 16:23:03', '127.0.0.1'),
	(74, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'82\',\'27\',\'14\',\'70\')', '2017-03-31 16:23:04', '127.0.0.1'),
	(75, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'-1\', tem_estoque = \'y\' WHERE id = 27', '2017-03-31 16:23:04', '127.0.0.1'),
	(76, 1, 'UPDATE venda SET desconto = \'0.00\', total = \'70\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'13\' WHERE id = 82', '2017-03-31 16:23:05', '127.0.0.1'),
	(77, 1, 'INSERT INTO entrada_produto (tipo,produto_id,fornecedor_id,quantidade,lote,dt_compra,dt_validade,valor_unitario,valor_total,motivo_saida) VALUES (\'E\',\'27\',NULL,\'20\',NULL,STR_TO_DATE(\'31/03/2017 16:24\', \'%d/%m/%Y %H:%i:%s\'),STR_TO_DATE(\'31/03/2017\', \'%d/%m/%Y %H:%i:%s\'),\'15.12\',\'15.42\',NULL)', '2017-03-31 16:24:41', '127.0.0.1'),
	(78, 1, ' UPDATE produto\r\n                                               SET estoque = (CASE WHEN estoque IS NULL THEN 20 ELSE (estoque + 20) END)\r\n                                               WHERE id = \'27\' ', '2017-03-31 16:24:42', '127.0.0.1'),
	(79, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0.00\',\'0\',STR_TO_DATE(\'31/03/2017 16:58:02\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'13\')', '2017-03-31 16:58:03', '127.0.0.1'),
	(80, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'83\',\'27\',\'4\',\'20\')', '2017-03-31 16:58:03', '127.0.0.1'),
	(81, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'15\', tem_estoque = \'y\' WHERE id = 27', '2017-03-31 16:58:03', '127.0.0.1'),
	(82, 1, 'UPDATE venda SET desconto = \'0.00\', total = \'20\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'13\' WHERE id = 83', '2017-03-31 16:58:03', '127.0.0.1'),
	(83, 1, 'INSERT INTO produto (codigo,codbar,categoria_id,nome,descricao,valor,unidade_id,estoque_min,estoque,tem_estoque) VALUES (\'003\',NULL,\'3\',\'Produto 2\',NULL,\'15.21\',\'1\',NULL,NULL,\'y\')', '2017-03-31 17:02:57', '127.0.0.1'),
	(84, 1, 'INSERT INTO entrada_produto (tipo,produto_id,fornecedor_id,quantidade,lote,dt_compra,dt_validade,valor_unitario,valor_total,motivo_saida) VALUES (\'E\',\'32\',NULL,\'10\',NULL,STR_TO_DATE(\'31/03/2017 00:00\', \'%d/%m/%Y %H:%i:%s\'),STR_TO_DATE(\'31/03/2017\', \'%d/%m/%Y %H:%i:%s\'),\'125.12\',\'12.12\',NULL)', '2017-03-31 17:03:16', '127.0.0.1'),
	(85, 1, ' UPDATE produto\r\n                                               SET estoque = (CASE WHEN estoque IS NULL THEN 10 ELSE (estoque + 10) END)\r\n                                               WHERE id = \'32\' ', '2017-03-31 17:03:16', '127.0.0.1'),
	(86, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'F\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(11) 11111-1111\',\'ulisses.bueno@gmail.com\')', '2017-04-03 09:25:21', '127.0.0.1'),
	(87, 1, 'INSERT INTO fisica (pessoa_id,cpf,nome,rg,sexo) VALUES (\'31\',\'301.625.408-50\',\'Ulisses\',\'\',\'\')', '2017-04-03 09:25:22', '127.0.0.1'),
	(88, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'04/04/2017 08:51:55\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'13\')', '2017-04-04 08:51:55', '127.0.0.1'),
	(89, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'84\',\'32\',\'3\',\'45.63\')', '2017-04-04 08:51:56', '127.0.0.1'),
	(90, 1, 'UPDATE produto SET codigo = \'003\', categoria_id = \'3\', nome = \'Produto 2\', valor = \'15.21\', unidade_id = \'1\', estoque = \'7\', tem_estoque = \'y\' WHERE id = 32', '2017-04-04 08:51:56', '127.0.0.1'),
	(91, 1, 'UPDATE itens_venda SET venda_id = \'84\', produto_id = \'27\', quantidade = \'1\', valor_unitario = \'5\' WHERE id = 33', '2017-04-04 08:51:56', '127.0.0.1'),
	(92, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'14\', tem_estoque = \'y\' WHERE id = 27', '2017-04-04 08:51:56', '127.0.0.1'),
	(93, 1, 'UPDATE venda SET desconto = \'0\', total = \'50.63\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'13\' WHERE id = 84', '2017-04-04 08:51:56', '127.0.0.1'),
	(94, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(32) 13213-2132\',\'321321\')', '2017-04-04 11:45:56', '127.0.0.1'),
	(95, 1, 'INSERT INTO fisica (pessoa_id,cpf,nome,rg,sexo) VALUES (\'32\',\'132.132.132-13\',\'12321\',\'\',\'\')', '2017-04-04 11:45:56', '127.0.0.1'),
	(96, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(12) 13213-2132\',\'teste@gadsc.com\')', '2017-04-04 13:19:16', '127.0.0.1'),
	(97, 1, 'INSERT INTO fisica (pessoa_id,cpf,nome,rg,sexo) VALUES (\'33\',\'111.111.111-11\',\'Teste\',\'\',\'\')', '2017-04-04 13:19:16', '127.0.0.1'),
	(98, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(11) 11111-1111\',\'er@sdsd.com\')', '2017-04-04 13:20:12', '127.0.0.1'),
	(99, 1, 'INSERT INTO fisica (pessoa_id,cpf,nome,rg,sexo) VALUES (\'34\',\'222.222.222-22\',\'test\',\'\',\'\')', '2017-04-04 13:20:12', '127.0.0.1'),
	(100, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(66) 66666-6666\',\'andre\')', '2017-04-04 14:07:36', '127.0.0.1'),
	(101, 1, 'INSERT INTO fisica (pessoa_id,cpf,nome,rg,sexo) VALUES (\'35\',\'226.126.118-78\',\'Andre Viado\',\'\',\'\')', '2017-04-04 14:07:37', '127.0.0.1'),
	(102, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(11) 11111-1111\',\'terrete\')', '2017-04-04 17:29:01', '127.0.0.1'),
	(103, 1, 'INSERT INTO fisica (pessoa_id,cpf,nome,rg,sexo) VALUES (\'36\',\'231.321.321-32\',\'Teste\',\'\',\'\')', '2017-04-04 17:29:01', '127.0.0.1'),
	(104, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(55) 55555-5555\',\'teste\')', '2017-04-04 17:30:44', '127.0.0.1'),
	(105, 1, 'INSERT INTO fisica (pessoa_id,cpf,nome,rg,sexo) VALUES (\'37\',\'346.452.675-58\',\'Teste\',\'\',\'\')', '2017-04-04 17:30:44', '127.0.0.1'),
	(106, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(88) 88888-8888\',\'teste@teste.com.br\')', '2017-04-04 17:36:21', '127.0.0.1'),
	(107, 1, 'INSERT INTO fisica (pessoa_id,cpf,nome,rg,sexo) VALUES (\'38\',\'940.247.200-23\',\'Teste\',\'\',\'\')', '2017-04-04 17:36:21', '127.0.0.1'),
	(108, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(88) 88888-8888\',\'teste@teste.com.br\')', '2017-04-04 17:38:37', '127.0.0.1'),
	(109, 1, 'INSERT INTO fisica (pessoa_id,cpf,nome,rg,sexo) VALUES (\'39\',\'457.769.167-12\',\'Fulano\',\'\',\'\')', '2017-04-04 17:38:37', '127.0.0.1'),
	(110, 1, 'UPDATE pessoa SET status = \'AT\', telefone = \'(22) 2222-2222\', email = \'ulisses.bueno@gmail.com\' WHERE id = 2', '2017-04-05 08:20:48', '127.0.0.1'),
	(111, 1, 'UPDATE pessoa SET status = \'AT\', telefone = \'(33) 33333-3333\', email = \'ulisses.bueno@gmail.com\' WHERE id = 2', '2017-04-05 08:20:58', '127.0.0.1'),
	(112, 1, 'UPDATE pessoa SET status = \'AT\', telefone = \'(33) 33333-3333\', email = \'ulisses.bueno@gmail.com\' WHERE id = 2', '2017-04-05 08:24:47', '127.0.0.1'),
	(113, 1, 'UPDATE fisica SET cpf = \'301.625.408-50\', nome = \'Ulisses\' WHERE id = 2', '2017-04-05 08:40:15', '127.0.0.1'),
	(114, 1, 'UPDATE fisica SET cpf = \'301.625.408-50\', nome = \'Ulisses\' WHERE id = 2', '2017-04-05 08:40:48', '127.0.0.1'),
	(115, 1, 'UPDATE fisica SET cpf = \'301.625.408-50\', nome = \'Ulisses\' WHERE id = 2', '2017-04-05 08:40:59', '127.0.0.1'),
	(116, 1, 'UPDATE fisica SET cpf = \'301.625.408-50\', nome = \'Ulisses\' WHERE id = 2', '2017-04-05 08:41:02', '127.0.0.1'),
	(117, 1, 'UPDATE fisica SET cpf = \'301.625.408-50\', nome = \'Ulisses\' WHERE id = 2', '2017-04-05 08:41:04', '127.0.0.1'),
	(118, 1, 'UPDATE fisica SET cpf = \'301.625.408-50\', nome = \'Ulisses\' WHERE id = 2', '2017-04-05 08:41:05', '127.0.0.1'),
	(119, 1, 'UPDATE fisica SET cpf = \'301.625.408-50\', nome = \'Ulisses\' WHERE id = 2', '2017-04-05 08:49:41', '127.0.0.1'),
	(120, 1, 'UPDATE fisica SET cpf = \'301.625.408-50\', nome = \'Ulisses\' WHERE id = 2', '2017-04-05 08:54:41', '127.0.0.1'),
	(121, 1, 'UPDATE fisica SET cpf = \'301.625.408-50\', nome = \'Ulisses\' WHERE id = 2', '2017-04-05 08:56:45', '127.0.0.1'),
	(122, 1, 'UPDATE fisica SET cpf = \'301.625.408-50\', nome = \'Ulisses\' WHERE id = 2', '2017-04-05 08:57:49', '127.0.0.1'),
	(123, 1, 'UPDATE fisica SET cpf = \'301.625.408-50\', nome = \'Ulisses Bueno\' WHERE id = 2', '2017-04-05 09:03:37', '127.0.0.1'),
	(124, 1, 'UPDATE pessoa SET status = \'AT\', tipo = \'\', telefone = \'(66) 66666-6666\', email = \'andre@viado.com.br\' WHERE id = 35', '2017-04-05 09:06:44', '127.0.0.1'),
	(125, 1, 'UPDATE fisica SET pessoa_id = \'35\', cpf = \'226.126.118-78\', nome = \'Andre Viado\' WHERE id = 6', '2017-04-05 09:06:44', '127.0.0.1'),
	(126, 1, 'UPDATE forma_pagto SET active = \'n\' WHERE id = 3', '2017-04-05 09:07:47', '127.0.0.1'),
	(127, 1, 'UPDATE forma_pagto SET active = \'y\' WHERE id = 3', '2017-04-05 09:11:04', '127.0.0.1'),
	(128, 1, 'UPDATE fisica SET cpf = \'301.625.408-50\', nome = \'Ulisses Bueno\' WHERE id = 2', '2017-04-05 09:36:25', '127.0.0.1'),
	(129, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(55) 55555-5555\',\'email@email.com\')', '2017-04-05 09:41:04', '127.0.0.1'),
	(130, 1, 'INSERT INTO fisica (pessoa_id,cpf,nome,rg,sexo) VALUES (\'40\',\'869.454.630-28\',\'Fulano\',\'\',\'\')', '2017-04-05 09:41:04', '127.0.0.1'),
	(131, 1, 'UPDATE pessoa SET status = \'AT\', telefone = \'(66) 66666-6666\', email = \'email@email.com\' WHERE id = 13', '2017-04-05 09:42:29', '127.0.0.1'),
	(132, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(66) 66666-6666\',\'email@email.com\')', '2017-04-05 09:48:09', '127.0.0.1'),
	(133, 1, 'UPDATE fisica SET pessoa_id = \'41\', cpf = \'869.454.630-28\', nome = \'Fulano\' WHERE id = 13', '2017-04-05 09:48:09', '127.0.0.1'),
	(134, 1, 'UPDATE pessoa SET status = \'AT\', telefone = \'(66) 66666-6666\', email = \'email@email.com\' WHERE id = 41', '2017-04-05 09:48:25', '127.0.0.1'),
	(135, 1, 'UPDATE fisica SET pessoa_id = \'41\', cpf = \'869.454.630-28\', nome = \'Fulano\' WHERE id = 13', '2017-04-05 09:48:25', '127.0.0.1'),
	(136, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(32) 13213-2132\',\'fsf@dfsdf.com\')', '2017-04-05 09:48:56', '127.0.0.1'),
	(137, 1, 'INSERT INTO fisica (pessoa_id,cpf,nome,rg,sexo) VALUES (\'42\',\'968.266.843-30\',\'Tatiane\',\'\',\'\')', '2017-04-05 09:48:56', '127.0.0.1'),
	(138, 1, 'UPDATE pessoa SET status = \'AT\', telefone = \'(32) 13213-2132\', email = \'fsf@dfsdf.com\' WHERE id = 42', '2017-04-05 09:51:37', '127.0.0.1'),
	(139, 1, 'UPDATE fisica SET pessoa_id = \'42\', cpf = \'968.266.843-30\', nome = \'Tatiane Cassia\' WHERE id = 14', '2017-04-05 09:51:37', '127.0.0.1'),
	(140, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(88) 88888-8888\',\'sfsd@sds.com\')', '2017-04-05 09:52:08', '127.0.0.1'),
	(141, 1, 'INSERT INTO fisica (pessoa_id,cpf,nome,rg,sexo) VALUES (\'43\',\'814.472.241-83\',\'Teste\',\'\',\'\')', '2017-04-05 09:52:08', '127.0.0.1'),
	(142, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(99) 99999-9999\',\'dfsd@sdfsd.com\')', '2017-04-05 09:53:35', '127.0.0.1'),
	(143, 1, 'INSERT INTO fisica (pessoa_id,cpf,nome,rg,sexo) VALUES (\'44\',\'482.146.185-41\',\'Teste\',\'\',\'\')', '2017-04-05 09:53:35', '127.0.0.1'),
	(144, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(99) 99999-9999\',\'dsfsd@adas.com\')', '2017-04-05 09:58:04', '127.0.0.1'),
	(145, 1, 'INSERT INTO fisica (pessoa_id,cpf,nome,rg,sexo) VALUES (\'45\',\'541.901.359-25\',\'Teste\',\'\',\'\')', '2017-04-05 09:58:04', '127.0.0.1'),
	(146, 1, 'UPDATE pessoa SET status = \'AT\', telefone = \'(99) 99999-9999\', email = \'dsfsd@adas.com\' WHERE id = 45', '2017-04-05 09:58:20', '127.0.0.1'),
	(147, 1, 'UPDATE fisica SET pessoa_id = \'45\', cpf = \'541.901.359-25\', nome = \'Teste 1\' WHERE id = 17', '2017-04-05 09:58:20', '127.0.0.1'),
	(148, 1, 'UPDATE pessoa SET status = \'AT\', telefone = \'(99) 99999-9999\', email = \'dsfsd@adas.com\' WHERE id = 45', '2017-04-05 09:59:02', '127.0.0.1'),
	(149, 1, 'UPDATE fisica SET pessoa_id = \'45\', cpf = \'541.901.359-25\', nome = \'Teste 2\' WHERE id = 17', '2017-04-05 09:59:02', '127.0.0.1'),
	(150, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'05/04/2017 10:30:10\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'13\')', '2017-04-05 10:30:11', '127.0.0.1'),
	(151, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'85\',\'27\',\'2\',\'10\')', '2017-04-05 10:30:11', '127.0.0.1'),
	(152, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'12\', tem_estoque = \'y\' WHERE id = 27', '2017-04-05 10:30:12', '127.0.0.1'),
	(153, 1, 'UPDATE venda SET desconto = \'0\', total = \'10\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'13\' WHERE id = 85', '2017-04-05 10:30:12', '127.0.0.1'),
	(154, 1, 'INSERT INTO venda_pagto (venda_id,forma_pagto_id,valor) VALUES (\'85\',\'1\',\'\')', '2017-04-05 10:30:12', '127.0.0.1'),
	(155, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'05/04/2017 10:31:28\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'13\')', '2017-04-05 10:31:28', '127.0.0.1'),
	(156, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'86\',\'27\',\'2\',\'10\')', '2017-04-05 10:31:29', '127.0.0.1'),
	(157, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'10\', tem_estoque = \'y\' WHERE id = 27', '2017-04-05 10:31:29', '127.0.0.1'),
	(158, 1, 'UPDATE venda SET desconto = \'0\', total = \'10\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'13\' WHERE id = 86', '2017-04-05 10:31:29', '127.0.0.1'),
	(159, 1, 'INSERT INTO venda_pagto (venda_id,forma_pagto_id,valor) VALUES (\'86\',\'1\',\'10.00\')', '2017-04-05 10:31:29', '127.0.0.1'),
	(160, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'05/04/2017 10:32:29\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'13\')', '2017-04-05 10:32:29', '127.0.0.1'),
	(161, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'87\',\'27\',\'5\',\'25\')', '2017-04-05 10:32:29', '127.0.0.1'),
	(162, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'5\', tem_estoque = \'y\' WHERE id = 27', '2017-04-05 10:32:30', '127.0.0.1'),
	(163, 1, 'UPDATE venda SET desconto = \'0\', total = \'25\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'13\' WHERE id = 87', '2017-04-05 10:32:30', '127.0.0.1'),
	(164, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'05/04/2017 10:43:34\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'13\')', '2017-04-05 10:43:34', '127.0.0.1'),
	(165, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'88\',\'27\',\'5\',\'25\')', '2017-04-05 10:43:34', '127.0.0.1'),
	(166, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'0\', tem_estoque = \'y\' WHERE id = 27', '2017-04-05 10:43:35', '127.0.0.1'),
	(167, 1, 'UPDATE venda SET desconto = \'0\', total = \'25\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'13\' WHERE id = 88', '2017-04-05 10:43:35', '127.0.0.1'),
	(168, 1, 'INSERT INTO venda_pagto (venda_id,forma_pagto_id,valor) VALUES (\'88\',\'1\',\'10\')', '2017-04-05 10:43:35', '127.0.0.1'),
	(169, 1, 'UPDATE venda_pagto SET venda_id = \'88\', forma_pagto_id = \'2\', valor = \'15\' WHERE id = 4', '2017-04-05 10:43:35', '127.0.0.1'),
	(170, 1, 'INSERT INTO entrada_produto (tipo,produto_id,fornecedor_id,quantidade,lote,dt_compra,dt_validade,valor_unitario,valor_total,motivo_saida) VALUES (\'E\',\'27\',NULL,\'200\',NULL,STR_TO_DATE(\'05/04/2017 10:46\', \'%d/%m/%Y %H:%i:%s\'),STR_TO_DATE(\'05/04/2017\', \'%d/%m/%Y %H:%i:%s\'),\'2.22\',\'2.22\',NULL)', '2017-04-05 10:46:11', '127.0.0.1'),
	(171, 1, ' UPDATE produto\r\n                                               SET estoque = (CASE WHEN estoque IS NULL THEN 200 ELSE (estoque + 200) END)\r\n                                               WHERE id = \'27\' ', '2017-04-05 10:46:12', '127.0.0.1'),
	(172, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'05/04/2017 10:46:30\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'13\')', '2017-04-05 10:46:30', '127.0.0.1'),
	(173, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'89\',\'27\',\'5\',\'25\')', '2017-04-05 10:46:30', '127.0.0.1'),
	(174, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'195\', tem_estoque = \'y\' WHERE id = 27', '2017-04-05 10:46:31', '127.0.0.1'),
	(175, 1, 'UPDATE venda SET desconto = \'0\', total = \'25\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'13\' WHERE id = 89', '2017-04-05 10:46:31', '127.0.0.1'),
	(176, 1, 'INSERT INTO venda_pagto (venda_id,forma_pagto_id,valor) VALUES (\'89\',\'1\',\'15\')', '2017-04-05 10:46:31', '127.0.0.1'),
	(177, 1, 'INSERT INTO venda_pagto (venda_id,forma_pagto_id,valor) VALUES (\'89\',\'2\',\'8\')', '2017-04-05 10:46:31', '127.0.0.1'),
	(178, 1, 'INSERT INTO venda_pagto (venda_id,forma_pagto_id,valor) VALUES (\'89\',\'3\',\'2\')', '2017-04-05 10:46:31', '127.0.0.1'),
	(179, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'06/04/2017 09:05:43\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'13\')', '2017-04-06 09:05:43', '127.0.0.1'),
	(180, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'90\',\'27\',\'1\',\'5\')', '2017-04-06 09:05:43', '127.0.0.1'),
	(181, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'194\', tem_estoque = \'y\' WHERE id = 27', '2017-04-06 09:05:44', '127.0.0.1'),
	(182, 1, 'UPDATE itens_venda SET venda_id = \'90\', produto_id = \'32\', quantidade = \'5\', valor_unitario = \'76.05\' WHERE id = 39', '2017-04-06 09:05:44', '127.0.0.1'),
	(183, 1, 'UPDATE produto SET codigo = \'003\', categoria_id = \'3\', nome = \'Produto 2\', valor = \'15.21\', unidade_id = \'1\', estoque = \'2\', tem_estoque = \'y\' WHERE id = 32', '2017-04-06 09:05:44', '127.0.0.1'),
	(184, 1, 'UPDATE venda SET desconto = \'0\', total = \'81.05\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'13\' WHERE id = 90', '2017-04-06 09:05:44', '127.0.0.1'),
	(185, 1, 'INSERT INTO venda_pagto (venda_id,forma_pagto_id,valor) VALUES (\'90\',\'1\',\'0.5\')', '2017-04-06 09:05:45', '127.0.0.1'),
	(186, 1, 'INSERT INTO venda_pagto (venda_id,forma_pagto_id,valor) VALUES (\'90\',\'2\',\'80.55\')', '2017-04-06 09:05:45', '127.0.0.1'),
	(187, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'06/04/2017 09:36:02\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'13\')', '2017-04-06 09:36:02', '127.0.0.1'),
	(188, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'91\',\'27\',\'5\',\'25\')', '2017-04-06 09:36:02', '127.0.0.1'),
	(189, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'189\', tem_estoque = \'y\' WHERE id = 27', '2017-04-06 09:36:03', '127.0.0.1'),
	(190, 1, 'UPDATE venda SET desconto = \'0\', total = \'25\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'13\' WHERE id = 91', '2017-04-06 09:36:03', '127.0.0.1'),
	(191, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor) VALUES (\'2\',\'D\',\'25\')', '2017-04-06 09:36:03', '127.0.0.1'),
	(192, 1, 'INSERT INTO venda_pagto (venda_id,forma_pagto_id,valor) VALUES (\'91\',\'4\',\'25.00\')', '2017-04-06 09:36:03', '127.0.0.1'),
	(193, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'06/04/2017 09:52:49\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'13\')', '2017-04-06 09:52:49', '127.0.0.1'),
	(194, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'92\',\'27\',\'5\',\'25\')', '2017-04-06 09:52:49', '127.0.0.1'),
	(195, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'184\', tem_estoque = \'y\' WHERE id = 27', '2017-04-06 09:52:49', '127.0.0.1'),
	(196, 1, 'UPDATE venda SET desconto = \'0\', total = \'25\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'13\' WHERE id = 92', '2017-04-06 09:52:49', '127.0.0.1'),
	(197, 1, 'INSERT INTO venda_pagto (venda_id,forma_pagto_id,valor) VALUES (\'92\',\'1\',\'10\')', '2017-04-06 09:52:49', '127.0.0.1'),
	(198, 1, 'INSERT INTO venda_pagto (venda_id,forma_pagto_id,valor) VALUES (\'92\',\'2\',\'10\')', '2017-04-06 09:52:50', '127.0.0.1'),
	(199, 1, 'INSERT INTO venda_pagto (venda_id,forma_pagto_id,valor) VALUES (\'92\',\'4\',\'5\')', '2017-04-06 09:52:50', '127.0.0.1'),
	(200, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor) VALUES (\'2\',\'D\',\'5\')', '2017-04-06 09:52:50', '127.0.0.1'),
	(201, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'06/04/2017 11:44:19\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'13\')', '2017-04-06 11:44:20', '127.0.0.1'),
	(202, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'93\',\'27\',\'1\',\'5\')', '2017-04-06 11:44:20', '127.0.0.1'),
	(203, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'183\', tem_estoque = \'y\' WHERE id = 27', '2017-04-06 11:44:20', '127.0.0.1'),
	(204, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'13\' WHERE id = 93', '2017-04-06 11:44:20', '127.0.0.1'),
	(205, 1, 'INSERT INTO venda_pagto (venda_id,forma_pagto_id,valor) VALUES (\'93\',\'1\',\'5.00\')', '2017-04-06 11:44:20', '127.0.0.1'),
	(206, 1, 'INSERT INTO caixa (valor_inicial,valor_fechamento,funcionario_id,dt_fechamento) VALUES (\'\',\'15.20\',\'1\',NULL)', '2017-04-06 13:12:39', '127.0.0.1'),
	(207, 1, 'INSERT INTO caixa (valor_inicial,valor_fechamento,funcionario_id,dt_fechamento) VALUES (\'\',\'15.20\',\'1\',NULL)', '2017-04-06 13:13:28', '127.0.0.1'),
	(208, 1, 'INSERT INTO caixa (valor_inicial,valor_fechamento,funcionario_id,dt_fechamento) VALUES (\'\',\'15.20\',\'1\',NULL)', '2017-04-06 13:14:52', '127.0.0.1'),
	(209, 1, 'INSERT INTO caixa (valor_inicial,valor_fechamento,funcionario_id,dt_fechamento) VALUES (\'\',\'15.20\',\'1\',NULL)', '2017-04-06 13:16:05', '127.0.0.1'),
	(210, 1, 'INSERT INTO caixa (valor_inicial,valor_fechamento,funcionario_id,dt_fechamento) VALUES (\'\',\'15.20\',\'1\',NULL)', '2017-04-06 13:16:24', '127.0.0.1'),
	(211, 1, 'INSERT INTO caixa (valor_inicial,valor_fechamento,funcionario_id,dt_fechamento) VALUES (\'\',\'15.20\',\'1\',NULL)', '2017-04-06 13:16:36', '127.0.0.1'),
	(212, 1, 'UPDATE caixa SET valor_fechamento = \'15.20\', funcionario_id = \'1\', dt_fechamento = NULL WHERE id = 13', '2017-04-06 13:18:24', '127.0.0.1'),
	(213, 1, 'UPDATE caixa SET valor_fechamento = \'15.20\', funcionario_id = \'1\', dt_fechamento = NULL WHERE id = 13', '2017-04-06 13:18:39', '127.0.0.1'),
	(214, 1, 'UPDATE caixa SET valor_fechamento = \'15.20\', funcionario_id = \'1\', dt_fechamento = STR_TO_DATE(\'NOW\', \'%d/%m/%Y %H:%i:%s\') WHERE id = 13', '2017-04-06 13:18:47', '127.0.0.1'),
	(215, 1, 'UPDATE caixa SET valor_fechamento = \'15.20\', funcionario_id = \'1\', dt_fechamento = NULL WHERE id = 13', '2017-04-06 13:19:19', '127.0.0.1'),
	(216, 1, 'UPDATE caixa SET valor_fechamento = \'15.20\', funcionario_id = \'1\', dt_fechamento = NULL WHERE id = 13', '2017-04-06 13:19:38', '127.0.0.1'),
	(217, 1, 'UPDATE caixa SET valor_fechamento = \'15.20\', funcionario_id = \'1\', dt_fechamento = STR_TO_DATE(\'06/04/2017 13:20:09\', \'%d/%m/%Y %H:%i:%s\') WHERE id = 13', '2017-04-06 13:20:09', '127.0.0.1'),
	(218, 1, 'INSERT INTO caixa (valor_inicial,valor_fechamento,funcionario_id) VALUES (\'15.20\',NULL,\'1\')', '2017-04-06 13:22:12', '127.0.0.1'),
	(219, 1, 'UPDATE caixa SET valor_fechamento = \'15.23\', funcionario_id = \'1\', dt_fechamento = STR_TO_DATE(\'06/04/2017 13:23:14\', \'%d/%m/%Y %H:%i:%s\') WHERE id = 20', '2017-04-06 13:23:14', '127.0.0.1'),
	(220, 1, 'INSERT INTO caixa (valor_inicial,valor_fechamento,funcionario_id) VALUES (\'25.68\',NULL,\'1\')', '2017-04-06 13:23:17', '127.0.0.1'),
	(221, 1, 'UPDATE caixa SET valor_fechamento = \'4.57\', funcionario_id = \'1\', dt_fechamento = STR_TO_DATE(\'06/04/2017 13:47:25\', \'%d/%m/%Y %H:%i:%s\') WHERE id = 21', '2017-04-06 13:47:25', '127.0.0.1'),
	(222, 1, 'INSERT INTO caixa (valor_inicial,valor_fechamento,funcionario_id) VALUES (\'5.98\',\'\',\'1\')', '2017-04-06 13:47:56', '127.0.0.1'),
	(223, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'06/04/2017 13:48:13\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'22\')', '2017-04-06 13:48:13', '127.0.0.1'),
	(224, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'94\',\'27\',\'1\',\'5\')', '2017-04-06 13:48:13', '127.0.0.1'),
	(225, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'182\', tem_estoque = \'y\' WHERE id = 27', '2017-04-06 13:48:13', '127.0.0.1'),
	(226, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'22\' WHERE id = 94', '2017-04-06 13:48:13', '127.0.0.1'),
	(227, 1, 'INSERT INTO venda_pagto (venda_id,forma_pagto_id,valor) VALUES (\'94\',\'2\',\'5.00\')', '2017-04-06 13:48:14', '127.0.0.1'),
	(228, 1, 'UPDATE forma_pagto SET active = \'n\' WHERE id = 1', '2017-04-04 21:38:01', '192.168.1.243'),
	(229, 1, 'UPDATE forma_pagto SET active = \'y\' WHERE id = 1', '2017-04-04 21:38:03', '192.168.1.243'),
	(230, 1, 'UPDATE forma_pagto SET active = \'n\' WHERE id = 1', '2017-04-04 21:38:04', '192.168.1.243'),
	(231, 1, 'UPDATE forma_pagto SET active = \'y\' WHERE id = 1', '2017-04-04 21:38:08', '192.168.1.243'),
	(232, 1, 'UPDATE forma_pagto SET active = \'y\' WHERE id = 1', '2017-04-04 21:38:09', '192.168.1.243'),
	(233, 1, 'UPDATE forma_pagto SET active = \'y\' WHERE id = 1', '2017-04-04 21:38:10', '192.168.1.243'),
	(234, 1, 'UPDATE forma_pagto SET active = \'y\' WHERE id = 1', '2017-04-04 21:38:18', '192.168.1.243'),
	(235, 1, 'UPDATE forma_pagto SET active = \'n\' WHERE id = 1', '2017-04-04 21:44:15', '192.168.1.243'),
	(236, 1, 'UPDATE forma_pagto SET active = \'y\' WHERE id = 1', '2017-04-04 21:44:16', '192.168.1.243'),
	(237, 1, 'UPDATE forma_pagto SET active = \'n\' WHERE id = 1', '2017-04-04 21:44:18', '192.168.1.243'),
	(238, 1, 'UPDATE forma_pagto SET active = \'y\' WHERE id = 1', '2017-04-04 21:44:22', '192.168.1.243'),
	(239, 1, 'UPDATE forma_pagto SET active = \'n\' WHERE id = 1', '2017-04-04 21:44:24', '192.168.1.243'),
	(240, 1, 'UPDATE forma_pagto SET active = \'y\' WHERE id = 1', '2017-04-04 21:44:39', '192.168.1.243'),
	(241, 1, 'UPDATE forma_pagto SET active = \'y\' WHERE id = 1', '2017-04-04 21:46:31', '192.168.1.243'),
	(242, 1, 'UPDATE forma_pagto SET active = \'y\', active_c = \'n\' WHERE id = 1', '2017-04-04 21:48:19', '192.168.1.243'),
	(243, 1, 'UPDATE forma_pagto SET active = \'n\', active_c = \'y\' WHERE id = 1', '2017-04-04 21:48:20', '192.168.1.243'),
	(244, 1, 'UPDATE forma_pagto SET active = \'y\', active_c = \'n\' WHERE id = 1', '2017-04-04 21:48:22', '192.168.1.243'),
	(245, 1, 'UPDATE forma_pagto SET active = \'y\', active_c = \'y\' WHERE id = 1', '2017-04-04 21:48:24', '192.168.1.243'),
	(246, 1, 'UPDATE forma_pagto SET active = \'n\', active_c = \'y\' WHERE id = 1', '2017-04-04 21:51:08', '192.168.1.243'),
	(247, 1, 'UPDATE forma_pagto SET active = \'y\', active_c = \'n\' WHERE id = 1', '2017-04-04 21:51:10', '192.168.1.243'),
	(248, 1, 'UPDATE forma_pagto SET active = \'y\', active_c = \'y\' WHERE id = 1', '2017-04-04 21:51:12', '192.168.1.243'),
	(249, 1, 'UPDATE forma_pagto SET active = \'n\', active_c = \'y\' WHERE id = 1', '2017-04-04 21:51:20', '192.168.1.243'),
	(250, 1, 'UPDATE forma_pagto SET active = \'y\', active_c = \'n\' WHERE id = 1', '2017-04-04 21:51:28', '192.168.1.243'),
	(251, 1, 'UPDATE forma_pagto SET active = \'n\', active_c = \'y\' WHERE id = 1', '2017-04-04 21:51:59', '192.168.1.243'),
	(252, 1, 'UPDATE forma_pagto SET active = \'y\', active_c = \'y\' WHERE id = 1', '2017-04-04 21:52:03', '192.168.1.243'),
	(253, 1, 'UPDATE forma_pagto SET active = \'n\', active_c = \'y\' WHERE id = 1', '2017-04-04 21:52:12', '192.168.1.243'),
	(254, 1, 'UPDATE forma_pagto SET active = \'y\', active_c = \'y\' WHERE id = 1', '2017-04-04 21:55:04', '192.168.1.243'),
	(255, 1, 'UPDATE forma_pagto SET active = \'n\', active_c = \'y\' WHERE id = 1', '2017-04-04 21:55:09', '192.168.1.243'),
	(256, 1, 'UPDATE forma_pagto SET active = \'y\', active_c = \'y\' WHERE id = 1', '2017-04-04 21:55:11', '192.168.1.243'),
	(257, 1, 'UPDATE forma_pagto SET active = \'n\' WHERE id = 1', '2017-04-04 21:56:44', '192.168.1.243'),
	(258, 1, 'UPDATE forma_pagto SET active_c = \'n\' WHERE id = 1', '2017-04-04 22:03:21', '192.168.1.243'),
	(259, 1, 'UPDATE forma_pagto SET active = \'y\' WHERE id = 1', '2017-04-04 22:03:24', '192.168.1.243'),
	(260, 1, 'UPDATE forma_pagto SET active_c = \'y\' WHERE id = 1', '2017-04-04 22:03:26', '192.168.1.243'),
	(261, 1, 'UPDATE forma_pagto SET active_c = \'n\' WHERE id = 1', '2017-04-04 22:03:27', '192.168.1.243'),
	(262, 1, 'UPDATE forma_pagto SET active_c = \'y\' WHERE id = 1', '2017-04-04 22:03:28', '192.168.1.243'),
	(263, 1, 'UPDATE forma_pagto SET active = \'n\' WHERE id = 1', '2017-04-04 22:04:55', '192.168.1.243'),
	(264, 1, 'UPDATE forma_pagto SET active = \'y\' WHERE id = 1', '2017-04-04 22:04:56', '192.168.1.243'),
	(265, 1, 'UPDATE forma_pagto SET active_c = \'n\' WHERE id = 1', '2017-04-04 22:04:57', '192.168.1.243'),
	(266, 1, 'UPDATE forma_pagto SET active_c = \'y\' WHERE id = 1', '2017-04-04 22:04:58', '192.168.1.243'),
	(267, 1, 'UPDATE forma_pagto SET active = \'n\' WHERE id = 4', '2017-04-04 22:05:15', '192.168.1.243'),
	(268, 1, 'UPDATE forma_pagto SET active = \'y\' WHERE id = 4', '2017-04-04 22:05:28', '192.168.1.243'),
	(269, 1, 'UPDATE forma_pagto SET active = \'n\' WHERE id = 4', '2017-04-04 22:05:30', '192.168.1.243'),
	(270, 1, 'UPDATE forma_pagto SET active = \'y\' WHERE id = 4', '2017-04-04 22:05:48', '192.168.1.243'),
	(271, 1, 'UPDATE unidade SET active = \'n\' WHERE id = 1', '2017-04-04 22:36:58', '192.168.1.243'),
	(272, 1, 'UPDATE unidade SET active = \'y\' WHERE id = 1', '2017-04-04 22:36:59', '192.168.1.243'),
	(273, 1, 'UPDATE caixa SET valor_fechamento = \'3.45\', funcionario_id = \'1\', dt_fechamento = STR_TO_DATE(\'04/04/2017 22:51:22\', \'%d/%m/%Y %H:%i:%s\') WHERE id = 22', '2017-04-04 22:51:22', '192.168.1.243'),
	(274, 1, 'INSERT INTO caixa (valor_inicial,valor_fechamento,funcionario_id) VALUES (\'3.33\',NULL,\'1\')', '2017-04-04 23:01:40', '192.168.1.243'),
	(275, 1, 'UPDATE categoria SET nome = \'Teste\' WHERE id = 3', '2017-04-04 23:02:45', '192.168.1.243'),
	(276, 1, 'INSERT INTO entrada_produto (tipo,produto_id,fornecedor_id,quantidade,lote,dt_compra,dt_validade,valor_unitario,valor_total,motivo_saida) VALUES (\'E\',\'32\',NULL,\'45\',NULL,STR_TO_DATE(\'06/04/2017 22:38\', \'%d/%m/%Y %H:%i:%s\'),STR_TO_DATE(\'06/04/2017\', \'%d/%m/%Y %H:%i:%s\'),\'44.44\',\'44.44\',NULL)', '2017-04-04 23:03:18', '192.168.1.243'),
	(277, 1, ' UPDATE produto\n                                               SET estoque = (CASE WHEN estoque IS NULL THEN 45 ELSE (estoque + 45) END)\n                                               WHERE id = \'32\' ', '2017-04-04 23:03:18', '192.168.1.243'),
	(278, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'04/04/2017 23:14:02\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'23\')', '2017-04-04 23:14:02', '192.168.1.243'),
	(279, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'95\',\'27\',\'1\',\'5\')', '2017-04-04 23:14:02', '192.168.1.243'),
	(280, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'181\', tem_estoque = \'y\' WHERE id = 27', '2017-04-04 23:14:02', '192.168.1.243'),
	(281, 1, 'UPDATE itens_venda SET venda_id = \'95\', produto_id = \'32\', quantidade = \'3\', valor_unitario = \'45.63\' WHERE id = 44', '2017-04-04 23:14:02', '192.168.1.243'),
	(282, 1, 'UPDATE produto SET codigo = \'003\', categoria_id = \'3\', nome = \'Produto 2\', valor = \'15.21\', unidade_id = \'1\', estoque = \'44\', tem_estoque = \'y\' WHERE id = 32', '2017-04-04 23:14:02', '192.168.1.243'),
	(283, 1, 'UPDATE venda SET desconto = \'0\', total = \'50.63\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'23\' WHERE id = 95', '2017-04-04 23:14:02', '192.168.1.243'),
	(284, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'04/04/2017 23:15:37\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'23\')', '2017-04-04 23:15:37', '192.168.1.243'),
	(285, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'96\',\'27\',\'1\',\'5\')', '2017-04-04 23:15:37', '192.168.1.243'),
	(286, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'180\', tem_estoque = \'y\' WHERE id = 27', '2017-04-04 23:15:38', '192.168.1.243'),
	(287, 1, 'UPDATE itens_venda SET venda_id = \'96\', produto_id = \'32\', quantidade = \'3\', valor_unitario = \'45.63\' WHERE id = 45', '2017-04-04 23:15:38', '192.168.1.243'),
	(288, 1, 'UPDATE produto SET codigo = \'003\', categoria_id = \'3\', nome = \'Produto 2\', valor = \'15.21\', unidade_id = \'1\', estoque = \'41\', tem_estoque = \'y\' WHERE id = 32', '2017-04-04 23:15:38', '192.168.1.243'),
	(289, 1, 'UPDATE venda SET desconto = \'0\', total = \'50.63\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'23\' WHERE id = 96', '2017-04-04 23:15:38', '192.168.1.243'),
	(290, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'04/04/2017 23:15:51\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'23\')', '2017-04-04 23:15:51', '192.168.1.243'),
	(291, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'97\',\'27\',\'1\',\'5\')', '2017-04-04 23:15:51', '192.168.1.243'),
	(292, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'179\', tem_estoque = \'y\' WHERE id = 27', '2017-04-04 23:15:51', '192.168.1.243'),
	(293, 1, 'UPDATE itens_venda SET venda_id = \'97\', produto_id = \'32\', quantidade = \'3\', valor_unitario = \'45.63\' WHERE id = 46', '2017-04-04 23:15:51', '192.168.1.243'),
	(294, 1, 'UPDATE produto SET codigo = \'003\', categoria_id = \'3\', nome = \'Produto 2\', valor = \'15.21\', unidade_id = \'1\', estoque = \'38\', tem_estoque = \'y\' WHERE id = 32', '2017-04-04 23:15:51', '192.168.1.243'),
	(295, 1, 'UPDATE venda SET desconto = \'0\', total = \'50.63\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'23\' WHERE id = 97', '2017-04-04 23:15:52', '192.168.1.243'),
	(296, 1, 'UPDATE caixa SET valor_fechamento = \'0.02\', funcionario_id = \'1\', dt_fechamento = STR_TO_DATE(\'04/04/2017 23:18:44\', \'%d/%m/%Y %H:%i:%s\') WHERE id = 23', '2017-04-04 23:18:44', '192.168.1.243'),
	(297, 1, 'INSERT INTO caixa (valor_inicial,valor_fechamento,funcionario_id) VALUES (\'2.32\',NULL,\'1\')', '2017-04-04 23:19:53', '192.168.1.243'),
	(298, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'04/04/2017 23:20:14\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'24\')', '2017-04-04 23:20:15', '192.168.1.243'),
	(299, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'98\',\'27\',\'1\',\'5\')', '2017-04-04 23:20:15', '192.168.1.243'),
	(300, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'178\', tem_estoque = \'y\' WHERE id = 27', '2017-04-04 23:20:15', '192.168.1.243'),
	(301, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'24\' WHERE id = 98', '2017-04-04 23:20:15', '192.168.1.243'),
	(302, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'04/04/2017 23:24:56\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'24\')', '2017-04-04 23:24:56', '192.168.1.243'),
	(303, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'100\',\'27\',\'1\',\'5\')', '2017-04-04 23:24:56', '192.168.1.243'),
	(304, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'177\', tem_estoque = \'y\' WHERE id = 27', '2017-04-04 23:24:56', '192.168.1.243'),
	(305, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'24\' WHERE id = 100', '2017-04-04 23:24:56', '192.168.1.243'),
	(306, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'04/04/2017 23:26:39\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'24\')', '2017-04-04 23:26:40', '192.168.1.243'),
	(307, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'101\',\'27\',\'1\',\'5\')', '2017-04-04 23:26:40', '192.168.1.243'),
	(308, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'176\', tem_estoque = \'y\' WHERE id = 27', '2017-04-04 23:26:40', '192.168.1.243'),
	(309, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'24\' WHERE id = 101', '2017-04-04 23:26:40', '192.168.1.243'),
	(310, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'04/04/2017 23:29:04\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'24\')', '2017-04-04 23:29:04', '192.168.1.243'),
	(311, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'102\',\'27\',\'1\',\'5\')', '2017-04-04 23:29:05', '192.168.1.243'),
	(312, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'175\', tem_estoque = \'y\' WHERE id = 27', '2017-04-04 23:29:05', '192.168.1.243'),
	(313, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'24\' WHERE id = 102', '2017-04-04 23:29:05', '192.168.1.243'),
	(314, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'04/04/2017 23:29:21\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'24\')', '2017-04-04 23:29:22', '192.168.1.243'),
	(315, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'103\',\'27\',\'1\',\'5\')', '2017-04-04 23:29:22', '192.168.1.243'),
	(316, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'174\', tem_estoque = \'y\' WHERE id = 27', '2017-04-04 23:29:22', '192.168.1.243'),
	(317, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'24\' WHERE id = 103', '2017-04-04 23:29:22', '192.168.1.243'),
	(318, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'04/04/2017 23:29:39\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'24\')', '2017-04-04 23:29:39', '192.168.1.243'),
	(319, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'104\',\'27\',\'1\',\'5\')', '2017-04-04 23:29:39', '192.168.1.243'),
	(320, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'173\', tem_estoque = \'y\' WHERE id = 27', '2017-04-04 23:29:39', '192.168.1.243'),
	(321, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'24\' WHERE id = 104', '2017-04-04 23:29:40', '192.168.1.243'),
	(322, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'04/04/2017 23:29:56\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'24\')', '2017-04-04 23:29:56', '192.168.1.243'),
	(323, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'105\',\'27\',\'1\',\'5\')', '2017-04-04 23:29:56', '192.168.1.243'),
	(324, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'172\', tem_estoque = \'y\' WHERE id = 27', '2017-04-04 23:29:56', '192.168.1.243'),
	(325, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'24\' WHERE id = 105', '2017-04-04 23:29:56', '192.168.1.243'),
	(326, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'04/04/2017 23:30:44\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'24\')', '2017-04-04 23:30:44', '192.168.1.243'),
	(327, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'106\',\'27\',\'1\',\'5\')', '2017-04-04 23:30:45', '192.168.1.243'),
	(328, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'171\', tem_estoque = \'y\' WHERE id = 27', '2017-04-04 23:30:45', '192.168.1.243'),
	(329, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'24\' WHERE id = 106', '2017-04-04 23:30:45', '192.168.1.243'),
	(330, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'04/04/2017 23:31:35\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'24\')', '2017-04-04 23:31:35', '192.168.1.243'),
	(331, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'107\',\'27\',\'1\',\'5\')', '2017-04-04 23:31:35', '192.168.1.243'),
	(332, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'170\', tem_estoque = \'y\' WHERE id = 27', '2017-04-04 23:31:35', '192.168.1.243'),
	(333, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'24\' WHERE id = 107', '2017-04-04 23:31:35', '192.168.1.243'),
	(334, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'04/04/2017 23:31:55\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'24\')', '2017-04-04 23:31:55', '192.168.1.243'),
	(335, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'108\',\'27\',\'1\',\'5\')', '2017-04-04 23:31:55', '192.168.1.243'),
	(336, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'169\', tem_estoque = \'y\' WHERE id = 27', '2017-04-04 23:31:56', '192.168.1.243'),
	(337, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'24\' WHERE id = 108', '2017-04-04 23:31:56', '192.168.1.243'),
	(338, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'04/04/2017 23:33:10\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'24\')', '2017-04-04 23:33:10', '192.168.1.243'),
	(339, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'109\',\'27\',\'1\',\'5\')', '2017-04-04 23:33:11', '192.168.1.243'),
	(340, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'168\', tem_estoque = \'y\' WHERE id = 27', '2017-04-04 23:33:11', '192.168.1.243'),
	(341, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'24\' WHERE id = 109', '2017-04-04 23:33:11', '192.168.1.243'),
	(342, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'04/04/2017 23:34:17\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'24\')', '2017-04-04 23:34:17', '192.168.1.243'),
	(343, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'110\',\'27\',\'1\',\'5\')', '2017-04-04 23:34:17', '192.168.1.243'),
	(344, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'167\', tem_estoque = \'y\' WHERE id = 27', '2017-04-04 23:34:17', '192.168.1.243'),
	(345, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'24\' WHERE id = 110', '2017-04-04 23:34:17', '192.168.1.243'),
	(346, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'04/04/2017 23:34:32\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'24\')', '2017-04-04 23:34:32', '192.168.1.243'),
	(347, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'111\',\'27\',\'1\',\'5\')', '2017-04-04 23:34:32', '192.168.1.243'),
	(348, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'166\', tem_estoque = \'y\' WHERE id = 27', '2017-04-04 23:34:32', '192.168.1.243'),
	(349, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'24\' WHERE id = 111', '2017-04-04 23:34:32', '192.168.1.243'),
	(350, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'04/04/2017 23:34:47\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'24\')', '2017-04-04 23:34:47', '192.168.1.243'),
	(351, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'112\',\'27\',\'1\',\'5\')', '2017-04-04 23:34:47', '192.168.1.243'),
	(352, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'165\', tem_estoque = \'y\' WHERE id = 27', '2017-04-04 23:34:47', '192.168.1.243'),
	(353, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'24\' WHERE id = 112', '2017-04-04 23:34:47', '192.168.1.243'),
	(354, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'112\',NULL,\'1\',\'5.00\')', '2017-04-04 23:34:47', '192.168.1.243'),
	(355, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'04/04/2017 23:35:13\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'24\')', '2017-04-04 23:35:14', '192.168.1.243'),
	(356, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'113\',\'27\',\'1\',\'5\')', '2017-04-04 23:35:14', '192.168.1.243'),
	(357, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'164\', tem_estoque = \'y\' WHERE id = 27', '2017-04-04 23:35:14', '192.168.1.243'),
	(358, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'24\' WHERE id = 113', '2017-04-04 23:35:14', '192.168.1.243'),
	(359, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'113\',NULL,\'1\',\'5.00\')', '2017-04-04 23:35:14', '192.168.1.243'),
	(360, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor,desconto) VALUES (\'2\',\'\',\'15.00\',\'\')', '2017-04-08 08:02:19', '127.0.0.1'),
	(361, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor,desconto) VALUES (\'2\',\'\',\'15.00\',\'\')', '2017-04-08 08:10:59', '127.0.0.1'),
	(362, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor,desconto) VALUES (\'2\',\'C\',\'30.00\',NULL)', '2017-04-08 08:46:17', '127.0.0.1'),
	(363, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor,desconto) VALUES (\'2\',\'C\',\'30.00\',NULL)', '2017-04-08 08:47:40', '127.0.0.1'),
	(364, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor,desconto) VALUES (\'2\',\'C\',\'30.00\',\'0\')', '2017-04-08 08:48:00', '127.0.0.1'),
	(365, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor,desconto) VALUES (\'2\',\'C\',\'30.00\',\'0\')', '2017-04-08 08:50:12', '127.0.0.1'),
	(366, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor,desconto) VALUES (\'2\',\'C\',\'10.00\',\'0\')', '2017-04-08 08:56:12', '127.0.0.1'),
	(367, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor,desconto) VALUES (\'2\',\'C\',\'10.00\',\'0\')', '2017-04-08 08:57:14', '127.0.0.1'),
	(368, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor,desconto) VALUES (\'2\',\'C\',\'10.00\',\'0\')', '2017-04-08 08:57:37', '127.0.0.1'),
	(369, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor,desconto) VALUES (\'2\',\'C\',\'10.00\',\'0\')', '2017-04-08 08:58:01', '127.0.0.1'),
	(370, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (NULL,NULL,\'1\',\'10.00\')', '2017-04-08 08:58:01', '127.0.0.1'),
	(371, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor,desconto) VALUES (\'2\',\'C\',\'10.00\',\'0\')', '2017-04-08 08:58:58', '127.0.0.1'),
	(372, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (NULL,\'14\',\'1\',\'10.00\')', '2017-04-08 08:58:58', '127.0.0.1'),
	(373, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor,desconto) VALUES (\'2\',\'C\',\'25.00\',\'0\')', '2017-04-08 09:00:05', '127.0.0.1'),
	(374, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (NULL,\'15\',\'1\',\'5\')', '2017-04-08 09:00:05', '127.0.0.1'),
	(375, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor,desconto) VALUES (\'2\',\'C\',\'25.00\',\'0\')', '2017-04-08 09:03:57', '127.0.0.1'),
	(376, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (NULL,\'16\',\'1\',\'5\')', '2017-04-08 09:03:57', '127.0.0.1'),
	(377, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (NULL,\'16\',\'2\',\'15\')', '2017-04-08 09:03:57', '127.0.0.1'),
	(378, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor,desconto) VALUES (\'2\',\'C\',\'20\',\'0\')', '2017-04-08 09:07:08', '127.0.0.1'),
	(379, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (NULL,\'17\',\'1\',\'5\')', '2017-04-08 09:07:08', '127.0.0.1'),
	(380, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (NULL,\'17\',\'2\',\'15\')', '2017-04-08 09:07:08', '127.0.0.1'),
	(381, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'08/04/2017 09:10:21\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'24\')', '2017-04-08 09:10:21', '127.0.0.1'),
	(382, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'114\',\'27\',\'1\',\'5\')', '2017-04-08 09:10:21', '127.0.0.1'),
	(383, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'163\', tem_estoque = \'y\' WHERE id = 27', '2017-04-08 09:10:21', '127.0.0.1'),
	(384, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'24\' WHERE id = 114', '2017-04-08 09:10:21', '127.0.0.1'),
	(385, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'114\',NULL,\'1\',\'20.00\')', '2017-04-08 09:10:21', '127.0.0.1'),
	(386, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'08/04/2017 09:11:35\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'24\')', '2017-04-08 09:11:35', '127.0.0.1'),
	(387, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'115\',\'27\',\'2\',\'10\')', '2017-04-08 09:11:35', '127.0.0.1'),
	(388, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'161\', tem_estoque = \'y\' WHERE id = 27', '2017-04-08 09:11:35', '127.0.0.1'),
	(389, 1, 'UPDATE venda SET desconto = \'0\', total = \'10\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'24\' WHERE id = 115', '2017-04-08 09:11:35', '127.0.0.1'),
	(390, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor,desconto) VALUES (\'2\',\'D\',\'10\',\'\')', '2017-04-08 09:11:35', '127.0.0.1'),
	(391, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'115\',NULL,\'4\',\'10.00\')', '2017-04-08 09:11:35', '127.0.0.1'),
	(392, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'08/04/2017 09:15:03\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'24\')', '2017-04-08 09:15:03', '127.0.0.1'),
	(393, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'116\',\'27\',\'1\',\'5\')', '2017-04-08 09:15:03', '127.0.0.1'),
	(394, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'160\', tem_estoque = \'y\' WHERE id = 27', '2017-04-08 09:15:03', '127.0.0.1'),
	(395, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'24\' WHERE id = 116', '2017-04-08 09:15:03', '127.0.0.1'),
	(396, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'116\',NULL,\'1\',\'10.00\')', '2017-04-08 09:15:03', '127.0.0.1'),
	(397, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'08/04/2017 09:16:24\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'24\')', '2017-04-08 09:16:25', '127.0.0.1'),
	(398, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'117\',\'27\',\'1\',\'5\')', '2017-04-08 09:16:25', '127.0.0.1'),
	(399, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'159\', tem_estoque = \'y\' WHERE id = 27', '2017-04-08 09:16:25', '127.0.0.1'),
	(400, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'24\' WHERE id = 117', '2017-04-08 09:16:25', '127.0.0.1'),
	(401, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'117\',NULL,\'1\',\'5\')', '2017-04-08 09:16:25', '127.0.0.1'),
	(402, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'08/04/2017 09:24:37\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'24\')', '2017-04-08 09:24:38', '127.0.0.1'),
	(403, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'118\',\'27\',\'5\',\'25\')', '2017-04-08 09:24:38', '127.0.0.1'),
	(404, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'154\', tem_estoque = \'y\' WHERE id = 27', '2017-04-08 09:24:38', '127.0.0.1'),
	(405, 1, 'UPDATE venda SET desconto = \'0\', total = \'25\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'24\' WHERE id = 118', '2017-04-08 09:24:38', '127.0.0.1'),
	(406, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'118\',NULL,\'1\',\'10\')', '2017-04-08 09:24:38', '127.0.0.1'),
	(407, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'118\',NULL,\'2\',\'20\')', '2017-04-08 09:24:38', '127.0.0.1'),
	(408, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'08/04/2017 09:26:26\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'24\')', '2017-04-08 09:26:26', '127.0.0.1'),
	(409, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'119\',\'27\',\'5\',\'25\')', '2017-04-08 09:26:26', '127.0.0.1'),
	(410, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'149\', tem_estoque = \'y\' WHERE id = 27', '2017-04-08 09:26:26', '127.0.0.1'),
	(411, 1, 'UPDATE venda SET desconto = \'0\', total = \'25\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'24\' WHERE id = 119', '2017-04-08 09:26:26', '127.0.0.1'),
	(412, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'119\',NULL,\'1\',\'15\')', '2017-04-08 09:26:26', '127.0.0.1'),
	(413, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'119\',NULL,\'2\',\'20\')', '2017-04-08 09:26:27', '127.0.0.1'),
	(414, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'08/04/2017 09:28:11\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'24\')', '2017-04-08 09:28:11', '127.0.0.1'),
	(415, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'120\',\'27\',\'2\',\'10\')', '2017-04-08 09:28:11', '127.0.0.1'),
	(416, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'147\', tem_estoque = \'y\' WHERE id = 27', '2017-04-08 09:28:11', '127.0.0.1'),
	(417, 1, 'UPDATE venda SET desconto = \'0\', total = \'10\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'24\' WHERE id = 120', '2017-04-08 09:28:11', '127.0.0.1'),
	(418, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'120\',NULL,\'1\',\'5\')', '2017-04-08 09:28:11', '127.0.0.1'),
	(419, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'120\',NULL,\'2\',\'5\')', '2017-04-08 09:28:12', '127.0.0.1'),
	(420, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'08/04/2017 09:28:36\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'24\')', '2017-04-08 09:28:36', '127.0.0.1'),
	(421, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'121\',\'27\',\'2\',\'10\')', '2017-04-08 09:28:36', '127.0.0.1'),
	(422, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'145\', tem_estoque = \'y\' WHERE id = 27', '2017-04-08 09:28:36', '127.0.0.1'),
	(423, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'08/04/2017 11:42:53\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'24\')', '2017-04-08 11:42:53', '127.0.0.1'),
	(424, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'122\',\'27\',\'3\',\'15\')', '2017-04-08 11:42:54', '127.0.0.1'),
	(425, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'142\', tem_estoque = \'y\' WHERE id = 27', '2017-04-08 11:42:54', '127.0.0.1'),
	(426, 1, 'UPDATE venda SET desconto = \'0\', total = \'15\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'24\' WHERE id = 122', '2017-04-08 11:42:54', '127.0.0.1'),
	(427, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor,desconto) VALUES (\'2\',\'D\',\'15\',\'\')', '2017-04-08 11:42:54', '127.0.0.1'),
	(428, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'122\',NULL,\'4\',\'15\')', '2017-04-08 11:42:54', '127.0.0.1'),
	(429, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor,desconto) VALUES (\'2\',\'C\',\'15\',\'2\')', '2017-04-08 11:45:09', '127.0.0.1'),
	(430, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (NULL,\'20\',\'1\',\'15\')', '2017-04-08 11:45:09', '127.0.0.1'),
	(431, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor,desconto) VALUES (\'2\',\'C\',\'5.00\',\'5\')', '2017-04-08 11:49:22', '127.0.0.1'),
	(432, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (NULL,\'21\',\'1\',\'5.00\')', '2017-04-08 11:49:22', '127.0.0.1'),
	(433, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor,desconto) VALUES (\'2\',\'C\',\'9.00\',\'10\')', '2017-04-08 11:52:20', '127.0.0.1'),
	(434, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (NULL,\'22\',\'1\',\'9.00\')', '2017-04-08 11:52:20', '127.0.0.1'),
	(435, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor,desconto) VALUES (\'2\',\'C\',\'9.50\',\'5\')', '2017-04-08 11:55:27', '127.0.0.1'),
	(436, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (NULL,\'23\',\'1\',\'9.50\')', '2017-04-08 11:55:27', '127.0.0.1'),
	(437, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'08/04/2017 14:48:55\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'24\')', '2017-04-08 14:48:55', '127.0.0.1'),
	(438, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'123\',\'27\',\'2\',\'10\')', '2017-04-08 14:48:55', '127.0.0.1'),
	(439, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'140\', tem_estoque = \'y\' WHERE id = 27', '2017-04-08 14:48:55', '127.0.0.1'),
	(440, 1, 'UPDATE venda SET desconto = \'0\', total = \'10\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'24\' WHERE id = 123', '2017-04-08 14:48:55', '127.0.0.1'),
	(441, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'123\',NULL,\'1\',\'5\')', '2017-04-08 14:48:56', '127.0.0.1'),
	(442, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'123\',NULL,\'2\',\'5\')', '2017-04-08 14:48:56', '127.0.0.1'),
	(443, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'08/04/2017 14:50:03\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'24\')', '2017-04-08 14:50:03', '127.0.0.1'),
	(444, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'124\',\'32\',\'5\',\'76.05\')', '2017-04-08 14:50:03', '127.0.0.1'),
	(445, 1, 'UPDATE produto SET codigo = \'003\', categoria_id = \'3\', nome = \'Produto 2\', valor = \'15.21\', unidade_id = \'1\', estoque = \'33\', tem_estoque = \'y\' WHERE id = 32', '2017-04-08 14:50:03', '127.0.0.1'),
	(446, 1, 'UPDATE venda SET desconto = \'0\', total = \'76.05\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'24\' WHERE id = 124', '2017-04-08 14:50:03', '127.0.0.1'),
	(447, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'124\',NULL,\'2\',\'76.05\')', '2017-04-08 14:50:03', '127.0.0.1'),
	(448, 1, 'UPDATE caixa SET valor_fechamento = \'15.00\', funcionario_id = \'1\', dt_fechamento = STR_TO_DATE(\'08/04/2017 14:55:11\', \'%d/%m/%Y %H:%i:%s\') WHERE id = 24', '2017-04-08 14:55:11', '127.0.0.1'),
	(449, 1, 'INSERT INTO caixa (valor_inicial,valor_fechamento,funcionario_id) VALUES (\'15.48\',NULL,\'1\')', '2017-04-08 14:55:24', '127.0.0.1'),
	(450, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'10/04/2017 07:56:36\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'25\')', '2017-04-10 07:56:36', '127.0.0.1'),
	(451, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'125\',\'27\',\'2\',\'10\')', '2017-04-10 07:56:37', '127.0.0.1'),
	(452, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'138\', tem_estoque = \'y\' WHERE id = 27', '2017-04-10 07:56:37', '127.0.0.1'),
	(453, 1, 'UPDATE venda SET desconto = \'0\', total = \'10\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'25\' WHERE id = 125', '2017-04-10 07:56:37', '127.0.0.1'),
	(454, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor,desconto) VALUES (\'2\',\'D\',\'10\',\'\')', '2017-04-10 07:56:37', '127.0.0.1'),
	(455, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'125\',NULL,\'4\',\'10\')', '2017-04-10 07:56:37', '127.0.0.1'),
	(456, 1, 'INSERT INTO produto (codigo,codbar,categoria_id,nome,descricao,valor,unidade_id,estoque_min,estoque,tem_estoque) VALUES (\'004\',NULL,\'3\',\'Mussarela\',NULL,\'32.00\',\'3\',NULL,NULL,\'n\')', '2017-04-10 08:05:44', '127.0.0.1'),
	(458, 1, 'INSERT INTO entrada_produto (tipo,produto_id,fornecedor_id,quantidade,lote,dt_compra,dt_validade,valor_unitario,valor_total,motivo_saida) VALUES (\'S\',\'32\',NULL,\'33\',NULL,NULL,NULL,NULL,NULL,\'teste\')', '2017-04-10 08:13:01', '127.0.0.1'),
	(459, 1, ' UPDATE produto\r\n                                                   SET estoque = (estoque - 33) \r\n                                                   WHERE id = \'32\' ', '2017-04-10 08:13:01', '127.0.0.1'),
	(460, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor,desconto) VALUES (\'2\',\'C\',\'10\',\'0\')', '2017-04-11 09:28:44', '127.0.0.1'),
	(461, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (NULL,\'25\',\'1\',\'10\')', '2017-04-11 09:28:44', '127.0.0.1'),
	(462, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'12/04/2017 09:06:50\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'25\')', '2017-04-12 09:06:51', '127.0.0.1'),
	(463, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'126\',\'33\',\'0.350\',\'11.2\')', '2017-04-12 09:06:51', '127.0.0.1'),
	(464, 1, 'UPDATE produto SET codigo = \'004\', categoria_id = \'3\', nome = \'Mussarela\', valor = \'32.00\', unidade_id = \'3\', estoque = \'-0.35\', tem_estoque = \'n\' WHERE id = 33', '2017-04-12 09:06:51', '127.0.0.1'),
	(465, 1, 'UPDATE itens_venda SET venda_id = \'126\', produto_id = \'33\', quantidade = \'0.100\', valor_unitario = \'3.2\' WHERE id = 10', '2017-04-12 09:06:51', '127.0.0.1'),
	(466, 1, 'UPDATE produto SET codigo = \'004\', categoria_id = \'3\', nome = \'Mussarela\', valor = \'32.00\', unidade_id = \'3\', estoque = \'-0.1\', tem_estoque = \'n\' WHERE id = 33', '2017-04-12 09:06:51', '127.0.0.1'),
	(467, 1, 'UPDATE itens_venda SET venda_id = \'126\', produto_id = \'27\', quantidade = \'5\', valor_unitario = \'25\' WHERE id = 10', '2017-04-12 09:06:51', '127.0.0.1'),
	(468, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'133\', tem_estoque = \'y\' WHERE id = 27', '2017-04-12 09:06:52', '127.0.0.1'),
	(469, 1, 'UPDATE itens_venda SET venda_id = \'126\', produto_id = \'33\', quantidade = \'0.100\', valor_unitario = \'3.2\' WHERE id = 10', '2017-04-12 09:06:52', '127.0.0.1'),
	(470, 1, 'UPDATE produto SET codigo = \'004\', categoria_id = \'3\', nome = \'Mussarela\', valor = \'32.00\', unidade_id = \'3\', estoque = \'-0.1\', tem_estoque = \'n\' WHERE id = 33', '2017-04-12 09:06:52', '127.0.0.1'),
	(471, 1, 'UPDATE venda SET desconto = \'0\', total = \'42.6\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'25\' WHERE id = 126', '2017-04-12 09:06:52', '127.0.0.1'),
	(472, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'126\',NULL,\'1\',\'42.6\')', '2017-04-12 09:06:52', '127.0.0.1'),
	(473, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'12/04/2017 09:08:33\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'25\')', '2017-04-12 09:08:33', '127.0.0.1'),
	(474, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'127\',\'27\',\'2\',\'10\')', '2017-04-12 09:08:33', '127.0.0.1'),
	(475, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'131\', tem_estoque = \'y\' WHERE id = 27', '2017-04-12 09:08:34', '127.0.0.1'),
	(476, 1, 'UPDATE itens_venda SET venda_id = \'127\', produto_id = \'33\', quantidade = \'0.350\', valor_unitario = \'11.2\' WHERE id = 1', '2017-04-12 09:08:34', '127.0.0.1'),
	(477, 1, 'UPDATE produto SET codigo = \'004\', categoria_id = \'3\', nome = \'Mussarela\', valor = \'32.00\', unidade_id = \'3\', estoque = \'-0.35\', tem_estoque = \'n\' WHERE id = 33', '2017-04-12 09:08:34', '127.0.0.1'),
	(478, 1, 'UPDATE venda SET desconto = \'0\', total = \'21.2\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'25\' WHERE id = 127', '2017-04-12 09:08:34', '127.0.0.1'),
	(479, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'127\',NULL,\'1\',\'21.2\')', '2017-04-12 09:08:34', '127.0.0.1'),
	(480, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'12/04/2017 09:10:05\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'25\')', '2017-04-12 09:10:05', '127.0.0.1'),
	(481, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'128\',\'27\',\'2\',\'10\')', '2017-04-12 09:10:05', '127.0.0.1'),
	(482, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'129\', tem_estoque = \'y\' WHERE id = 27', '2017-04-12 09:10:05', '127.0.0.1'),
	(483, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'128\',\'33\',\'0.152\',\'4.864\')', '2017-04-12 09:10:05', '127.0.0.1'),
	(484, 1, 'UPDATE produto SET codigo = \'004\', categoria_id = \'3\', nome = \'Mussarela\', valor = \'32.00\', unidade_id = \'3\', estoque = \'-0.152\', tem_estoque = \'n\' WHERE id = 33', '2017-04-12 09:10:05', '127.0.0.1'),
	(485, 1, 'UPDATE venda SET desconto = \'0\', total = \'14.864\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'25\' WHERE id = 128', '2017-04-12 09:10:05', '127.0.0.1'),
	(486, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'128\',NULL,\'1\',\'14.864\')', '2017-04-12 09:10:05', '127.0.0.1'),
	(487, 1, 'INSERT INTO categoria (nome) VALUES (\'Geral\')', '2017-04-12 09:16:18', '127.0.0.1'),
	(488, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'12/04/2017 09:54:56\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'25\')', '2017-04-12 09:54:56', '127.0.0.1'),
	(489, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'129\',\'27\',\'2\',\'10\')', '2017-04-12 09:54:57', '127.0.0.1'),
	(490, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'127\', tem_estoque = \'y\' WHERE id = 27', '2017-04-12 09:54:57', '127.0.0.1'),
	(491, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'129\',\'33\',\'0.350\',\'11.2\')', '2017-04-12 09:54:57', '127.0.0.1'),
	(492, 1, 'UPDATE produto SET codigo = \'004\', categoria_id = \'3\', nome = \'Mussarela\', valor = \'32.00\', unidade_id = \'3\', estoque = \'-0.35\', tem_estoque = \'n\' WHERE id = 33', '2017-04-12 09:54:57', '127.0.0.1'),
	(493, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'129\',\'1\',\'1\',\'1.5\')', '2017-04-12 09:54:57', '127.0.0.1'),
	(494, 1, 'UPDATE produto SET codigo = \'000\', categoria_id = \'4\', nome = \'Livre\', valor = \'0.00\', unidade_id = \'2\', estoque_min = \'0\', estoque = \'-1\', tem_estoque = \'n\' WHERE id = 1', '2017-04-12 09:54:57', '127.0.0.1'),
	(495, 1, 'UPDATE venda SET desconto = \'0\', total = \'22.7\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'25\' WHERE id = 129', '2017-04-12 09:54:57', '127.0.0.1'),
	(496, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'129\',NULL,\'1\',\'22.7\')', '2017-04-12 09:54:57', '127.0.0.1'),
	(497, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'12/04/2017 15:09:32\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'25\')', '2017-04-12 15:09:33', '127.0.0.1'),
	(498, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'130\',\'33\',\'0.350\',\'11.2\')', '2017-04-12 15:09:33', '127.0.0.1'),
	(499, 1, 'UPDATE produto SET codigo = \'004\', categoria_id = \'3\', nome = \'Mussarela\', valor = \'32.00\', unidade_id = \'3\', estoque = \'-0.35\', tem_estoque = \'n\' WHERE id = 33', '2017-04-12 15:09:33', '127.0.0.1'),
	(500, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'130\',\'33\',\'0.21875\',\'7\')', '2017-04-12 15:09:33', '127.0.0.1'),
	(501, 1, 'UPDATE produto SET codigo = \'004\', categoria_id = \'3\', nome = \'Mussarela\', valor = \'32.00\', unidade_id = \'3\', estoque = \'-0.21875\', tem_estoque = \'n\' WHERE id = 33', '2017-04-12 15:09:33', '127.0.0.1'),
	(502, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'130\',\'27\',\'3\',\'15\')', '2017-04-12 15:09:33', '127.0.0.1'),
	(503, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'124\', tem_estoque = \'y\' WHERE id = 27', '2017-04-12 15:09:34', '127.0.0.1'),
	(504, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'130\',\'1\',\'1\',\'1.52\')', '2017-04-12 15:09:34', '127.0.0.1'),
	(505, 1, 'UPDATE produto SET codigo = \'000\', categoria_id = \'4\', nome = \'Livre\', valor = \'0.00\', unidade_id = \'2\', estoque_min = \'0\', estoque = \'-2\', tem_estoque = \'n\' WHERE id = 1', '2017-04-12 15:09:34', '127.0.0.1'),
	(506, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'130\',\'1\',\'1\',\'2.54\')', '2017-04-12 15:09:34', '127.0.0.1'),
	(507, 1, 'UPDATE produto SET codigo = \'000\', categoria_id = \'4\', nome = \'Livre\', valor = \'0.00\', unidade_id = \'2\', estoque_min = \'0\', estoque = \'-3\', tem_estoque = \'n\' WHERE id = 1', '2017-04-12 15:09:34', '127.0.0.1'),
	(508, 1, 'UPDATE venda SET desconto = \'0\', total = \'37.26\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'25\' WHERE id = 130', '2017-04-12 15:09:34', '127.0.0.1'),
	(509, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'130\',NULL,\'1\',\'37.26\')', '2017-04-12 15:09:34', '127.0.0.1'),
	(510, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'email@email.com\')', '2017-04-18 10:51:37', '127.0.0.1'),
	(511, 1, 'INSERT INTO funcionario (nome,tipo_us,pessoa_id,login,senha) VALUES (\'\',\'N\',\'46\',\'\',\'\')', '2017-04-18 10:51:38', '127.0.0.1'),
	(512, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'ulisses.bueno@gmail.com\')', '2017-04-18 10:53:56', '127.0.0.1'),
	(513, 1, 'INSERT INTO funcionario (nome,tipo_us,pessoa_id,login,senha) VALUES (\'\',\'N\',\'47\',\'teste\',\'\')', '2017-04-18 10:53:56', '127.0.0.1'),
	(514, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'fulano@fmail.com\')', '2017-04-18 11:02:52', '127.0.0.1'),
	(515, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'F\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(55) 55555-5555\',\'email@email.com\')', '2017-04-18 11:07:04', '127.0.0.1'),
	(516, 1, 'INSERT INTO fisica (pessoa_id,cpf,nome,rg,sexo,tem_conta,dia_mes_pagto,limite_conta) VALUES (\'49\',\'480.040.065-15\',\'Teste\',\'\',\'\',\'n\',\'5\',NULL)', '2017-04-18 11:07:04', '127.0.0.1'),
	(517, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'F\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(66) 66666-6666\',\'ea@asda.com\')', '2017-04-18 11:13:43', '127.0.0.1'),
	(518, 1, 'INSERT INTO fisica (pessoa_id,cpf,nome,rg,sexo,tem_conta,dia_mes_pagto,limite_conta) VALUES (\'50\',\'233.968.327-01\',\'Teste\',\'\',\'\',\'n\',\'5\',NULL)', '2017-04-18 11:13:43', '127.0.0.1'),
	(519, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'F\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(66) 66666-6666\',\'ea@asda.com\')', '2017-04-18 11:14:20', '127.0.0.1'),
	(520, 1, 'INSERT INTO fisica (pessoa_id,cpf,nome,rg,sexo,tem_conta,dia_mes_pagto,limite_conta) VALUES (\'51\',\'578.374.415-83\',\'Teste\',\'\',\'\',\'n\',\'5\',NULL)', '2017-04-18 11:14:21', '127.0.0.1'),
	(521, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'F\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(66) 66666-6666\',\'ea@asda.com\')', '2017-04-18 11:16:16', '127.0.0.1'),
	(522, 1, 'INSERT INTO fisica (pessoa_id,cpf,nome,rg,sexo,tem_conta,dia_mes_pagto,limite_conta) VALUES (\'52\',\'152.278.242-74\',\'Teste\',\'\',\'\',\'n\',\'5\',NULL)', '2017-04-18 11:16:16', '127.0.0.1'),
	(523, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'F\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(66) 66666-6666\',\'ea@asda.com\')', '2017-04-18 11:17:30', '127.0.0.1'),
	(524, 1, 'INSERT INTO fisica (pessoa_id,cpf,nome,rg,sexo,tem_conta,dia_mes_pagto,limite_conta) VALUES (\'53\',\'376.707.748-51\',\'Teste\',\'\',\'\',\'n\',\'5\',NULL)', '2017-04-18 11:17:30', '127.0.0.1'),
	(525, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'F\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(99) 99999-9999\',\'fdgdf@sadsa.com\')', '2017-04-18 11:23:37', '127.0.0.1'),
	(526, 1, 'INSERT INTO fisica (pessoa_id,cpf,nome,rg,sexo,tem_conta,dia_mes_pagto,limite_conta) VALUES (\'54\',\'988.174.938-72\',\'teste\',\'\',\'\',\'n\',\'5\',NULL)', '2017-04-18 11:23:37', '127.0.0.1'),
	(527, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'F\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(99) 99999-9999\',\'fdgdf@sadsa.com\')', '2017-04-18 11:24:40', '127.0.0.1'),
	(528, 1, 'INSERT INTO fisica (pessoa_id,cpf,nome,rg,sexo,tem_conta,dia_mes_pagto,limite_conta) VALUES (\'55\',\'817.834.548-06\',\'teste\',\'\',\'\',\'n\',\'5\',NULL)', '2017-04-18 11:24:40', '127.0.0.1'),
	(529, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'F\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(55) 55555-5555\',\'sfda@asd.com\')', '2017-04-18 11:27:32', '127.0.0.1'),
	(530, 1, 'INSERT INTO fisica (pessoa_id,cpf,nome,rg,sexo,tem_conta,dia_mes_pagto,limite_conta) VALUES (\'56\',\'210.354.616-41\',\'sdfsd\',\'\',\'\',\'n\',\'5\',NULL)', '2017-04-18 11:27:32', '127.0.0.1'),
	(531, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'F\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(55) 55555-5555\',\'sfda@asd.com\')', '2017-04-18 11:28:58', '127.0.0.1'),
	(532, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'F\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(55) 55555-5555\',\'sfda@asd.com\')', '2017-04-18 11:29:33', '127.0.0.1'),
	(533, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'F\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(55) 55555-5555\',\'dsfsd@asdasd.cm\')', '2017-04-18 11:32:22', '127.0.0.1'),
	(534, 1, 'INSERT INTO fisica (pessoa_id,cpf,nome,rg,sexo,tem_conta,dia_mes_pagto,limite_conta) VALUES (\'59\',\'887.648.618-64\',\'teste\',\'\',\'\',\'n\',\'5\',NULL)', '2017-04-18 11:32:22', '127.0.0.1'),
	(535, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'F\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(99) 99999-9999\',\'dfsd@adas.com\')', '2017-04-18 12:50:59', '127.0.0.1'),
	(536, 1, 'INSERT INTO fisica (pessoa_id,cpf,nome,rg,sexo,tem_conta,dia_mes_pagto,limite_conta) VALUES (\'60\',\'318.785.342-03\',\'teste\',\'\',\'\',\'n\',\'5\',NULL)', '2017-04-18 12:50:59', '127.0.0.1'),
	(537, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'F\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(99) 99999-9999\',\'dfsd@adas.com\')', '2017-04-18 12:52:07', '127.0.0.1'),
	(538, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'F\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(99) 99999-9999\',\'dfsd@adas.com\')', '2017-04-18 12:54:37', '127.0.0.1'),
	(539, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'F\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(99) 99999-9999\',\'dfsd@adas.com\')', '2017-04-18 12:55:07', '127.0.0.1'),
	(540, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'F\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(99) 99999-9999\',\'dfsd@adas.com\')', '2017-04-18 12:55:18', '127.0.0.1'),
	(541, 0, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'F\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(99) 99999-9999\',\'dfsd@adas.com\')', '2017-04-18 12:57:06', '127.0.0.1'),
	(542, 0, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'F\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(99) 99999-9999\',\'dfsd@adas.com\')', '2017-04-18 12:57:25', '127.0.0.1'),
	(543, 0, 'INSERT INTO fisica (pessoa_id,cpf,nome,rg,sexo,tem_conta,dia_mes_pagto,limite_conta) VALUES (\'66\',\'447.024.545-36\',\'teste\',\'\',\'\',\'n\',\'5\',NULL)', '2017-04-18 12:57:25', '127.0.0.1'),
	(544, 0, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'F\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(99) 99999-9999\',\'dfsd@adas.com\')', '2017-04-18 12:59:46', '127.0.0.1'),
	(545, 0, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'F\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(99) 99999-9999\',\'dfsd@adas.com\')', '2017-04-18 13:00:03', '127.0.0.1'),
	(546, 0, 'INSERT INTO fisica (pessoa_id,cpf,nome,rg,sexo,tem_conta,dia_mes_pagto,limite_conta) VALUES (\'68\',\'286.632.395-56\',\'teste\',\'\',\'\',\'n\',\'5\',NULL)', '2017-04-18 13:00:03', '127.0.0.1'),
	(547, 0, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'F\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(99) 99999-9999\',\'dfsd@adas.com\')', '2017-04-18 13:01:36', '127.0.0.1'),
	(548, 0, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'F\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(99) 99999-9999\',\'dfsd@adas.com\')', '2017-04-18 13:01:51', '127.0.0.1'),
	(549, 0, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'F\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(99) 99999-9999\',\'dfsd@adas.com\')', '2017-04-18 13:02:02', '127.0.0.1'),
	(550, 0, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'F\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(99) 99999-9999\',\'dfsd@adas.com\')', '2017-04-18 13:02:16', '127.0.0.1'),
	(551, 0, 'INSERT INTO fisica (pessoa_id,cpf,nome,rg,sexo,tem_conta,dia_mes_pagto,limite_conta) VALUES (\'72\',\'862.672.633-39\',\'teste\',\'\',\'\',\'n\',\'5\',NULL)', '2017-04-18 13:02:16', '127.0.0.1'),
	(552, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'F\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'(99) 99999-9999\',\'dfsd@adas.com\')', '2017-04-18 13:02:30', '127.0.0.1'),
	(553, 1, 'INSERT INTO fisica (pessoa_id,cpf,nome,rg,sexo,tem_conta,dia_mes_pagto,limite_conta) VALUES (\'73\',\'171.672.676-00\',\'teste\',\'\',\'\',\'n\',\'5\',NULL)', '2017-04-18 13:02:30', '127.0.0.1'),
	(554, 1, 'UPDATE pessoa SET status = \'AT\', email = \'email@eamil.com\' WHERE id = 47', '2017-04-18 18:47:56', '192.168.1.244'),
	(555, 1, 'UPDATE funcionario SET nome = \'Teste\', tipo_us = \'N\', pessoa_id = \'47\', login = \'teste\' WHERE id = 3', '2017-04-18 18:47:56', '192.168.1.244'),
	(556, 1, 'UPDATE pessoa SET status = \'AT\', email = \'fsd@asdas.com\' WHERE id = 1', '2017-04-18 18:48:05', '192.168.1.244'),
	(557, 1, 'UPDATE funcionario SET nome = \'Ulisses\', tipo_us = \'M\', pessoa_id = \'1\', login = \'ulisses\', senha = \'0dd1219bf2c236a83bc362ffcdb02b50\' WHERE id = 1', '2017-04-18 18:48:05', '192.168.1.244'),
	(558, 1, 'UPDATE pessoa SET status = \'AT\', email = \'email@eamil.com\' WHERE id = 47', '2017-04-18 18:48:08', '192.168.1.244'),
	(559, 1, 'UPDATE funcionario SET nome = \'Teste\', tipo_us = \'N\', pessoa_id = \'47\', login = \'teste\' WHERE id = 3', '2017-04-18 18:48:08', '192.168.1.244'),
	(560, 1, 'UPDATE pessoa SET status = \'AT\', email = \'fsd@asdas.com\' WHERE id = 1', '2017-04-18 18:48:20', '192.168.1.244'),
	(561, 1, 'UPDATE funcionario SET nome = \'Ulisses Bueno\', tipo_us = \'M\', pessoa_id = \'1\', login = \'ulisses\', senha = \'0dd1219bf2c236a83bc362ffcdb02b50\' WHERE id = 1', '2017-04-18 18:48:20', '192.168.1.244'),
	(562, 1, 'UPDATE pessoa SET status = \'AT\', email = \'email@eamil.com\' WHERE id = 47', '2017-04-18 18:49:33', '192.168.1.244'),
	(563, 1, 'UPDATE funcionario SET nome = \'Teste\', tipo_us = \'N\', pessoa_id = \'47\', login = \'teste\' WHERE id = 3', '2017-04-18 18:49:33', '192.168.1.244'),
	(564, 1, 'UPDATE pessoa SET status = \'AT\', email = \'email@eamil.com\' WHERE id = 47', '2017-04-18 18:49:44', '192.168.1.244'),
	(565, 1, 'UPDATE pessoa SET status = \'AT\', email = \'email@eamil.com\' WHERE id = 47', '2017-04-18 18:50:01', '192.168.1.244'),
	(566, 1, 'UPDATE pessoa SET status = \'AT\', email = \'email@eamil.com\' WHERE id = 47', '2017-04-18 18:51:00', '192.168.1.244'),
	(567, 1, 'UPDATE funcionario SET nome = \'Teste\', tipo_us = \'N\', pessoa_id = \'47\', login = \'teste\' WHERE id = 3', '2017-04-18 18:51:00', '192.168.1.244'),
	(568, 1, 'UPDATE pessoa SET status = \'AT\', email = \'email@eamil.com\' WHERE id = 47', '2017-04-18 18:53:50', '192.168.1.244'),
	(569, 1, 'UPDATE funcionario SET nome = \'Teste\', tipo_us = \'N\', pessoa_id = \'47\', login = \'teste\', senha = \'698dc19d489c4e4db73e28a713eab07b\' WHERE id = 3', '2017-04-18 18:53:50', '192.168.1.244'),
	(570, 1, 'UPDATE funcionario SET senha = \'698dc19d489c4e4db73e28a713eab07b\' WHERE id = 3', '2017-04-18 19:21:33', '192.168.1.244'),
	(571, 1, 'UPDATE categoria SET nome = \'Teste\' WHERE id = 3', '2017-04-18 19:26:58', '192.168.1.244'),
	(572, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'func@empresa.com.br\')', '2017-04-18 19:37:46', '192.168.1.244'),
	(573, 1, 'INSERT INTO funcionario (nome,tipo_us,pessoa_id,login,senha) VALUES (\'func\',\'N\',\'74\',\'func\',\'\')', '2017-04-18 19:37:46', '192.168.1.244'),
	(574, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'func1@empresa.com.br\')', '2017-04-18 19:39:03', '192.168.1.244'),
	(575, 1, 'INSERT INTO funcionario (nome,tipo_us,pessoa_id,login,senha) VALUES (\'func\',\'N\',\'75\',\'func1\',\'\')', '2017-04-18 19:39:04', '192.168.1.244'),
	(576, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'sfsdf@empresa.com.br\')', '2017-04-18 19:40:20', '192.168.1.244'),
	(577, 1, 'INSERT INTO funcionario (nome,tipo_us,pessoa_id,login,senha) VALUES (\'func\',\'N\',\'76\',\'fsd\',\'\')', '2017-04-18 19:40:20', '192.168.1.244'),
	(578, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'teste@teste.com\')', '2017-04-18 19:42:31', '192.168.1.244'),
	(579, 1, 'INSERT INTO funcionario (nome,tipo_us,pessoa_id,login,senha) VALUES (\'teste\',\'N\',\'77\',\'func\',\'\')', '2017-04-18 19:42:31', '192.168.1.244'),
	(580, 1, '	INSERT INTO acesso ( modulo_id, funcionario_id, nivel_acesso ) VALUES \r\n					( 1, \'8\', NULL ),\r\n					( 15, \'8\', NULL ),\r\n					( 18, \'8\', NULL ) ', '2017-04-18 19:42:31', '192.168.1.244'),
	(581, 1, 'UPDATE funcionario SET senha = \'698dc19d489c4e4db73e28a713eab07b\' WHERE id = 8', '2017-04-18 19:42:52', '192.168.1.244'),
	(582, 8, 'INSERT INTO caixa (valor_inicial,valor_fechamento,funcionario_id) VALUES (\'2.22\',NULL,\'8\')', '2017-04-18 19:44:36', '192.168.1.244'),
	(583, 8, 'INSERT INTO caixa (valor_inicial,valor_fechamento,funcionario_id) VALUES (\'2.22\',NULL,\'8\')', '2017-04-18 19:44:44', '192.168.1.244'),
	(584, 8, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'18/04/2017 19:45:05\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'28\')', '2017-04-18 19:45:05', '192.168.1.244'),
	(585, 8, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'131\',\'27\',\'1\',\'5\')', '2017-04-18 19:45:06', '192.168.1.244'),
	(586, 8, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'123\', tem_estoque = \'y\' WHERE id = 27', '2017-04-18 19:45:06', '192.168.1.244'),
	(587, 8, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'28\' WHERE id = 131', '2017-04-18 19:45:06', '192.168.1.244'),
	(588, 8, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'131\',NULL,\'1\',\'5\')', '2017-04-18 19:45:06', '192.168.1.244'),
	(589, 8, 'UPDATE caixa SET valor_fechamento = \'3.34\', funcionario_id = \'8\', dt_fechamento = STR_TO_DATE(\'18/04/2017 19:46:12\', \'%d/%m/%Y %H:%i:%s\') WHERE id = 28', '2017-04-18 19:46:12', '192.168.1.244'),
	(590, 8, 'UPDATE caixa SET valor_fechamento = \'3.33\', funcionario_id = \'8\', dt_fechamento = STR_TO_DATE(\'18/04/2017 19:46:59\', \'%d/%m/%Y %H:%i:%s\') WHERE id = 29', '2017-04-18 19:46:59', '192.168.1.244'),
	(591, 8, 'INSERT INTO caixa (valor_inicial,valor_fechamento,funcionario_id) VALUES (\'23.45\',NULL,\'8\')', '2017-04-18 19:50:10', '192.168.1.244'),
	(592, 8, 'UPDATE caixa SET valor_fechamento = \'3.34\', funcionario_id = \'8\', dt_fechamento = STR_TO_DATE(\'18/04/2017 19:51:39\', \'%d/%m/%Y %H:%i:%s\') WHERE id = 30', '2017-04-18 19:51:39', '192.168.1.244'),
	(593, 8, 'INSERT INTO caixa (valor_inicial,valor_fechamento,funcionario_id) VALUES (\'453.45\',NULL,\'8\')', '2017-04-18 19:51:42', '192.168.1.244'),
	(594, 8, 'UPDATE caixa SET valor_fechamento = \'0.03\', funcionario_id = \'8\', dt_fechamento = STR_TO_DATE(\'18/04/2017 19:51:52\', \'%d/%m/%Y %H:%i:%s\') WHERE id = 31', '2017-04-18 19:51:52', '192.168.1.244'),
	(595, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'18/04/2017 20:05:36\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'25\')', '2017-04-18 20:05:36', '192.168.1.244'),
	(596, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'132\',\'27\',\'1\',\'5\')', '2017-04-18 20:05:37', '192.168.1.244'),
	(597, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'122\', tem_estoque = \'y\' WHERE id = 27', '2017-04-18 20:05:37', '192.168.1.244'),
	(598, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'25\' WHERE id = 132', '2017-04-18 20:05:37', '192.168.1.244'),
	(599, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'18/04/2017 20:05:49\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'25\')', '2017-04-18 20:05:49', '192.168.1.244'),
	(600, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'133\',\'27\',\'1\',\'5\')', '2017-04-18 20:05:49', '192.168.1.244'),
	(601, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'121\', tem_estoque = \'y\' WHERE id = 27', '2017-04-18 20:05:49', '192.168.1.244'),
	(602, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'25\' WHERE id = 133', '2017-04-18 20:05:49', '192.168.1.244'),
	(603, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'18/04/2017 20:07:05\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'25\')', '2017-04-18 20:07:05', '192.168.1.244'),
	(604, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'134\',\'27\',\'1\',\'5\')', '2017-04-18 20:07:06', '192.168.1.244'),
	(605, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'120\', tem_estoque = \'y\' WHERE id = 27', '2017-04-18 20:07:06', '192.168.1.244'),
	(606, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'25\' WHERE id = 134', '2017-04-18 20:07:06', '192.168.1.244'),
	(607, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'18/04/2017 20:07:49\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'25\')', '2017-04-18 20:07:49', '192.168.1.244'),
	(608, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'135\',\'27\',\'1\',\'5\')', '2017-04-18 20:07:49', '192.168.1.244'),
	(609, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'119\', tem_estoque = \'y\' WHERE id = 27', '2017-04-18 20:07:49', '192.168.1.244'),
	(610, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'25\' WHERE id = 135', '2017-04-18 20:07:49', '192.168.1.244'),
	(611, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'18/04/2017 20:08:12\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'25\')', '2017-04-18 20:08:12', '192.168.1.244'),
	(612, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'136\',\'27\',\'1\',\'5\')', '2017-04-18 20:08:13', '192.168.1.244'),
	(613, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'118\', tem_estoque = \'y\' WHERE id = 27', '2017-04-18 20:08:13', '192.168.1.244'),
	(614, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'25\' WHERE id = 136', '2017-04-18 20:08:13', '192.168.1.244'),
	(615, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor,desconto,caixa_id) VALUES (\'2\',\'D\',\'5\',\'0\',\'25\')', '2017-04-18 20:08:13', '192.168.1.244'),
	(616, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'136\',NULL,\'4\',\'5\')', '2017-04-18 20:08:13', '192.168.1.244'),
	(617, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor,desconto,caixa_id) VALUES (\'2\',\'C\',\'5.00\',\'0\',\'25\')', '2017-04-18 20:09:29', '192.168.1.244'),
	(618, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (NULL,\'27\',\'1\',\'5.00\')', '2017-04-18 20:09:29', '192.168.1.244'),
	(619, 1, 'UPDATE caixa SET valor_fechamento = \'80.00\', funcionario_id = \'1\', dt_fechamento = STR_TO_DATE(\'18/04/2017 20:36:02\', \'%d/%m/%Y %H:%i:%s\') WHERE id = 25', '2017-04-18 20:36:02', '192.168.1.244'),
	(620, 1, 'INSERT INTO caixa (valor_inicial,valor_fechamento,funcionario_id) VALUES (\'4.56\',NULL,\'1\')', '2017-04-18 20:37:44', '192.168.1.244'),
	(621, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'18/04/2017 20:38:48\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'32\')', '2017-04-18 20:38:49', '192.168.1.244'),
	(622, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'137\',\'27\',\'1\',\'5\')', '2017-04-18 20:38:49', '192.168.1.244'),
	(623, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'117\', tem_estoque = \'y\' WHERE id = 27', '2017-04-18 20:38:49', '192.168.1.244'),
	(624, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'32\' WHERE id = 137', '2017-04-18 20:38:49', '192.168.1.244'),
	(625, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'137\',NULL,\'1\',\'5\')', '2017-04-18 20:38:49', '192.168.1.244'),
	(626, 1, 'UPDATE caixa SET valor_fechamento = \'5.00\', funcionario_id = \'1\', dt_fechamento = STR_TO_DATE(\'18/04/2017 21:23:22\', \'%d/%m/%Y %H:%i:%s\') WHERE id = 32', '2017-04-18 21:23:22', '192.168.1.244'),
	(627, 1, 'INSERT INTO caixa (valor_inicial,valor_fechamento,funcionario_id) VALUES (\'5.55\',NULL,\'1\')', '2017-04-18 21:23:25', '192.168.1.244'),
	(628, 1, 'INSERT INTO caixa (valor_inicial,valor_fechamento,funcionario_id) VALUES (\'15.20\',NULL,\'1\')', '2017-04-19 08:04:46', '127.0.0.1'),
	(629, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'19/04/2017 08:05:09\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'34\')', '2017-04-19 08:05:09', '127.0.0.1'),
	(630, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'138\',\'27\',\'1\',\'5\')', '2017-04-19 08:05:09', '127.0.0.1'),
	(631, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque = \'116\', tem_estoque = \'y\' WHERE id = 27', '2017-04-19 08:05:09', '127.0.0.1'),
	(632, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'34\' WHERE id = 138', '2017-04-19 08:05:09', '127.0.0.1'),
	(633, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'138\',NULL,\'1\',\'5\')', '2017-04-19 08:05:09', '127.0.0.1'),
	(634, 1, 'INSERT INTO entrada_produto (tipo,produto_id,fornecedor_id,quantidade,lote,dt_compra,dt_validade,valor_unitario,valor_total,motivo_saida) VALUES (\'E\',\'32\',NULL,\'200\',NULL,STR_TO_DATE(\'19/04/2017 08:58\', \'%d/%m/%Y %H:%i:%s\'),STR_TO_DATE(\'19/04/2017\', \'%d/%m/%Y %H:%i:%s\'),\'0.24\',\'2.34\',NULL)', '2017-04-19 08:58:21', '127.0.0.1'),
	(635, 1, ' UPDATE produto\r\n                                               SET estoque = (CASE WHEN estoque IS NULL THEN 200 ELSE (estoque + 200) END)\r\n                                               WHERE id = \'32\' ', '2017-04-19 08:58:21', '127.0.0.1'),
	(636, 1, 'INSERT INTO pessoa (status,tipo,rua,numero,bairro,cidade,uf,cep,pais,telefone,email) VALUES (\'AT\',\'J\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',\'\',NULL)', '2017-04-19 10:40:54', '127.0.0.1'),
	(637, 1, 'INSERT INTO juridica (pessoa_id,cnpj,razao_social,nome_fantasia,inscricao_estadual,ccm) VALUES (\'78\',\'55.073.636/0001-55\',\'teste\',\'Teste\',NULL,NULL)', '2017-04-19 10:40:55', '127.0.0.1'),
	(638, 1, 'UPDATE produto SET codigo = \'001\', codbar = \'\', categoria_id = \'3\', nome = \'Teste\', descricao = \'\', valor = \'5.00\', unidade_id = \'1\', estoque_min = \'116\', tem_estoque = \'y\' WHERE id = 27', '2017-04-20 08:02:47', '127.0.0.1'),
	(639, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'20/04/2017 10:24:08\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'34\')', '2017-04-20 10:24:08', '127.0.0.1'),
	(640, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'139\',\'27\',\'1\',\'5\')', '2017-04-20 10:24:09', '127.0.0.1'),
	(641, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque_min = \'116\', estoque = \'115\', tem_estoque = \'y\' WHERE id = 27', '2017-04-20 10:24:09', '127.0.0.1'),
	(642, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'34\' WHERE id = 139', '2017-04-20 10:24:09', '127.0.0.1'),
	(643, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'139\',NULL,\'1\',\'5\')', '2017-04-20 10:24:09', '127.0.0.1'),
	(644, 1, 'UPDATE venda SET desconto = \'0.00\', total = \'5.00\', data = STR_TO_DATE(\'2017-04-20 10:24:08\', \'%d/%m/%Y %H:%i:%s\'), status = \'C\', comanda_mesa_id = \'1\', caixa_id = \'34\' WHERE id = 139', '2017-04-20 13:29:46', '127.0.0.1'),
	(645, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'20/04/2017 13:34:31\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'34\')', '2017-04-20 13:34:31', '127.0.0.1'),
	(646, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'140\',\'27\',\'1\',\'5\')', '2017-04-20 13:34:31', '127.0.0.1'),
	(647, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque_min = \'116\', estoque = \'114\', tem_estoque = \'y\' WHERE id = 27', '2017-04-20 13:34:31', '127.0.0.1'),
	(648, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'34\' WHERE id = 140', '2017-04-20 13:34:31', '127.0.0.1'),
	(649, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor,desconto,caixa_id) VALUES (\'2\',\'D\',\'5\',\'0\',\'34\')', '2017-04-20 13:34:32', '127.0.0.1'),
	(650, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'140\',NULL,\'4\',\'5\')', '2017-04-20 13:34:32', '127.0.0.1'),
	(651, 1, 'UPDATE venda SET desconto = \'0.00\', total = \'5.00\', data = STR_TO_DATE(\'2017-04-20 13:34:31\', \'%d/%m/%Y %H:%i:%s\'), status = \'C\', comanda_mesa_id = \'1\', caixa_id = \'34\' WHERE id = 140', '2017-04-20 13:34:41', '127.0.0.1'),
	(652, 1, 'SET @liq := 0', '2017-04-20 17:03:43', '127.0.0.1'),
	(653, 1, 'SET @liq := 0', '2017-04-20 17:04:59', '127.0.0.1'),
	(654, 1, 'SET @liq := 0', '2017-04-20 17:05:13', '127.0.0.1'),
	(655, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'24/04/2017 08:02:53\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'34\')', '2017-04-24 08:02:54', '127.0.0.1'),
	(656, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'141\',\'32\',\'1\',\'15.21\')', '2017-04-24 08:02:55', '127.0.0.1'),
	(657, 1, 'UPDATE produto SET codigo = \'003\', categoria_id = \'3\', nome = \'Produto 2\', valor = \'15.21\', unidade_id = \'1\', estoque = \'199\', tem_estoque = \'y\' WHERE id = 32', '2017-04-24 08:02:56', '127.0.0.1'),
	(658, 1, 'UPDATE venda SET desconto = \'0\', total = \'15.21\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'34\' WHERE id = 141', '2017-04-24 08:02:56', '127.0.0.1'),
	(659, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'141\',NULL,\'1\',\'15.21\')', '2017-04-24 08:02:56', '127.0.0.1'),
	(660, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'24/04/2017 08:03:06\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'34\')', '2017-04-24 08:03:06', '127.0.0.1'),
	(661, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'142\',\'27\',\'5\',\'25\')', '2017-04-24 08:03:06', '127.0.0.1'),
	(662, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque_min = \'116\', estoque = \'109\', tem_estoque = \'y\' WHERE id = 27', '2017-04-24 08:03:07', '127.0.0.1'),
	(663, 1, 'UPDATE venda SET desconto = \'0\', total = \'25\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'34\' WHERE id = 142', '2017-04-24 08:03:07', '127.0.0.1'),
	(664, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'142\',NULL,\'1\',\'25\')', '2017-04-24 08:03:07', '127.0.0.1'),
	(665, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'24/04/2017 08:03:28\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'34\')', '2017-04-24 08:03:28', '127.0.0.1'),
	(666, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'143\',\'33\',\'0.350\',\'11.2\')', '2017-04-24 08:03:28', '127.0.0.1'),
	(667, 1, 'UPDATE produto SET codigo = \'004\', categoria_id = \'3\', nome = \'Mussarela\', valor = \'32.00\', unidade_id = \'3\', estoque = \'-0.35\', tem_estoque = \'n\' WHERE id = 33', '2017-04-24 08:03:28', '127.0.0.1'),
	(668, 1, 'UPDATE venda SET desconto = \'0\', total = \'11.2\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'34\' WHERE id = 143', '2017-04-24 08:03:28', '127.0.0.1'),
	(669, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'143\',NULL,\'1\',\'11.2\')', '2017-04-24 08:03:29', '127.0.0.1'),
	(670, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'24/04/2017 08:03:37\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'34\')', '2017-04-24 08:03:37', '127.0.0.1'),
	(671, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'144\',\'27\',\'2\',\'10\')', '2017-04-24 08:03:38', '127.0.0.1'),
	(672, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque_min = \'116\', estoque = \'107\', tem_estoque = \'y\' WHERE id = 27', '2017-04-24 08:03:38', '127.0.0.1'),
	(673, 1, 'UPDATE venda SET desconto = \'0\', total = \'10\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'34\' WHERE id = 144', '2017-04-24 08:03:38', '127.0.0.1'),
	(674, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'144\',NULL,\'1\',\'10\')', '2017-04-24 08:03:38', '127.0.0.1'),
	(675, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'24/04/2017 09:40:07\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'34\')', '2017-04-24 09:40:07', '127.0.0.1'),
	(676, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'145\',\'27\',\'1\',\'5\')', '2017-04-24 09:40:08', '127.0.0.1'),
	(677, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque_min = \'116\', estoque = \'106\', tem_estoque = \'y\' WHERE id = 27', '2017-04-24 09:40:08', '127.0.0.1'),
	(678, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'34\' WHERE id = 145', '2017-04-24 09:40:08', '127.0.0.1'),
	(679, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor,desconto,caixa_id) VALUES (\'2\',\'D\',\'5\',\'0\',\'34\')', '2017-04-24 09:40:08', '127.0.0.1'),
	(680, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'145\',NULL,\'4\',\'5\')', '2017-04-24 09:40:09', '127.0.0.1'),
	(681, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,NULL,\'0\',STR_TO_DATE(\'24/04/2017 09:41:39\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'34\')', '2017-04-24 09:41:39', '127.0.0.1'),
	(682, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'146\',\'27\',\'1\',\'5\')', '2017-04-24 09:41:39', '127.0.0.1'),
	(683, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque_min = \'116\', estoque = \'105\', tem_estoque = \'y\' WHERE id = 27', '2017-04-24 09:41:39', '127.0.0.1'),
	(684, 1, 'UPDATE venda SET desconto = \'\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'34\' WHERE id = 146', '2017-04-24 09:41:40', '127.0.0.1'),
	(685, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor,desconto,caixa_id) VALUES (\'2\',\'D\',\'5\',\'0\',\'34\')', '2017-04-24 09:41:40', '127.0.0.1'),
	(686, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'146\',NULL,\'4\',\'5\')', '2017-04-24 09:41:40', '127.0.0.1'),
	(687, 1, 'INSERT INTO config (nome_empresa,desc_cupom,print_port) VALUES (\'Empresa\',\'\',\'\')', '2017-04-25 09:05:56', '127.0.0.1'),
	(688, 1, 'INSERT INTO config (nome_empresa,desc_cupom,print_port) VALUES (\'Empresa\',\'\',\'\')', '2017-04-25 09:06:09', '127.0.0.1'),
	(689, 1, 'INSERT INTO config (nome_empresa,desc_cupom,print_port) VALUES (\'Empresa\',\'\',\'\')', '2017-04-25 09:06:48', '127.0.0.1'),
	(690, 1, 'INSERT INTO config (nome_empresa,desc_cupom,print_port) VALUES (\'ComÃ©rcio MK\',\'\',\'\')', '2017-04-25 09:10:42', '127.0.0.1'),
	(691, 1, 'INSERT INTO config (nome_empresa,desc_cupom,print_port) VALUES (\'ComÃ©rcio\',\'\',\'\')', '2017-04-25 09:11:57', '127.0.0.1'),
	(692, 1, 'UPDATE config SET nome_empresa = \'ComÃ©rcio\' WHERE id = 1', '2017-04-25 09:13:19', '127.0.0.1'),
	(693, 1, 'UPDATE config SET nome_empresa = \'ComÃ©rcio\' WHERE id = 1', '2017-04-25 09:13:51', '127.0.0.1'),
	(694, 1, 'UPDATE config SET nome_empresa = \'Comercio asdasdadadssad\' WHERE id = 1', '2017-04-25 09:14:37', '127.0.0.1'),
	(695, 1, 'UPDATE config SET nome_empresa = \'Nome do Comercio LTDA\' WHERE id = 1', '2017-04-25 09:14:55', '127.0.0.1'),
	(696, 1, 'INSERT INTO venda (cliente_id,desconto,total,data,status,comanda_mesa_id,caixa_id) VALUES (NULL,\'0\',\'0\',STR_TO_DATE(\'26/04/2017 15:38:51\', \'%d/%m/%Y %H:%i:%s\'),\'F\',\'1\',\'34\')', '2017-04-26 15:38:51', '127.0.0.1'),
	(697, 1, 'INSERT INTO itens_venda (venda_id,produto_id,quantidade,valor_unitario) VALUES (\'147\',\'27\',\'1\',\'5\')', '2017-04-26 15:38:51', '127.0.0.1'),
	(698, 1, 'UPDATE produto SET codigo = \'001\', categoria_id = \'3\', nome = \'Teste\', valor = \'5.00\', unidade_id = \'1\', estoque_min = \'116\', estoque = \'104\', tem_estoque = \'y\' WHERE id = 27', '2017-04-26 15:38:51', '127.0.0.1'),
	(699, 1, 'UPDATE venda SET desconto = \'0\', total = \'5\', status = \'F\', comanda_mesa_id = \'1\', caixa_id = \'34\' WHERE id = 147', '2017-04-26 15:38:51', '127.0.0.1'),
	(700, 1, 'INSERT INTO fisica_conta (fisica_id,tipo,valor,desconto,caixa_id,venda_id) VALUES (\'2\',\'D\',\'5\',\'0\',\'34\',\'147\')', '2017-04-26 15:38:52', '127.0.0.1'),
	(701, 1, 'INSERT INTO venda_pagto (venda_id,fisica_conta_id,forma_pagto_id,valor) VALUES (\'147\',NULL,\'4\',\'5\')', '2017-04-26 15:38:52', '127.0.0.1'),
	(702, 1, 'UPDATE venda SET desconto = \'0.00\', total = \'5.00\', data = STR_TO_DATE(\'2017-04-26 15:38:51\', \'%d/%m/%Y %H:%i:%s\'), status = \'C\', comanda_mesa_id = \'1\', caixa_id = \'34\' WHERE id = 147', '2017-04-26 16:19:17', '127.0.0.1'),
	(703, 1, 'UPDATE venda SET desconto = \'0.00\', total = \'5.00\', data = STR_TO_DATE(\'2017-04-26 16:19:16\', \'%d/%m/%Y %H:%i:%s\'), status = \'C\', comanda_mesa_id = \'1\', caixa_id = \'34\' WHERE id = 147', '2017-04-26 16:27:10', '127.0.0.1'),
	(704, 1, 'INSERT INTO produto SET codigo = NULL,codbar = NULL,categoria_id = \'3\',nome = \'Produto 3\',descricao = NULL,valor = \'15.22\',unidade_id = \'1\',estoque_min = NULL,estoque = NULL,tem_estoque = \'y\'', '2017-04-27 08:22:14', '127.0.0.1'),
	(705, 1, 'UPDATE produto SET codigo = NULL,codbar = NULL,categoria_id = \'3\',nome = \'Produto 3\',descricao = NULL,valor = \'15.22\',unidade_id = \'1\',estoque_min = NULL,estoque = NULL,tem_estoque = \'y\' WHERE id = 34', '2017-04-27 08:22:36', '127.0.0.1'),
	(706, 1, 'UPDATE produto SET active = \'n\' WHERE id = 33', '2017-04-27 10:16:22', '127.0.0.1'),
	(707, 1, 'UPDATE produto SET active = \'n\' WHERE id = 33', '2017-04-27 10:16:44', '127.0.0.1'),
	(708, 1, 'UPDATE produto SET active = \'n\' WHERE id = 32', '2017-04-27 10:16:54', '127.0.0.1'),
	(709, 1, 'UPDATE produto SET codigo = \'003\',codbar = NULL,categoria_id = \'3\',nome = \'Produto 2\',descricao = NULL,valor = \'15.21\',unidade_id = \'1\',estoque_min = NULL,estoque = NULL,tem_estoque = \'y\',active = NULL WHERE id = 32', '2017-04-27 10:18:07', '127.0.0.1');
/*!40000 ALTER TABLE `log` ENABLE KEYS */;


-- Copiando estrutura para tabela mm_bd.modulo
CREATE TABLE IF NOT EXISTS `modulo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `text` varchar(200) NOT NULL COMMENT 'label',
  `pai` int(11) DEFAULT NULL,
  `statusID` tinytext,
  `link` varchar(255) DEFAULT NULL,
  `ordem` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_modulo_modulo1_idx` (`pai`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela mm_bd.modulo: ~20 rows (aproximadamente)
/*!40000 ALTER TABLE `modulo` DISABLE KEYS */;
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
/*!40000 ALTER TABLE `modulo` ENABLE KEYS */;


-- Copiando estrutura para tabela mm_bd.modulo_priv
CREATE TABLE IF NOT EXISTS `modulo_priv` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `modulo_id` int(11) NOT NULL DEFAULT '0',
  `texto` varchar(50) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_modulo_priv_modulo` (`modulo_id`),
  CONSTRAINT `FK_modulo_priv_modulo` FOREIGN KEY (`modulo_id`) REFERENCES `modulo` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela mm_bd.modulo_priv: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `modulo_priv` DISABLE KEYS */;
/*!40000 ALTER TABLE `modulo_priv` ENABLE KEYS */;


-- Copiando estrutura para tabela mm_bd.pessoa
CREATE TABLE IF NOT EXISTS `pessoa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `status` varchar(2) NOT NULL COMMENT 'AT=ATIVO\nIN=INATIVO\n',
  `tipo` varchar(1) NOT NULL COMMENT 'F=FISICA\nJ=JURIDICA\n',
  `rua` varchar(100) DEFAULT NULL,
  `numero` varchar(5) DEFAULT NULL,
  `bairro` varchar(100) DEFAULT NULL,
  `cidade` varchar(100) DEFAULT NULL,
  `uf` varchar(2) DEFAULT NULL,
  `cep` varchar(30) DEFAULT NULL,
  `pais` varchar(45) DEFAULT NULL,
  `telefone` varchar(30) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `dt_atualizacao` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `dt_cadastro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela mm_bd.pessoa: ~48 rows (aproximadamente)
/*!40000 ALTER TABLE `pessoa` DISABLE KEYS */;
INSERT INTO `pessoa` (`id`, `status`, `tipo`, `rua`, `numero`, `bairro`, `cidade`, `uf`, `cep`, `pais`, `telefone`, `email`, `dt_atualizacao`, `dt_cadastro`) VALUES
	(1, 'AT', 'F', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'fsd@asdas.com', '2017-04-18 18:48:05', '2017-03-27 17:14:40'),
	(31, 'AT', 'F', '', '', '', '', '', '', '', '(11) 11111-1111', 'ulisses.bueno@gmail.com', '2017-04-03 09:25:21', '2017-04-03 09:25:21'),
	(32, 'AT', '', '', '', '', '', '', '', '', '(32) 13213-2132', '321321', '2017-04-04 11:45:56', '2017-04-04 11:45:56'),
	(33, 'AT', '', '', '', '', '', '', '', '', '(12) 13213-2132', 'teste@gadsc.com', '2017-04-04 13:19:16', '2017-04-04 13:19:16'),
	(34, 'AT', '', '', '', '', '', '', '', '', '(11) 11111-1111', 'er@sdsd.com', '2017-04-04 13:20:12', '2017-04-04 13:20:12'),
	(35, 'AT', '', '', '', '', '', '', '', '', '(66) 66666-6666', 'andre@viado.com.br', '2017-04-05 09:06:44', '2017-04-04 14:07:36'),
	(36, 'AT', '', '', '', '', '', '', '', '', '(11) 11111-1111', 'terrete', '2017-04-04 17:29:01', '2017-04-04 17:29:01'),
	(37, 'AT', '', '', '', '', '', '', '', '', '(55) 55555-5555', 'teste', '2017-04-04 17:30:44', '2017-04-04 17:30:44'),
	(38, 'AT', '', '', '', '', '', '', '', '', '(88) 88888-8888', 'teste@teste.com.br', '2017-04-04 17:36:21', '2017-04-04 17:36:21'),
	(39, 'AT', '', '', '', '', '', '', '', '', '(88) 88888-8888', 'teste@teste.com.br', '2017-04-04 17:38:37', '2017-04-04 17:38:37'),
	(40, 'AT', '', '', '', '', '', '', '', '', '(55) 55555-5555', 'email@email.com', '2017-04-05 09:41:04', '2017-04-05 09:41:04'),
	(41, 'AT', '', '', '', '', '', '', '', '', '(66) 66666-6666', 'email@email.com', '2017-04-05 09:48:09', '2017-04-05 09:48:09'),
	(42, 'AT', '', '', '', '', '', '', '', '', '(32) 13213-2132', 'fsf@dfsdf.com', '2017-04-05 09:48:56', '2017-04-05 09:48:56'),
	(43, 'AT', '', '', '', '', '', '', '', '', '(88) 88888-8888', 'sfsd@sds.com', '2017-04-05 09:52:08', '2017-04-05 09:52:08'),
	(44, 'AT', '', '', '', '', '', '', '', '', '(99) 99999-9999', 'dfsd@sdfsd.com', '2017-04-05 09:53:35', '2017-04-05 09:53:35'),
	(45, 'AT', '', '', '', '', '', '', '', '', '(99) 99999-9999', 'dsfsd@adas.com', '2017-04-05 09:58:03', '2017-04-05 09:58:03'),
	(47, 'AT', '', '', '', '', '', '', '', '', '', 'email@eamil.com', '2017-04-18 18:47:55', '2017-04-18 10:53:56'),
	(48, 'AT', '', '', '', '', '', '', '', '', '', 'fulano@fmail.com', '2017-04-18 11:02:52', '2017-04-18 11:02:52'),
	(49, 'AT', 'F', '', '', '', '', '', '', '', '(55) 55555-5555', 'email@email.com', '2017-04-18 11:07:04', '2017-04-18 11:07:04'),
	(50, 'AT', 'F', '', '', '', '', '', '', '', '(66) 66666-6666', 'ea@asda.com', '2017-04-18 11:13:43', '2017-04-18 11:13:43'),
	(51, 'AT', 'F', '', '', '', '', '', '', '', '(66) 66666-6666', 'ea@asda.com', '2017-04-18 11:14:20', '2017-04-18 11:14:20'),
	(52, 'AT', 'F', '', '', '', '', '', '', '', '(66) 66666-6666', 'ea@asda.com', '2017-04-18 11:16:16', '2017-04-18 11:16:16'),
	(53, 'AT', 'F', '', '', '', '', '', '', '', '(66) 66666-6666', 'ea@asda.com', '2017-04-18 11:17:30', '2017-04-18 11:17:30'),
	(54, 'AT', 'F', '', '', '', '', '', '', '', '(99) 99999-9999', 'fdgdf@sadsa.com', '2017-04-18 11:23:37', '2017-04-18 11:23:37'),
	(55, 'AT', 'F', '', '', '', '', '', '', '', '(99) 99999-9999', 'fdgdf@sadsa.com', '2017-04-18 11:24:40', '2017-04-18 11:24:40'),
	(56, 'AT', 'F', '', '', '', '', '', '', '', '(55) 55555-5555', 'sfda@asd.com', '2017-04-18 11:27:32', '2017-04-18 11:27:32'),
	(57, 'AT', 'F', '', '', '', '', '', '', '', '(55) 55555-5555', 'sfda@asd.com', '2017-04-18 11:28:58', '2017-04-18 11:28:58'),
	(58, 'AT', 'F', '', '', '', '', '', '', '', '(55) 55555-5555', 'sfda@asd.com', '2017-04-18 11:29:33', '2017-04-18 11:29:33'),
	(59, 'AT', 'F', '', '', '', '', '', '', '', '(55) 55555-5555', 'dsfsd@asdasd.cm', '2017-04-18 11:32:22', '2017-04-18 11:32:22'),
	(60, 'AT', 'F', '', '', '', '', '', '', '', '(99) 99999-9999', 'dfsd@adas.com', '2017-04-18 12:50:58', '2017-04-18 12:50:58'),
	(61, 'AT', 'F', '', '', '', '', '', '', '', '(99) 99999-9999', 'dfsd@adas.com', '2017-04-18 12:52:07', '2017-04-18 12:52:07'),
	(62, 'AT', 'F', '', '', '', '', '', '', '', '(99) 99999-9999', 'dfsd@adas.com', '2017-04-18 12:54:37', '2017-04-18 12:54:37'),
	(63, 'AT', 'F', '', '', '', '', '', '', '', '(99) 99999-9999', 'dfsd@adas.com', '2017-04-18 12:55:07', '2017-04-18 12:55:07'),
	(64, 'AT', 'F', '', '', '', '', '', '', '', '(99) 99999-9999', 'dfsd@adas.com', '2017-04-18 12:55:18', '2017-04-18 12:55:18'),
	(65, 'AT', 'F', '', '', '', '', '', '', '', '(99) 99999-9999', 'dfsd@adas.com', '2017-04-18 12:57:05', '2017-04-18 12:57:05'),
	(66, 'AT', 'F', '', '', '', '', '', '', '', '(99) 99999-9999', 'dfsd@adas.com', '2017-04-18 12:57:25', '2017-04-18 12:57:25'),
	(67, 'AT', 'F', '', '', '', '', '', '', '', '(99) 99999-9999', 'dfsd@adas.com', '2017-04-18 12:59:45', '2017-04-18 12:59:45'),
	(68, 'AT', 'F', '', '', '', '', '', '', '', '(99) 99999-9999', 'dfsd@adas.com', '2017-04-18 13:00:03', '2017-04-18 13:00:03'),
	(69, 'AT', 'F', '', '', '', '', '', '', '', '(99) 99999-9999', 'dfsd@adas.com', '2017-04-18 13:01:35', '2017-04-18 13:01:35'),
	(70, 'AT', 'F', '', '', '', '', '', '', '', '(99) 99999-9999', 'dfsd@adas.com', '2017-04-18 13:01:51', '2017-04-18 13:01:51'),
	(71, 'AT', 'F', '', '', '', '', '', '', '', '(99) 99999-9999', 'dfsd@adas.com', '2017-04-18 13:02:02', '2017-04-18 13:02:02'),
	(72, 'AT', 'F', '', '', '', '', '', '', '', '(99) 99999-9999', 'dfsd@adas.com', '2017-04-18 13:02:16', '2017-04-18 13:02:16'),
	(73, 'AT', 'F', '', '', '', '', '', '', '', '(99) 99999-9999', 'dfsd@adas.com', '2017-04-18 13:02:30', '2017-04-18 13:02:30'),
	(74, 'AT', '', '', '', '', '', '', '', '', '', 'func@empresa.com.br', '2017-04-18 19:37:46', '2017-04-18 19:37:46'),
	(75, 'AT', '', '', '', '', '', '', '', '', '', 'func1@empresa.com.br', '2017-04-18 19:39:03', '2017-04-18 19:39:03'),
	(76, 'AT', '', '', '', '', '', '', '', '', '', 'sfsdf@empresa.com.br', '2017-04-18 19:40:20', '2017-04-18 19:40:20'),
	(77, 'AT', '', '', '', '', '', '', '', '', '', 'teste@teste.com', '2017-04-18 19:42:31', '2017-04-18 19:42:31'),
	(78, 'AT', 'J', '', '', '', '', '', '', '', '', NULL, '2017-04-19 10:40:53', '2017-04-19 10:40:53');
/*!40000 ALTER TABLE `pessoa` ENABLE KEYS */;


-- Copiando estrutura para tabela mm_bd.produto
CREATE TABLE IF NOT EXISTS `produto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(45) DEFAULT NULL,
  `codbar` varchar(255) DEFAULT NULL,
  `categoria_id` int(11) NOT NULL,
  `nome` varchar(200) NOT NULL COMMENT 'label',
  `descricao` varchar(1000) DEFAULT NULL,
  `valor` decimal(7,2) NOT NULL,
  `unidade_id` int(11) NOT NULL,
  `estoque_min` int(11) DEFAULT '0',
  `estoque` int(11) DEFAULT '0',
  `tem_estoque` enum('y','n') NOT NULL DEFAULT 'y',
  `active` enum('y','n') NOT NULL DEFAULT 'y',
  PRIMARY KEY (`id`),
  UNIQUE KEY `codigo_UNIQUE` (`codigo`),
  UNIQUE KEY `codbar_UNIQUE` (`codbar`),
  KEY `fk_produto_categoria1_idx` (`categoria_id`),
  KEY `fk_produto_unidade1_idx` (`unidade_id`),
  CONSTRAINT `fk_produto_categoria1` FOREIGN KEY (`categoria_id`) REFERENCES `categoria` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_produto_unidade1` FOREIGN KEY (`unidade_id`) REFERENCES `unidade` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela mm_bd.produto: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `produto` DISABLE KEYS */;
INSERT INTO `produto` (`id`, `codigo`, `codbar`, `categoria_id`, `nome`, `descricao`, `valor`, `unidade_id`, `estoque_min`, `estoque`, `tem_estoque`, `active`) VALUES
	(1, '000', NULL, 4, 'Livre', NULL, 0.00, 2, 0, -3, 'n', 'y'),
	(27, '001', '', 3, 'Teste', '', 5.00, 1, 116, 104, 'y', 'y'),
	(32, '003', NULL, 3, 'Produto 2', NULL, 15.21, 1, NULL, NULL, 'y', ''),
	(33, '004', NULL, 3, 'Mussarela', NULL, 32.00, 3, NULL, 0, 'n', 'n');
/*!40000 ALTER TABLE `produto` ENABLE KEYS */;


-- Copiando estrutura para tabela mm_bd.unidade
CREATE TABLE IF NOT EXISTS `unidade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(45) NOT NULL COMMENT 'label',
  `active` enum('y','n') NOT NULL DEFAULT 'y',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela mm_bd.unidade: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `unidade` DISABLE KEYS */;
INSERT INTO `unidade` (`id`, `descricao`, `active`) VALUES
	(1, 'Unidade', 'y'),
	(2, 'Livre', 'y'),
	(3, 'Kg', 'y');
/*!40000 ALTER TABLE `unidade` ENABLE KEYS */;


-- Copiando estrutura para tabela mm_bd.venda
CREATE TABLE IF NOT EXISTS `venda` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cliente_id` int(11) DEFAULT NULL,
  `desconto` double(7,2) DEFAULT '0.00',
  `total` decimal(7,2) DEFAULT NULL,
  `data` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` enum('A','F','C') DEFAULT NULL COMMENT 'A = Aberta F = Fechada C = Cancelada',
  `comanda_mesa_id` int(11) DEFAULT '1',
  `caixa_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`,`data`),
  KEY `fk_venda_pessoa1_idx` (`cliente_id`),
  KEY `FK_venda_comanda_mesa` (`comanda_mesa_id`),
  KEY `FK_venda_caixa` (`caixa_id`),
  CONSTRAINT `FK_venda_caixa` FOREIGN KEY (`caixa_id`) REFERENCES `caixa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_venda_comanda_mesa` FOREIGN KEY (`comanda_mesa_id`) REFERENCES `comanda_mesa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_venda_pessoa1` FOREIGN KEY (`cliente_id`) REFERENCES `pessoa` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela mm_bd.venda: ~10 rows (aproximadamente)
/*!40000 ALTER TABLE `venda` DISABLE KEYS */;
INSERT INTO `venda` (`id`, `cliente_id`, `desconto`, `total`, `data`, `status`, `comanda_mesa_id`, `caixa_id`) VALUES
	(138, NULL, 0.00, 25.00, '2017-04-15 08:05:09', 'F', 1, 34),
	(139, NULL, 0.00, 8.50, '2017-04-16 13:29:46', 'C', 1, 34),
	(140, NULL, 5.00, 5.00, '2017-04-20 13:34:41', 'C', 1, 34),
	(141, NULL, 0.00, 15.21, '2017-04-22 08:02:53', 'F', 1, 34),
	(142, NULL, 0.00, 25.00, '2017-04-23 08:03:06', 'F', 1, 34),
	(143, NULL, 0.00, 11.20, '2017-04-24 08:03:28', 'F', 1, 34),
	(144, NULL, 0.00, 10.00, '2017-04-24 08:03:37', 'F', 1, 34),
	(145, NULL, 0.00, 5.00, '2017-04-24 09:40:07', 'F', 1, 34),
	(146, NULL, 0.00, 5.00, '2017-04-24 09:41:39', 'F', 1, 34),
	(147, NULL, 0.00, 5.00, '2017-04-26 16:27:10', 'C', 1, 34);
/*!40000 ALTER TABLE `venda` ENABLE KEYS */;


-- Copiando estrutura para tabela mm_bd.venda_pagto
CREATE TABLE IF NOT EXISTS `venda_pagto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `venda_id` int(11) DEFAULT NULL,
  `fisica_conta_id` int(11) DEFAULT NULL,
  `forma_pagto_id` int(11) NOT NULL DEFAULT '0',
  `valor` double(7,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`),
  KEY `FK_venda_pagto_venda` (`venda_id`),
  KEY `FK_venda_pagto_forma_pagto` (`forma_pagto_id`),
  KEY `fisica_conta_id` (`fisica_conta_id`),
  CONSTRAINT `FK_venda_pagto_forma_pagto` FOREIGN KEY (`forma_pagto_id`) REFERENCES `forma_pagto` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_venda_pagto_venda` FOREIGN KEY (`venda_id`) REFERENCES `venda` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `venda_pagto_ibfk_1` FOREIGN KEY (`fisica_conta_id`) REFERENCES `fisica_conta` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- Copiando dados para a tabela mm_bd.venda_pagto: ~10 rows (aproximadamente)
/*!40000 ALTER TABLE `venda_pagto` DISABLE KEYS */;
INSERT INTO `venda_pagto` (`id`, `venda_id`, `fisica_conta_id`, `forma_pagto_id`, `valor`) VALUES
	(1, 138, NULL, 1, 5.00),
	(2, 139, NULL, 1, 5.00),
	(3, 140, NULL, 4, 5.00),
	(4, 141, NULL, 1, 15.21),
	(5, 142, NULL, 1, 25.00),
	(6, 143, NULL, 1, 11.20),
	(7, 144, NULL, 1, 10.00),
	(8, 145, NULL, 4, 5.00),
	(9, 146, NULL, 4, 5.00),
	(10, 147, NULL, 4, 5.00);
/*!40000 ALTER TABLE `venda_pagto` ENABLE KEYS */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
