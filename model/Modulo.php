<?php
class Modulo extends DAO{
	
	private $table = "modulo";
	private $idName = "id";
	private $id;
	private $text;
	private $pai;
	private $statusID;
	private $link;
	private $children = array(); // Auxiliar por se tratar de uma Lista Dinâmica Encadeada
	
	public function __construct($id = ""){
 
	 	if($id)
	 	 	return $this->selectById($id);
	}
			
	//setters, getters, isset, unset mágicos
	public function __set($pname, $pvalue) { $this->$pname = $pvalue; }
	public function __get($pname) { return $this->$pname; }
	public function __isset($pname) { return isset($this->$pname); }
	public function __unset($pname) { unset($this->$pname); }
	
		
	public function selectAll($offset="",$rows=""){
		$this->id = "";
	 	
		if( $_SESSION['TYPE'] == 'N' ){

			$OFL = "";
		 	if($offset){
		 	 	$OFL = " limit ".$offset.",".$rows."";
		 	}

		 	$SQL = " SELECT A.*
		 			 FROM 	".$this->table." A 	JOIN 
		 			 		acesso B1 	ON 	B1.modulo_id = A.id
		 			 WHERE  B1.funcionario_id = '".$_SESSION['USER']."' AND A.statusID = 1 ORDER BY ordem ";

		 	$collectionThis = parent::doExecuteSelect($SQL.$OFL);

		} else {
			if($offset){
		 	 	$collectionThis = parent::doFind($this, " WHERE statusID = 1 ORDER BY ordem LIMIT ".$offset.",".$rows." ");
		 	}else{	 		
		 	 	$collectionThis = parent::doFind($this, " WHERE statusID = 1 ORDER BY ordem ");
		 	}
		}

	 	return $collectionThis;
	}
	
	public function selectById($id){
		$this->id = $id;
		parent::doFind($this);
		return $this;
	}
	
	public function selectByName($nome){
		$collectionThis = parent::doFind($this,"where text like '%".$nome."%'");
		return $collectionThis;
	}
	
	public function save(){
		$result = parent::doSave($this);
		return $result;
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