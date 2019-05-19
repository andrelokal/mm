SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

INSERT INTO `comanda_mesa` (`id`, `codigo`, `active`) VALUES
	(1, 'Balcão', 'y');

INSERT INTO `forma_pagto` (`id`, `nome`, `active`) VALUES
	(1, 'Dinheiro', 'y'),
	(2, 'Cartao Debito', 'y'),
	(3, 'Cartao Credito', 'y'),
	(4, 'Conta Cliente', 'y');

INSERT INTO `unidade` (`id`, `descricao`) VALUES
	(1, 'Unidade'),
	(2, 'Ml'),
	(3, 'Kg');

INSERT INTO `pessoa` (`id`, `status`,`tipo`) VALUES
	(1, 'AT','J');

INSERT INTO `funcionario` (`id`, `tipo`, `pessoa_id`, `login`, `senha`, `email`) VALUES
	(1, 'M','1','admin', MD5('admin') , '');


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
