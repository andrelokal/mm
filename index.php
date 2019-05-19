<!DOCTYPE html>
<html lang="en" style="display: none">
  
  <?php 
  
  include('util/config.php') ;  

  $config = new Config();
  $ret = $config->select(' LIMIt 1 ');
  $nome_empresa = $ret[0]->nome_empresa;
  $title = $nome_empresa." / Maganize Manager";
  

  include('includes/head.php') ;
  ?>

  <body>

    <!-- Fixed navbar -->
    <nav class="navbar navbar-default navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#"><?=$nome_empresa?></a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav" id='menu-system'>
                      
          </ul>
          <ul class="nav navbar-nav navbar-right">
            <li class="active"><a href="logoff" id='logoff' >Sair <span class="sr-only">(current)</span></a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>

    <!-- Begin page content -->
    <div class="container container-fluid" id='page-content' href='internals/sell.php' >
          
    </div>

    <footer class="footer">
      <div class="container">
          <div class="navbar-header">
            <img src='images/logo_hor_peq.png' class="logo_footer" />
          </div>
          
          <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav navbar-right help">
              <li >
                  <kbd> <span class="glyphicon glyphicon-arrow-down" aria-hidden="true"></span> </kbd> Lista Itens
              </li>
              <li >
                  <kbd> <span class="glyphicon glyphicon-arrow-up" aria-hidden="true"></span> </kbd> Busca Produto
              </li>
              <li >
                  <kbd>F1 ou Espaço</kbd> Pagamento
              </li>
              <li >
                  <kbd>F2</kbd> Conta Cliente
              </li>
              <li >
                  <kbd>F4</kbd> Pesquisar produto
              </li>
            </ul>
          </div><!--/.nav-collapse -->
      </div>
    </footer>


    <?php include('includes/scripts.php'); ?>
    <?php
    if( @!$_SESSION['USER'] ){
     ?>
     <script>logoff()</script>
     <?php
     exit;
    }
    ?>

    <div class="modal fade " tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" id='modal' data-keyboard="true">
      <div class="modal-dialog " role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title"></h4>
          </div>
          <div class="modal-body">
            
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default modal-close" data-dismiss="modal">Fechar</button>
            <button type="button" class="btn btn-primary modal-save">OK</button>
          </div>
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <div class="modal fade " tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" id='modal-confirm' >
      <div class="modal-dialog " role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title"></h4>
          </div>
          <div class="modal-body">
            
          </div>
          <!-- <div class="modal-footer">
            <button type="button" class="btn btn-danger modal-close" data-dismiss="modal">Cancelar</button>
            <button type="button" class="btn btn-success modal-save">OK</button>
          </div> -->
        </div><!-- /.modal-content -->
      </div><!-- /.modal-dialog -->
    </div><!-- /.modal -->

    <div class="modal fade " tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" id='modal-snh-adm' >
      <div class="modal-dialog modal-sm" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title"></h4>
          </div>
          <div class="modal-body">
            
            <form  >
              <div class="form-group">
                <label for="exampleInputPassword1">Senha Administrador</label>
                <div class="input-group">
                  <div class="input-group-addon"> <span class="glyphicon glyphicon-lock"></span> </div>
                  <input type="password" class="form-control" placeholder="Password" id='password'>
                </div>
              </div>
            </form>

            <div class="clearfix">&nbsp;</div>

          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-danger modal-close" data-dismiss="modal">Cancelar</button>
            <button type="button" class="btn btn-success modal-save">OK</button>
          </div>
        </div>
      </div>
    </div>

    <div class="modal fade lg" tabindex="-1" role="dialog" id='modal-help' >
      <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title"><span class="glyphicon glyphicon-question-sign" aria-hidden="true"></span>Ajuda</h4>
          </div>
          <div class="modal-body">
            <div class="well"></div>
          </div>
        </div>
      </div>
    </div>

    <div class='notifications top-right'></div>

  </body>
</html>
