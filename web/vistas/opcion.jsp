<%-- 
    Document   : opcion
    Created on : 17-oct-2019, 8:50:04
    Author     : carlox
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="jquery-3.4.1.min.js" ></script>
        <script>
            $(document).ready(function () {
                var n = 0;
                n = <%=(Integer) (session.getAttribute("roles"))%>;
                alert(n);
                if (n == 1) {
                    $("#A1").attr('disabled', false);
                }
                if (n == 2) {
                    $("#A1").attr('disabled', false);
                    $("#A2").attr('disabled', false);
                }
                if (n == 3) {
                    $("#A1").attr('disabled', false);
                    $("#A2").attr('disabled', false);
                    $("#A3").attr('disabled', false);
                }
            });
        </script>
    </head>
    <body>
        <p>¿Como quieres entrar?</p>
        <form name="formulario" action="../controlador.jsp" method="post">
            <select name="roles">
                <option id="A1" name=usuario value=1 disabled>Profesor</option>
                <option id="A2" name=usuario value=2 disabled>Administrador de Aula</option>
                <option id="A3" name=usuario value=3 disabled>Administrador General</option>
            </select>
            <input type="submit" name="iniciar" value="Entrar"/>
            <input type="submit" name="cerrar_sesion" value="Cerrar Sesion"/>
        </form>
    </body>
</html>
