<?php 
 class Entrada_produto extends DAO{ 
 
	private $table = "entrada_produto";
	private $idName = "id"; 
	private $id;
	private $produto_id; 
	private $fornecedor_id; 
	private $quantidade; 
	private $lote; 
	private $dt_compra; 
	private $dt_validade; 
	private $valor_unitario; 
	private $valor_total; 
	private $pessoa; 
	private $produto; 
	private $tipo;
	private $motivo_saida;

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

	 	$SQL = " SELECT A.* , 
	 					B2.nome AS produto, 
	 					B2.codigo, 
	 					DATE_FORMAT(MAX(A.dt_compra),'%d/%m/%y') AS dt_compra, 
	 					DATE_FORMAT(A.dt_validade,'%d/%m/%y') AS dt_validade ,
	 					B2.estoque,
	 					B2.estoque_min,
	 					(CASE A.tipo WHEN 'E' THEN 'Entrada'
	 								 WHEN 'S' THEN 'Saida'
	 								 END ) AS tipo,
	 					B2.valor AS valorProd,
	 					(CASE WHEN B2.estoque <= B2.estoque_min THEN 'yes' ELSE 'no' END) AS notify
	 					FROM 	entrada_produto A  INNER JOIN 
	 							produto B2 ON B2.id = A.produto_id
	 					WHERE 1=1";

	 	if( $where ) $SQL .= " AND ".$where;
	 	$SQL .= "		GROUP BY A.produto_id  ";
	 	
	 	$collectionThis = parent::doExecuteSelect($SQL.$OFL);
	 	return $collectionThis;
	}


 
	public function select($where){
	 	$collectionThis = parent::doFind($this,$where);

	 	foreach ($collectionThis as $obj){
	 	 	$objPessoa = new Pessoa();
	 	 	$obj->pessoa = $objPessoa->selectById($obj->fornecedor_id);
	 	}
	 	foreach ($collectionThis as $obj){
	 	 	$objProduto = new Produto();
	 	 	$obj->produto = $objProduto->selectById($obj->produto_id);
	 	}
	 	return $collectionThis;
	}
 
	public function selectById($id){
	 	$this->id = $id;
	 	$objthis = parent::doFind($this);

	 	 $objPessoa = new Pessoa();
	 	 $objthis->pessoa = $objPessoa->selectById($objthis->fornecedor_id);
	 	 $objProduto = new Produto();
	 	 $objthis->produto = $objProduto->selectById($objthis->produto_id);
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