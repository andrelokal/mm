<?php 
 class FisicaConta extends DAO{ 
 
	private $table = "fisica_conta";
	private $idName = "id"; 
	private $id;
	private $fisica_id; 
	private $tipo; 
	private $valor;
	private $dt_cadastro;
	private $desconto;
	private $caixa_id;
	private $venda_id;

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
 	
 	public function saldo(){
 		$result = parent::doExecuteSelect(" SELECT 	@creditos := IFNULL(( 	SELECT 	SUM( IF( A.desconto > 0 , (( A.valor * 100 / ( 100 - A.desconto )) - A.valor) + A.valor  , A.valor) )
																			FROM 	fisica_conta A 
																			WHERE 	A.fisica_id = '".$this->fisica_id."' AND 
																				  	A.tipo = 'C' ) ,0),
														
													@debitos := IFNULL((	SELECT 	SUM( A.valor )
																			FROM 	fisica_conta A JOIN 
																					venda B ON A.venda_id = B.id
																			WHERE 	A.fisica_id = '".$this->fisica_id."' AND 
																				  	A.tipo = 'D' AND 
																				  	B.status != 'C' ),0),
													@creditos AS creditos,
													@debitos AS debitos,
													( @creditos - @debitos ) AS total ");
 		return $result[0];
 	}

}
 ?>