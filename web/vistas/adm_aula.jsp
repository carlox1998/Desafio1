<%-- 
    Document   : adm_aula
    Created on : 17-oct-2019, 10:10:58
    Author     : carlox
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>y tu k keres?</h1>
        <form name="formulario" action="../controlador.jsp" method="post">
            <input type="submit" name="gestionar_aula" value="Administrar Aula"/>            
        </form>        
        <button>Ver Bitacora</button>
    </body>
</html>
