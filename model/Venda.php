<?php 
 class Venda extends DAO{ 
 
	private $table = "venda";
	private $idName = "id"; 
	private $id;
	private $cliente_id; 
	private $desconto; 
	private $total;
    private $status; 
	private $data; 
	private $pessoa; 
	private $comanda_mesa_id = 1;

 	public function __construct($id = ""){
 
	 	if($id)
	 	 	return $this->selectById($id);
	}
 
	#setters, getters, isset, unset magicos
	public function __set($pname, $pvalue) { $this->$pname = $pvalue; }
	public function __get($pname) { return $this->$pname; }
	public function __isset($pname) { return isset($this->$pname); }
	public function __unset($pname) { unset($this->$pname); }
 
 
	public function selectAll($offset="",$rows="",$where = ""){
	 	$this->id = "";
	 	$OFL = "";
	 	if($offset){
	 	 	$OFL = " limit ".$offset.",".$rows."";
	 	}
	 	$SQL = " SELECT A.*, DATE_FORMAT(A.data, '%d/%m/%Y %H:%i') AS data_br  FROM venda A WHERE 1=1 ";
	 	if( $where ){
	 		$SQL .= "  AND ".$where;
	 	}
	 	$collectionThis = parent::doExecuteSelect($SQL.$OFL);
	 	return $collectionThis;
	}
 
	public function select($where){
	 	$collectionThis = parent::doFind($this,$where);

	 	foreach ($collectionThis as $obj){
	 	 	$objPessoa = new Pessoa();
	 	 	$obj->pessoa = $objPessoa->selectById($obj->cliente_id);
	 	}
	 	return $collectionThis;
	}
 
	public function selectById($id){
	 	$this->id = $id;
	 	$objthis = parent::doFind($this);

	 	 $objPessoa = new Pessoa();
	 	 $objthis->pessoa = $objPessoa->selectById($objthis->cliente_id);
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

	/*private function custo_diario( $mes, $produto_id = NULL ){
		// Pega custo di
		$SQL_custo = " 	SELECT 	SUM(valor_total) AS total
						FROM  	entrada_produto 						
						WHERE 	tipo = 'E' AND 
								MONTH( dt_compra ) = '".$mes."'	 ";
		
		if( $produto_id ) $SQL_custo .= "  AND produto_id = '".$produto_id."' ";

		$SQL_custo .= " GROUP BY MONTH( dt_compra )
						LIMIT 1 ";
		$res = parent::doExecuteSelect($SQL);
		if( $res ){
			return  $res[0]->total;
		} 

		return 0;
	}*/

	public function relFaturamento( $form, $to, $produto_id = NULL, $group = "", $order = "" ){

		$otherJoins = "";
		$otherSelects = "";

		if( $group == 'product' ){
			$otherJoins .= " JOIN produto C ON A.produto_id = C.id ";
			$otherSelects .= " , C.nome AS produto ";
		}

		$SQL = " 	SELECT 	DATE_FORMAT(B.data, '%d/%m/%Y') AS data_br,
							DATE_FORMAT(B.data, '%d/%m') AS data_dm,
							SUM( ( ( B.desconto * A.valor_unitario) /100 ) ) AS total_desconto,
	 						ABS( SUM( B.total - ((B.desconto * B.total) / 100 )) ) AS total_liquido,
	 						DATE_FORMAT( B.data, '%m/%Y') AS mes

	 						". $otherSelects ."

	 				FROM 	itens_venda A JOIN
	 						venda B ON A.venda_id = B.id ". $otherJoins ."
	 				WHERE 	B.status != 'C'	 ";
		
		// Período - Obrigatório
		$SQL .= "  AND B.data BETWEEN '".$form." 00:00:00' AND '".$to." 23:59:59' ";

		// Filtro por produto
		if( $produto_id ) $SQL .= "  AND A.produto_id = '".$produto_id."' ";
	 	
	 	// Agrupar
		switch ($group) {
	 		case 'month': // Mês
	 			$SQL .= "	GROUP BY MONTH( B.data ) ";
	 			break;

	 		case 'product': // Produto
	 			$SQL .= "	GROUP BY A.produto_id ";
	 			break;
	 		default: // Dia - padarão
	 			$SQL .= "	GROUP BY data_br ";
	 			break;
	 	}	

	 	// Ordenar por data decrescente
	 	$SQL .= " ORDER BY B.data ASC ";
	 	
	 	//$GLOBALS['break'] = 1;

	 	$collectionThis = parent::doExecuteSelect($SQL);
	 	return $collectionThis;

	}

	function sumForma( $form, $to ){
		$SQL = " 	SELECT 	SUM( A.valor ) AS total,
							C.nome AS forma
	 				FROM 	venda_pagto A JOIN
	 						venda B ON A.venda_id = B.id JOIN
	 						forma_pagto C ON A.forma_pagto_id = C.id

	 				WHERE 	1=1 ";
		
		// Período - Obrigatório
		$SQL .= "  AND B.data BETWEEN '".$form." 00:00:00' AND '".$to." 23:59:59' ";

	 	$SQL .= "	GROUP BY A.forma_pagto_id ";
	 	// Ordenar por data decrescente
	 	$SQL .= " ORDER BY B.data ASC ";
	 	
	 	//$GLOBALS['break'] = 1;

	 	$collectionThis = parent::doExecuteSelect($SQL);
	 	return $collectionThis;
	}
	
 

}
 ?>