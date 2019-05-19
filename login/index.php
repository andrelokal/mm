<!DOCTYPE html>
<html lang="en">

  <?php 
  $title = "Login / Maganize Manager";
  include('../includes/head.php') ;
  ?>

  <body>
    <div class="container login container-fluid" >
      <div class="clearfix">&nbsp;</div>
          
      <div class="panel panel-default">
        <div class="panel-heading">Autenticação do Sistema</div>
        <div class="panel-body">
            <form id='formlogin'>
              <div class="form-group">
                <label for="Login">Login</label>
                <input class="form-control" id="login" name='login' placeholder="Login" required="required">
              </div>
              <div class="form-group">
                <label for="password">Senha</label>
                <input type="password" class="form-control" name='password' id="password" placeholder="Senha" required="required">
              </div>
              <p>
                <button type="submit" class="btn btn-default">Entrar</button>
              </p>
              <p>
                Caso tenha esquecido sua senha <a href='/login/forget.php' class="ahref">clique aqui</a>
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
          CallForm( null , formElement, function(){
            //            
          }, function(){

            var login = new $PHP('loginController');
                login.sendException = ['obj','data','msg','sendException'];
            login.loaded = function(){
              login.call('login',[$('#login').val(),$('#password').val()],function( ret ){
                if(ret.success){
                  
                  localStorage.setItem('auth', JSON.stringify(login.data))
                  AlertMessage( formElement, 'success', 'Sucesso!', ret.message, 2000 );
                  setTimeout(function(){
                    location.href = '/';
                  },2000)

                } else {

                  AlertMessage( formElement, 'danger', 'Atenção!', ret.message, 3000 )

                }
              })
            };

          })
        })

    </script>
  </body>
</html>
