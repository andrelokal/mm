<?php 
 class Help extends DAO{ 
 
	private $table = "help";
	private $idName = "id"; 
	private $id;
	private $title; 
	private $description;
	private $modulo_id;
	private $order;

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
	 	$SQL = " SELECT A.*
	 			 FROM 	".$this->table." A 	
	 			 ORDER BY `order` ";

	 	$collectionThis = parent::doExecuteSelect($SQL);
	 	return $collectionThis;
	}

	public function getItens( $id ){
		
	 	$SQL = " SELECT A.*
	 			 FROM 	help_item A 
	 			 WHERE 	A.help_id = '".$id."'	
	 			 ORDER BY `order_item` ";


	 	$collectionThis = parent::doExecuteSelect($SQL);
	 	return $collectionThis;
	}

	public function getItem( $id ){
		
	 	$SQL = " SELECT A.*, B.title AS parent
	 			 FROM 	help_item A JOIN 
	 			 		help B ON A.help_id = B.id
	 			 WHERE 	A.id = '".$id."' ";


	 	$collectionThis = parent::doExecuteSelect($SQL);
	 	return $collectionThis[0];
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
 
	/*public function save(){
	 	$result = parent::doSave($this);
	 	return $this;
	}*/
 
	/*public function delete(){
	 	if($this->id > 0){
	 	 	$result = parent::doDelete($this);
	 	 	return $result;
	 	}else{
	 	 	return false;
	 	}
	}*/
 
	public function populationClass($arrDados){
	 	parent::doPopulationClass($this,$arrDados);
	}
 

}
 ?>