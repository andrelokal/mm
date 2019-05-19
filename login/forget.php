<!DOCTYPE html>
<html lang="en">

  <?php 
  $title = "Esqueci minha senha / Maganize Manager";
  include('../util/config.php') ;
  include('../includes/head.php') ;
  ?>

  <body>
    <div class="container login container-fluid" >
      <div class="clearfix">&nbsp;</div>
          
      <div class="panel panel-default">
        <div class="panel-heading">Esqueci minha senha</div>
        <div class="panel-body">
            <form id='formlogin'>
              <div class="form-group">
                <h3>ID : <span class="label label-default"><?=CONF['client_id']?></span></h3>
              </div>
              <div class="form-group token">
                <label for="token">Token</label>
                <input type="text" class="form-control input-lg" name='token' id="token" placeholder="Token" required="required">
              </div>
              <div class="form-group new-pass" style="display: none">
                <label for="password">Nova senha</label>
                <input type="password" class="form-control" name='password' id="password" placeholder="Nova senha">
              </div>
              <div class="form-group new-pass" style="display: none">
                <label for="password-confirm">Confirmar nova senha</label>
                <input type="password" class="form-control" name='password-confirm' id="password-confirm" placeholder="Confirmar nova senha" >
              </div>
              <p>
                <input type="hidden" id="step" value="1">
                <button type="submit" class="btn btn-default" id='submit'>Verificar Token</button>
              </p>
              <p>
                Fazer o login <a href='/login/' class="ahref">clique aqui</a>
              </p>
            </form>
        </div>
      </div>

    </div>

    <?php include('../includes/scripts.php'); ?>

    <script type="text/javascript">
        $(function(){
          var formElement = $('#formlogin');
          formElement.attr('action','');

          var login = new $PHP('loginController');              

          login.loaded = function(){

            CallForm( null , formElement, function(){
            //            
            }, function(){

              login.sendException = ['obj','data','msg','sendException'];

              switch( $('#step').val() ){
                case '1': // Validar Token

                  $('.new-pass').hide();
                  login.call('tokenValidation',[$('#token').val()],function( ret ){
                    if(ret.success){
                      
                      $('.new-pass').fadeIn(1000);
                      $('.token').fadeOut(500);
                      $('#step').val(2);
                      $('#submit').html('Alterar Senha')


                    } else {

                      $('.new-pass').hide();
                      AlertMessage( formElement, 'danger', 'Atenção!', ret.message, 3000 )

                    }
                  })

                  break;
                case '2':

                  login.call('alterPassword',[$('#password').val(),$('#password-confirm').val(), $('#token').val()],function( ret ){
                    if(ret.success){

                      AlertMessage( formElement, 'success', 'Sucesso!', ret.message, 2000 );                     
                      $('.new-pass').fadeOut(500);
                      $('#submit').hide()

                    } else {

                      if( login.data == 'token' ){
                        $('.new-pass').fadeOut(500);
                        $('.token').fadeIn(1000);
                        $('#submit').html('Verificar Token')
                      } 

                      AlertMessage( formElement, 'danger', 'Atenção!', ret.message, 3000 )
                      

                    }
                  })

                  break;
              }

              
            }) 

          }
          
        })

    </script>
  </body>
</html>
