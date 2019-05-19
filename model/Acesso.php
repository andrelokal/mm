<?php 
 class Acesso extends DAO{ 
 
	private $table = "acesso";
	private $idName = "id"; 
	private $id;
	private $modulo_id; 
	private $funcionario_id; 
	private $nivel_acesso; 
	private $funcionario; 
	private $modulo; 

 	public function __construct($id = ""){
 
	 	if($id)
	 	 	return $this->selectById($id);
	}
 
	#setters, getters, isset, unset magicos
	public function __set($pname, $pvalue) { $this->$pname = $pvalue; }
	public function __get($pname) { return $this->$pname; }
	public function __isset($pname) { return isset($this->$pname); }
	public function __unset($pname) { unset($this->$pname); }
 
 
	public function selectAll($offset="",$rows=""){
	 	$this->id = "";
	 	$OFL = "";
	 	if($offset){
	 	 	$OFL = " limit ".$offset.",".$rows."";
	 	}
	 	$SQL = " SELECT A.* , B2.text AS modulo FROM acesso A  INNER JOIN modulo B2 ON B2.id = A.modulo_id ";
	 	$collectionThis = parent::doExecuteSelect($SQL.$OFL);
	 	return $collectionThis;
	}
 
	public function select($where){
	 	$collectionThis = parent::doFind($this,$where);

	 	foreach ($collectionThis as $obj){
	 	 	$objFuncionario = new Funcionario();
	 	 	$obj->funcionario = $objFuncionario->selectById($obj->funcionario_id);
	 	}
	 	foreach ($collectionThis as $obj){
	 	 	$objModulo = new Modulo();
	 	 	$obj->modulo = $objModulo->selectById($obj->modulo_id);
	 	}
	 	return $collectionThis;
	}
 
	public function selectById($id){
	 	$this->id = $id;
	 	$objthis = parent::doFind($this);

	 	 $objFuncionario = new Funcionario();
	 	 $objthis->funcionario = $objFuncionario->selectById($objthis->funcionario_id);
	 	 $objModulo = new Modulo();
	 	 $objthis->modulo = $objModulo->selectById($objthis->modulo_id);
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

	public function GravaAcessoBasicoFuncionario( $funcionario_id ){
		$insert = "	INSERT INTO ".$this->table." ( modulo_id, funcionario_id, nivel_acesso ) VALUES 
					( 1, '".$funcionario_id."', NULL ),
					( 15, '".$funcionario_id."', NULL ),
					( 18, '".$funcionario_id."', NULL ) ";
		return parent::doExecuteSQL($insert);

	}
 

}
 ?>