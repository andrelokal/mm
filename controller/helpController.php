<?php
     class helpController{
        
        private $obj;
        public $data;
        public $msg;
        
        public function __construct(){
            $this->obj = new Help();
        }    
        
        public function getItem($id){

            $response = $this->obj->getItem($id);       
        
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