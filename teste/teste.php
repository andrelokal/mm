<?php
include("../util/config.php");


//$obj = new Produto();

//$obj = new Update();

//$obj->read();

$obj = new loginController();
//$obj = new Pessoa();
//$obj  = new Fisica();
//$obj = new Servico();

//$obj = new Servico();
//$obj = new ProdutoController();
//$obj = new ServicoController();
//$obj  = new ViewGenerator('Model');
//echo "<pre>";

//$result = $obj->getTables();

/*
foreach($result as $value){
			$obj->generateByTable($value->Tables_in_mmdb);
}
*/

/*
$obj->codigo = "01"; 
$obj->codbar = "001"; 
$obj->categoria_id = "1"; 
$obj->nome = "Teste"; 
$obj->descricao = "Teste"; 
$obj->valor = "1"; 
$obj->unidade_id = "1"; 

$obj->save();

echo $obj->error;
 */
 
 //echo json_encode(array('cliente_id' => 1,'desconto'=>'0','status'=>'A','itens' => 
 //array(array('produto_id'=>1,'quantidade'=>'2','valor_unitario'=>'3.00'),array('produto_id'=>2,'quantidade'=>'1','valor_unitario'=>'1.50'))));


//$result = $obj->selectBycode('001');
//$result = $obj->getRecursiveList();
//$result = $obj->generateByTable('produto');
//$result = $obj->getConstraint('produto');
//$result = $obj->selectById(1)->getPessoa()->cidade;
//$result = $obj->selectAll(0,100);
//var_dump($obj);
//print_r($result);
//print_r($obj->data);
/*
if(is_array($result))
		echo "<br>array<br>";

//echo $result->COLUNA;
*/

//$salt = crypt('magazinemanager',CRYPT_MD5);

//echo crypt('teste',$salt);

//echo KEY;
/*
$pass = 'werwwef';

echo crypt(preg_replace('/[^[:alnum:]_]/', '',$pass), KEY);
*/
var_dump($obj->login('teste','teste'));

echo "<br> ok";



?>