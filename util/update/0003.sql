ALTER TABLE `unidade` ADD COLUMN `active` ENUM('y','n') NOT NULL DEFAULT 'y' AFTER `descricao`;
ALTER TABLE `funcionario` CHANGE COLUMN `senha` `senha` VARCHAR(150) NOT NULL AFTER `login`;
INSERT INTO `mm_bd`.`forma_pagto` (`id`, `nome`, `active`) VALUES ('5', 'Fracionado', 'y');
