<?php
     class ProdutoController{
        
        private $obj;
        public $data;
        public $msg;
        public $filter = array();
        public $search;


        public function __construct(){
            $this->obj = new Produto();
        }    
        
        public function selectAll($offset = "",$rows = "",$tem_estoque=""){
            
            $where = '';

            if( $this->filter ){
                $where = [];
                foreach ($this->filter as $key => $value) {
                    $where[] = $key." = '".$value."' ";
                }
                
            }

            if( $this->search ){
                $where []= " (  A.codigo LIKE '%".$this->search."%' OR 
                                A.codbar LIKE '%".$this->search."%' OR
                                A.nome LIKE '%".$this->search."%' OR 
                                A.descricao LIKE '%".$this->search."%' OR 
                                B1.nome LIKE '%".$this->search."%' ) ";
            }

            $where[] = " A.active = 'y' ";

            if( count( $where ) ) $where = implode(" AND ", $where );
            //$GLOBALS['break'] = 1;
            $response = $this->obj->selectAll($offset,$rows,$tem_estoque,$where);       
        
            if($response){
                $this->data = $response;
                $this->msg = "Sucesso";
                return true;
            }else{
                $this->msg = "Sem Resultados";
                return false;
            }
            
        }
        
        
        public function selectBycode($codigo){
            
            $response = $this->obj->select(" where  ( codigo = '".$codigo."' OR codbar = '".$codigo."' ) AND
                                                    ( CASE  WHEN tem_estoque = 'y' 
                                                            THEN estoque > 0
                                                            ELSE 1
                                                            END ) = 1  LIMIT 1 ");
            
            if(is_array($response)){
                foreach($response as $obj){
                    $obj->categoria = $obj->categoria->nome;
                    $obj->unidade = $obj->unidade->descricao;
                }
            }
            
            if($response){
                $this->data = $response[0];
                $this->msg = "Sucesso";
                return true;
            }else{
                $this->msg = "Não existe ou não tem estoque!";
                return false;
            }

        
        }
        
        
        public function selectById($id){
        
            $response = $this->obj->selectById($id);
            
            /*$response->categoria = $this->obj->categoria->nome;
	 	 	$response->unidade = $this->obj->unidade->descricao;  */ 
        
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
            
            $arrayDados = json_decode($request, true); 

            $arrayDados['estoque'] = NULL;
            $arrayDados['active'] = NULL;
            
            /*if( $arrayDados['id'] ) {                
                if( @empty($arrayDados['codbar']) ) unset($arrayDados['codbar']); 
                if( @empty($arrayDados['estoque_min']) ) unset($arrayDados['estoque_min']); 
            } else{
                $arrayDados['estoque'] = NULL;
                if( @empty($arrayDados['codbar']) ) $arrayDados['codbar'] = NULL;
            } */

            foreach($arrayDados as $key => $value){
                $arrayDados[$key] = $value == "" ? "null" : $value;
            }
            
            $this->obj->populationClass($arrayDados);
            //$GLOBALS['break'] = 1;
            $response = $this->obj->save();
            
            if($response){
                $this->data = $response;
                $this->msg = "Sucesso";
                return true;
            }else{
                $this->msg = "Sem Resultados";
                return false;
            }

        }
        
        
        public function delete($id){
        
            $Produto = new Produto();
            $Produto->id = $id;
            $Produto->active = 'n';  
            //$GLOBALS['break'] = 1;         
            $response = $Produto->save();
            
            if($response){
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