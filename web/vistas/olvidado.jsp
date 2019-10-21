<%-- 
    Document   : olvidado
    Created on : 27-sep-2019, 13:10:31
    Author     : carlox
--%>

<%@page import="java.util.LinkedList"%>
<%@page import="BBDD.*"%>
<%@page import="email.Email"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@page import="email.Email"%>
        <form name="form" action="../controlador.jsp" method="post">
            <input type="email" name="email">
            <input type="submit" name="enviarcorreo" value="enviar">
        </form>
    </body>
</html>
