<div class="clearfix">&nbsp;</div>
<div class="row">
	<div class="col-md-12">
		<form class="form-inline" id='rel-filter'>
			<div class="form-group">
		    	<select class="form-control" id="group" placeholder="Agrupar" name='group'>
		    		<option value="day">Agrupar por dia</option>
		    		<option value="month">Agrupar por mês</option>
		    		<option value="product">Agrupar por Produto</option>
		    	</select>
		  	</div>
		  	<div class="form-group period">
		  		<div class="input-group">
			  		<span class="input-group-addon" id="basic-addon1">De</span>
			  		<input type="text" class="form-control datepicker" id="from" placeholder="" value="<?=date('01/m/y') ?>" name='form' />
				</div>
				<div class="input-group">
			  		<span class="input-group-addon" id="basic-addon1">Até</span>
			  		<input type="text" class="form-control datepicker" id="to" placeholder="" value="<?=date('t/m/y') ?>" name='to' />
				</div>
		  	</div>
		  	<div class="form-group">
			    <select class="form-control" id="order" placeholder="Ordenar" name='order'>
			    	<option value="date-asc">Data Cresc.</option>
			    	<option value="date-asc">Data Desc.</option>
			    	<option value="value-asc">Mais vendido</option>
			    	<option value="value-desc">Menos vendido</option>
			    </select>
			</div>
		  	<button type="button" class="btn btn-default filter">Filtrar</button>
		  	<button type="button" class="btn btn-default excel">Exportar Excel <span class="glyphicon glyphicon-save" aria-hidden="true"></span></button>
		</form>
	</div>
</div>
<div class="clearfix">&nbsp;</div>
<div class="row">
	<div class="col-md-5">
		<h4>Statística de Vendas</h4>
		<div id="chartVendas" style="height: 200px; width: 100%;"></div>
	</div>
	<div class="col-md-7">
		<div class="row">					
			<div class="col-md-4">	
				<div class="col-md-12"><h4>Gráfico por Produtos</h4></div>					
				<div id="chartProdutos" style="height: 200px; width: 100%;"></div>
			</div>
			<div class="col-md-8">
				<div class="col-md-12"><h4>Formas de Pagamento</h4></div>
				<div id="chartFormaBar" style="height: 200px; width: 100%;"></div>
			</div>
		</div>
	</div>
</div>

<div class="clearfix">&nbsp;</div>
<div class="row" >
	<div class="col-md-12">
		<div class="row" >
			<div class="col-md-12">
		 		<table class="table table-striped table-hover table-bordered table-condensed rel" id='datagrid'>
				</table>
		  	</div>
		  	
		</div>
	</div>
</div>
<div class="clearfix" style="height: 150px">&nbsp;</div>


<script>
	
	$(function(){
		$('.responsive-h').responsive({padding:[0,0,300,0]});
		$('#pesquisar').keydown(function(e){
			if( e.which == 13 ){
				LoadGridRelVendas()
				return false;
			}
		})

		$('#from').datetimepicker().on('dp.change', function(e) {
	       $('#to').datetimepicker('minDate',e.date)
	    });

	    $('#to').datetimepicker('minDate',$('#from').val())

		$('.btn.filter').click(function(){
			LoadGridRelVendas()
		})

		$('.excel').unbind('click').click(function(){

			var columns = [];
			var data = [];
			switch( rel.filter.group ){
				case 'day':
					columns = ['Data','Total Desc.','Total Vendido'];
					data = ['data_br','total_desconto','total_liquido'];
					break;
				case 'month':
					columns = ['Mes','Total Desc.','Total Vendido'];
					data = ['mes','total_desconto','total_liquido'];
					break;	
				case 'product':
					columns = ['Produto','Total Desc.','Total Vendido'];
					data = ['produto','total_desconto','total_liquido'];
					break;

			}

			ExportExcel( rel.data, 
						"Relatorio-Venda",
						columns,
						data);
		})

	})

	var DataTableRelVenda = null;
	var rel = new $PHP('relatorioController');
		rel.loaded = LoadGridRelVendas;

	var periodo_ant = {	from: null,
						to: null };

	function LoadGridRelVendas(){
		
		$('#datagrid').html( '' );
		//rel.search = $('#pesquisar').val();
		//if( $('#') )
		rel.filter = { 	from : $('#rel-filter #from').val(),
						to : $('#rel-filter #to').val(),
						produto_id : null,
						order : $('#rel-filter #order').val(),
						group : $('#rel-filter #group').val()
		 			 };

		if( periodo_ant.from != rel.filter.from || periodo_ant.to != rel.filter.to  ){

			//console.log( rel.filter );
			//console.log( periodo_ant )

			periodo_ant = { from : rel.filter.from,
							to : rel.filter.to }		 			 	
			LoadChartForma();			
		}		

		rel.sendException = ['obj','data','msg','sendException'];
		rel.call('relVenda',[0,100],function( ret ){
			if( !ret.success ){
				$('#datagrid').html( ret.message );
			} else {
				//console.log( estoque.data )

				var colum_grup = {  
									"day" : { data: "data_br", title: "Data" , width: "20%"},
									"month" : { data: "mes", title: "Mês" , width: "20%"},
									"product" : { data: "produto", title: "Produto" , width: "20%"}
								 };

				DataTableRelVenda = $('#datagrid').DataTable({
					"data" : rel.data.rel,
					scroller: true,
	        		paging:  false,
					searching: false,
					pageLength: 32,
				    lengthChange : false,
				    fixedHeader: {
				        header: false,
				        footer: true
				    },
			        columns: [
			            colum_grup[ rel.filter.group ],
			            {
			                data : "total_desconto",
			                sortable: false,
			                title: "Descontos" , 
			                width: "10%",
			                "render": function ( data, type, full, meta ) {
			                	return "<b>"+MoneyFormat(full.total_desconto)+"</b>" ;
			                }
			            },
			            {
			                data : "total_liquido",
			                sortable: false,
			                title: "Total Venda" , 
			                width: "10%",
			                "render": function ( data, type, full, meta ) {
			                	return "<b>"+MoneyFormat(full.total_liquido)+"</b>" ;
			                }
			            }

			        ],
	        		destroy: true,
	        		fnFooterCallback: function(row, data, start, end, display) {
					    var api = this.api();
					    var footer = $(this).append("<tfoot><tr role='row'><th></th><th></th><th> "+ MoneyFormat(rel.data.total) +" </th></tr></tfoot>");
					      
					}
			    }).on( 'draw', function () {
				    //initJs();
				    
				});

				var dataChar = { label: [], series : [[]] };
				var series_prod = [];

			    //console.log( dataChar )		    
				
			    switch( rel.filter.group ){
			    	case 'month':

			    		for( var i in rel.data.rel ){
					    	dataChar.label.push( rel.data.rel[i].mes );
					    	dataChar.series[0].push( rel.data.rel[i].total_liquido );
					    }
					    chartline( "#chartVendas", dataChar );
					    LoadChartProduto();

			    		break;

			    	case 'product':

			    		for( var i in rel.data.rel ){
					    	dataChar.label.push( rel.data.rel[i].produto );
					    	series_prod.push( rel.data.rel[i].total_liquido )
					    }

					    chartpizza( "#chartProdutos", { label : dataChar.label , series : series_prod } )

			    		break;

			    	default:
			    		
					    for( var i in rel.data.rel ){
					    	dataChar.label.push( rel.data.rel[i].data_dm );
					    	dataChar.series[0].push( rel.data.rel[i].total_liquido );
					    }
					    chartline( "#chartVendas", dataChar );
					    LoadChartProduto();

			    		break;
			    }			    

			}

			
		    
		})
	}



	function LoadChartForma(){

		var dataChar = { label :[], series : [] };

		rel.sendException = ['obj','data','msg','sendException'];
		rel.call('relForma',[0,100],function( ret ){
			if(ret.success){
				for( var i in rel.data ){
			    	dataChar.label.push( rel.data[i].forma );
			    	dataChar.series.push( rel.data[i].total );
			    }

				chartbar( "#chartFormaBar", dataChar )
			}
		})
	}

	function LoadChartProduto(){

		var dataChar = { label :[], series : [] };

		rel.sendException = ['obj','data','msg','sendException'];
		rel.call('relProduto',[0,100],function( ret ){
			if(ret.success){
				for( var i in rel.data ){
			    	dataChar.label.push( rel.data[i].produto );
			    	dataChar.series.push( rel.data[i].total_liquido );
			    }
			    //console.log( dataChar )
				chartpizza( "#chartProdutos", dataChar )
			}
		})
	}

</script>

