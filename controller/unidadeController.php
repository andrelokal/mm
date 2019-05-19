<?php
     class UnidadeController{
        
        private $obj;
        public $data;
        public $msg;
        
        public function __construct(){
            $this->obj = new Unidade();
        }    
        
        public function selectAll($offset = "",$rows = "", $active=""){
            $response = $this->obj->selectAll($offset,$rows,$active);       
        
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
            
            $this->obj->populationClass($arrayDados);
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
        
        
        public function delete($request){
       
            $arrayDados = json_decode($request, true);
                
            $unidade->populationClass($arrayDados);
            $return = $unidade->delete();
            
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