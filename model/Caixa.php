<?php 
 class Caixa extends DAO{ 
 
	private $table = "caixa";
	private $idName = "id"; 
	private $id;
	private $valor_inicial; 
	private $funcionario_id;
	private $dt_abertura;
	private $dt_fechamento;
	private $valor_fechamento;

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
	 	if($offset){
	 	 	$collectionThis = parent::doFind($this, "limit ".$offset.",".$rows."");
	 	}else{	 		
	 	 	$collectionThis = parent::doFind($this);
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

	public function valorEmCaixa(){
		$SQL = " 	SELECT  X.nome, 
							A.forma_pagto_id, 
							SUM(A.valor) AS soma
					FROM 	venda_pagto A LEFT JOIN 
							forma_pagto X ON A.forma_pagto_id = X.id LEFT JOIN
							venda 		B ON A.venda_id = B.id LEFT JOIN
							fisica_conta C ON A.fisica_conta_id = C.id 
					WHERE 	B.caixa_id = '".$this->id."' OR C.caixa_id = '".$this->id."' AND
							B.status != 'C'
					GROUP BY forma_pagto_id 
					ORDER BY forma_pagto_id ";

	 	return parent::doExecuteSelect( $SQL  );
	}
 

}
 ?>