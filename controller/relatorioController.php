<?php
     class relatorioController{
        
        private $obj;
        public $data;
        public $msg;
        public $filter = array( 'from' => '',
                                'to' => '',
                                'produto_id' => '',
                                'group' => '',
                                'order' => '');
        

        public function relVenda(){

            if( !$this->filter->from ) $this->filter->from = date('01/m/Y') ;
            if( !$this->filter->to ) $this->filter->to = date('t/m/Y') ;

            $norm = new Normalize();
            $this->filter->from = $norm->date_mysql( $this->filter->from );
            $this->filter->to = $norm->date_mysql( $this->filter->to );

            $venda = new Venda();
            $response = $venda->relFaturamento( $this->filter->from, 
                                                $this->filter->to, 
                                                $this->filter->produto_id, 
                                                $this->filter->group,
                                                $this->filter->order);
            if($response){

                // somar total
                $sum = 0;
                foreach( $response as $v ){
                    $sum += $v->total_liquido;
                }

                $this->data['rel'] = $response;
                $this->data['total'] = $sum;
                $this->msg = "Sucesso";
                return true;
            }else{
                $this->msg = "Sem Resultados";
                return false;
            }

        }

        public function relForma(){

            if( !$this->filter->from ) $this->filter->from = date('01/m/Y') ;
            if( !$this->filter->to ) $this->filter->to = date('t/m/Y') ;

            $norm = new Normalize();
            $this->filter->from = $norm->date_mysql( $this->filter->from );
            $this->filter->to = $norm->date_mysql( $this->filter->to );

            $venda = new Venda();
            $response = $venda->sumForma( $this->filter->from, 
                                          $this->filter->to );
            if($response){
                $this->data = $response;
                $this->msg = "Sucesso";
                return true;
            }else{
                $this->msg = "Sem Resultados";
                return false;
            }

        }

        public function relProduto(){

            if( !$this->filter->from ) $this->filter->from = date('01/m/Y') ;
            if( !$this->filter->to ) $this->filter->to = date('t/m/Y') ;

            $norm = new Normalize();
            $this->filter->from = $norm->date_mysql( $this->filter->from );
            $this->filter->to = $norm->date_mysql( $this->filter->to );

            $venda = new Venda();
            $response = $venda->relFaturamento( $this->filter->from, 
                                                $this->filter->to, 
                                                null, 
                                                'product',
                                                $this->filter->order);

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