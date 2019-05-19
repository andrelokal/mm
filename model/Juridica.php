<?php 
 class Juridica extends DAO{ 
 
	private $table = "juridica";
	private $idName = "id"; 
	private $id;
	private $pessoa_id; 
	private $cnpj; 
	private $razao_social; 
	private $nome_fantasia; 
	private $inscricao_estadual; 
	private $ccm; 
	private $pessoa; 

 	public function __construct($id = ""){
 
	 	if($id)
	 	 	return $this->selectById($id);
	}
 
	#setters, getters, isset, unset magicos
	public function __set($pname, $pvalue) { $this->$pname = $pvalue; }
	public function __get($pname) { return $this->$pname; }
	public function __isset($pname) { return isset($this->$pname); }
	public function __unset($pname) { unset($this->$pname); }
 
 
	public function selectAll($offset="",$rows="",$where=""){
	 	$this->id = "";
	 	$OFL = "";
	 	if($offset){
	 	 	$OFL = " limit ".$offset.",".$rows."";
	 	}
	 	$SQL = "SELECT A.*, B1.*, A.id AS id 
	 			FROM juridica A JOIN pessoa B1 ON A.pessoa_id = B1.id AND status='AT'
	 			WHERE 1=1 ";

		if( $where ) $SQL .= " AND ".$where;	 			

	 	$collectionThis = parent::doExecuteSelect($SQL.$OFL);
	 	return $collectionThis;
	}
 
	public function select($where){
	 	$collectionThis = parent::doFind($this,$where);

	 	foreach ($collectionThis as $obj){
	 	 	$objPessoa = new Pessoa();
	 	 	$obj->pessoa = $objPessoa->selectById($obj->pessoa_id);
	 	}
	 	return $collectionThis;
	}
 
	public function selectById($id){
	 	$this->id = $id;
	 	$objthis = parent::doFind($this);

	 	$objPessoa = new Pessoa();
	 	$objthis->pessoa = $objPessoa->selectById($objthis->pessoa_id);
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