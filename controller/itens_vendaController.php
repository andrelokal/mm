<?php
     class Itens_vendaController{
        
        private $obj;
        public $data;
        public $msg;
        
        public function __construct(){
            $this->obj = new Itens_venda();
        }    
        
        public function selectAll($offset = "",$rows = ""){
        
            $response = $this->obj->selectAll($offset,$rows);       
        
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
            
            $response->produto = $obj->produto->nome;
	 	 	$response->venda = $obj->venda->id;
       
        
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

            foreach($arrayDados as $key => $value){
                    $arrayDados[$key] = $value == "" ? "null" : $value;
            }
            
            $itens_venda->populationClass($arrayDados);
            $response = $itens_venda->save();
            
            if($response){
                $this->data = $response;
                $this->msg = "Sucesso";
                return true;
            }else{
                $this->msg = "Sem Resultados";
                return false;
            }

        }
        
        
        public function delete($request){
       
            $arrayDados = json_decode($request, true);
                
            $itens_venda->populationClass($arrayDados);
            $return = $itens_venda->delete();
            
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