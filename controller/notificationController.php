<?php
     class notificationController{
        
        private $obj;
        public $data;
        public $msg;
        
        public function __construct(){
            
        }    
        
        function Notifications(){

            $data = '';

            // Pega notificações Estoque
            $produto = new Produto();
            $resProduto = $produto->selectAll(0,100,'y'," A.estoque <= A.estoque_min ");
            if( $resProduto ){
                $data['estoque'] = $resProduto;
            }

            $this->data = $data;


        }

            
            
     }       
 ?>