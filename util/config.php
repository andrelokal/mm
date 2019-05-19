<?php
@session_start();

//Configuração de Ambiente
ini_set('short_open_tag','1');

date_default_timezone_set('America/Sao_Paulo');

//Caminhos de arquivos do sistema
define("PATH_ROOT", @($_SERVER['DOCUMENT_ROOT']."/"));
define("PATH", @($_SERVER['HTTP_REFERER']."/"));
define("HOST", @($_SERVER['SERVER_ADDR']));

define('CONF',parse_ini_file(PATH_ROOT."util/config.ini"));

//Salt para dados criptografados do sistema
define("KEY", md5('MAGAZINExMANAGER'));

//autoload das classes
function __autoload($classe){
	if(!@include_once PATH_ROOT."model/".$classe.".php");
		if(!@include_once PATH_ROOT."util/".$classe.".php");
			if(!@include_once PATH_ROOT."controller/".$classe.".php");
				if(!@include_once PATH_ROOT."teste/".$classe.".php");
}


?>