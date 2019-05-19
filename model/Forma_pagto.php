<?php 
 class Forma_pagto extends DAO{ 
 
	private $table = "forma_pagto";
	private $idName = "id"; 
	private $id;
	private $nome; 
	private $active; 
	private $active_c; 

 	public function __construct($id = ""){
 
	 	if($id)
	 	 	return $this->selectById($id);
	}
 
	#setters, getters, isset, unset magicos
	public function __set($pname, $pvalue) { $this->$pname = $pvalue; }
	public function __get($pname) { return $this->$pname; }
	public function __isset($pname) { return isset($this->$pname); }
	public function __unset($pname) { unset($this->$pname); }
 
 
	public function selectAll($offset="",$rows="",$active=""){

	 	$this->id = "";

	 	$where = " WHERE 1=1 ";

 		if( $active == 'v' )	$where .= " AND active='y' ";
 		if( $active == 'c' )	$where .= " AND active_c='y' ";

	 	if($offset){
	 	 	$collectionThis = parent::doFind($this, $where." limit ".$offset.",".$rows."");
	 	}else{	 		
	 	 	$collectionThis = parent::doFind($this, $where);
	 	}
	 	return $collectionThis;
	}
 
	public function select($where){
	 	$collectionThis = parent::doFind($this,$where);
	 	return $collectionThis;
	}
 
	public function selectById($id){
	 	$this->id = $id;
	 	$objthis = parent::doFind($this);
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