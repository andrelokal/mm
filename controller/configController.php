<?php
     class configController{
        
        private $obj;
        public $data;
        public $msg;
        
        public function __construct(){
            $this->obj = new Config();
        }    
        
        
        public function select(){
        
            $response = $this->obj->select(' LIMIT 1 ');

            if($response){
                $this->data = $response[0];
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

            $arrayDados['id'] = 1;
            
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
            
            
     }       
 ?>