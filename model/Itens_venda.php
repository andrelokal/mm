<?php 
 class Itens_venda extends DAO{ 
 
	private $table = "itens_venda";
	private $idName = "id"; 
	private $id;
	private $venda_id; 
	private $produto_id; 
	private $quantidade; 
	private $valor_unitario; 
	private $produto; 
	private $venda; 

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
	 	$SQL = " SELECT A.* , B1.nome AS produto FROM itens_venda A  INNER JOIN produto B1 ON B1.id = A.produto_id ";
	 	$collectionThis = parent::doExecuteSelect($SQL.$OFL);
	 	return $collectionThis;
	}
 
	public function select($where){
	 	$collectionThis = parent::doFind($this,$where);

	 	foreach ($collectionThis as $obj){
	 	 	$objProduto = new Produto();
	 	 	$obj->produto = $objProduto->selectById($obj->produto_id);
	 	}
	 	foreach ($collectionThis as $obj){
	 	 	$objVenda = new Venda();
	 	 	$obj->venda = $objVenda->selectById($obj->venda_id);
	 	}
	 	return $collectionThis;
	}
 
	public function selectById($id){
	 	$this->id = $id;
	 	$objthis = parent::doFind($this);

	 	 $objProduto = new Produto();
	 	 $objthis->produto = $objProduto->selectById($objthis->produto_id);
	 	 $objVenda = new Venda();
	 	 $objthis->venda = $objVenda->selectById($objthis->venda_id);
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