<?php 
 class Produto extends DAO{ 
 
	private $table = "produto";
	private $idName = "id"; 
	private $id;
	private $codigo; 
	private $codbar; 
	private $categoria_id; 
	private $nome; 
	private $descricao; 
	private $valor; 
	private $unidade_id; 
	private $categoria; 
	private $unidade; 
	private $tem_estoque;
	private $estoque_min;
	private $estoque;
	private $active;

 	public function __construct($id = ""){
 
	 	if($id)
	 	 	return $this->selectById($id);
	}
 
	#setters, getters, isset, unset magicos
	public function __set($pname, $pvalue) { $this->$pname = $pvalue; }
	public function __get($pname) { return $this->$pname; }
	public function __isset($pname) { return isset($this->$pname); }
	public function __unset($pname) { unset($this->$pname); }
 
 
	public function selectAll($offset="",$rows="",$tem_estoque="",$where=""){
	 	$this->id = "";
	 	$OFL = "";
	 	if($offset){
	 	 	$OFL = " limit ".$offset.",".$rows."";
	 	}
	 	$SQL = " 	SELECT 	A.id,
	 						A.codigo,
	 						A.codbar,
	 						A.categoria_id,
	 						A.nome,
	 						A.descricao,
	 						A.valor,
	 						A.unidade_id,
	 						A.estoque_min,
	 						A.estoque,	 						 
	 						B1.nome AS categoria, B2.descricao AS unidade,
	 						(CASE A.tem_estoque WHEN 'y' THEN 'Sim' ELSE 'Não' END) AS tem_estoque,
	 						(CASE A.tem_estoque WHEN 'y' THEN A.estoque ELSE '---' END) AS estoque,
	 						(CASE WHEN A.estoque <= A.estoque_min THEN 'yes' ELSE 'no' END) AS notify
	 				FROM produto A  
	 				INNER JOIN categoria B1 ON B1.id = A.categoria_id
	 				INNER JOIN unidade B2 ON B2.id = A.unidade_id 
	 				WHERE 1 = 1 ";

	 	// tratar encode com SQL que tem acentuação
	 	$SQL = utf8_decode($SQL);

	 	if( $tem_estoque ){
	 		$SQL .= " AND  tem_estoque = '".$tem_estoque."' ";
	 	}

	 	if( $where ) $SQL .= " AND ".$where;
	 	//$GLOBALS['break'] = 1;
	 	$collectionThis = parent::doExecuteSelect($SQL.$OFL);
	 	return $collectionThis;
	}

 
	public function select($where){

	 	$collectionThis = parent::doFind($this,$where);

	 	foreach ($collectionThis as $obj){
	 	 	$objCategoria = new Categoria();
	 	 	$obj->categoria = $objCategoria->selectById($obj->categoria_id);
	 	}
	 	foreach ($collectionThis as $obj){
	 	 	$objUnidade = new Unidade();
	 	 	$obj->unidade = $objUnidade->selectById($obj->unidade_id);
	 	}
	 	return $collectionThis;
	}
 
	public function selectById($id){
	 	$this->id = $id;
	 	$objthis = parent::doFind($this);

	 	$objCategoria = new Categoria();
	 	$objthis->categoria = $objCategoria->selectById($objthis->categoria_id);
	 	$objUnidade = new Unidade();
	 	$objthis->unidade = $objUnidade->selectById($objthis->unidade_id);
	 	
	 	return $objthis;
	}
	
	
	public function save(){
	 	$result = parent::doSave($this);
	 	return $this;
	}
 
	public function delete(){
	 	if($this->id > 0){
	 	 	$result = parent::doDelete($this);
	 	 	return $result;
	 	}else{
	 	 	return false;
	 	}
	}
 
	public function populationClass($arrDados){
	 	parent::doPopulationClass($this,$arrDados);
	}
 

}
 ?>