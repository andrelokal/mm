<?php
     class Entrada_produtoController{
        
        private $obj;
        public $data;
        public $msg;
        public $search;
        
        public function __construct(){
            $this->obj = new Entrada_produto();
        }    
        
        public function selectAll($offset = "",$rows = ""){
            $where = '';
            if( $this->search ){
                $where = " (    B2.codigo LIKE '%".$this->search."%' OR 
                                B2.codbar LIKE '%".$this->search."%' OR
                                B2.nome LIKE '%".$this->search."%' OR 
                                B2.descricao LIKE '%".$this->search."%'  ) ";
            }

            $response = $this->obj->selectAll($offset,$rows,$where);       
        
            if($response){
                $this->data = $response;
                $this->msg = "Sucesso";
                return true;
            }else{
                $this->msg = "Sem Resultados";
                return false;
            }            
        }
        
        
        public function selectById($id){
        
            $response = $this->obj->selectById($id);
            
            $response->pessoa = $obj->pessoa->id;
	 	 	$response->produto = $obj->produto->nome;
       
        
            if($response){
                $this->data = $response;
                $this->msg = "Sucesso";
                return true;
            }else{
                $this->msg = "Sem Resultados";
                return false;
            }
            
        }        
        
        public function save($request){
            
            $this->obj->Transaction('begin');

            $arrayDados = json_decode($request, true);            

            foreach($arrayDados as $key => $value){
                $arrayDados[$key] = $value == "" ? "null" : $value;
            }


            
            $this->obj->populationClass($arrayDados);
            $response = $this->obj->save();

            if( $this->obj->id ){

                if( $this->obj->tipo == 'E' or
                    $this->obj->tipo == 'EX' ){
                    $this->obj->doExecuteSQL(" UPDATE produto
                                               SET estoque = (CASE WHEN estoque IS NULL THEN ".$arrayDados['quantidade']." ELSE (estoque + ".$arrayDados['quantidade'].") END)
                                               WHERE id = '".$arrayDados['produto_id']."' ");    
                }

                if( $this->obj->tipo == 'S' ){

                    $produto = new Produto( $arrayDados['produto_id'] );
                    if( ( $produto->estoque - $arrayDados['quantidade'] ) >= 0 ){
                        $this->obj->doExecuteSQL(" UPDATE produto
                                                   SET estoque = (estoque - ".$arrayDados['quantidade'].") 
                                                   WHERE id = '".$arrayDados['produto_id']."' ");        
                    } else {

                        $this->obj->Transaction('rollback');
                        $this->msg = "Estoque insuficiente !";
                        return false;
                    }
                    
                }
            }

            if($response){
                $this->obj->Transaction('commit');
                $this->data = $response;
                $this->msg = "Sucesso";
                return true;
            }else{
                $this->obj->Transaction('rollback');
                $this->msg = "Sem Resultados";
                return false;
            }

        }
        
        
        public function delete($id){
       
            $this->obj->selectById($id);   
            $return = $this->obj->delete();
            
            if($return){
                $this->data = $response;
                $this->msg = "Sucesso";
                return true;
            }else{
                $this->msg = "Sem Resultados";
                return false;
            }
            
        }

            
            
     }       
 ?>