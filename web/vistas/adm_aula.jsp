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
        <h1>Que quieres hacer?</h1>
        <form name="formulario" action="../controlador.jsp" method="post">
            <input type="submit" name="gestionar_aula" value="Administrar Aula"/>
            <input type="submit" name="gestionar_franja" value="Administrar Franjas"/>            
        </form>
        <form name="formulario2" action="../controlador.jsp" method="post">
            <input type="submit" name="cerrar_sesion" value="Cerrar Sesion">
            <input type="submit" name="cambiar_rol" value="Cambiar Rol">
        </form>
    </body>
</html>
