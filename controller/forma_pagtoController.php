<?php
     class Forma_pagtoController{
        
        private $obj;
        public $data;
        public $msg;
        
        public function __construct(){
            $this->obj = new Forma_pagto();
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

            if( !array_key_exists('active', $arrayDados ) ) $arrayDados['active'] = NULL;
            if( !array_key_exists('active_c', $arrayDados ) ) $arrayDados['active_c'] = NULL;

            if( array_key_exists('active_c', $arrayDados ) ){
                if( $arrayDados['active_c'] == 'y' && $arrayDados['id'] == '4' ){
                    $this->msg = "Aчуo Nуo permitida";
                    return false;
                }
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