<?php 
 class Config extends DAO{ 
 
	private $table = "config";
	private $idName = "id"; 
	private $id;
	private $nome_empresa; 
	private $desc_cupom; 
	private $print_port; 
 
	#setters, getters, isset, unset magicos
	public function __set($pname, $pvalue) { $this->$pname = $pvalue; }
	public function __get($pname) { return $this->$pname; }
	public function __isset($pname) { return isset($this->$pname); }
	public function __unset($pname) { unset($this->$pname); }
 
 
	public function select($where){
	 	$collectionThis = parent::doFind($this,$where);
	 	return $collectionThis;
	}

	public function save(){
	 	$result = parent::doSave($this);
	 	return $this;
	}
 
	public function populationClass($arrDados){
	 	parent::doPopulationClass($this,$arrDados);
	}

 

}
 ?>