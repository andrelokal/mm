<?
if(trim($_SESSION['usuario']) == "" ){
    printf(utf8_encode("<script>alert('a sessão expirou, por favor entre com seu login e senha novamente');</script>"));
    printf("<script>location.href ='logoff.php'</script>");
}
?>