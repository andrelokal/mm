<?php
     class moduloController{
        
        private $obj;
        public $data;
        public $msg;
        
        public function __construct(){
            $this->obj = new Modulo();
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
            
            $response->funcionario = $obj->funcionario->login;
	 	 	$response->servico = $obj->servico->text;
       
        
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
            
            $acesso->populationClass($arrayDados);
            $response = $acesso->save();
            
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
                
            $acesso->populationClass($arrayDados);
            $return = $acesso->delete();
            
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