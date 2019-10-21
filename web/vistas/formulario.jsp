<%-- 
    Document   : formulario
    Created on : 27-sep-2019, 11:54:22
    Author     : carlox
--%>

<%@page import="java.util.LinkedList"%>
<%@page import="BBDD.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="jquery-3.4.1.min.js" ></script>
        <script>
            $(document).ready(function () {
                document.getElementById("registrarse").disabled = true;
                
                $("#c2").blur(function () {
                    var contra = $("#c1").val();
                    var contra2 = $("#c2").val();
                    alert(contra);
                    alert(contra2);
                    if (contra != contra2) {
                        alert("distinta");
                        $("#c2").css("background-color", "#FF0000");
                        $("#registrarse").attr('disabled', true);
                    } else {
                        alert("igual");
                        $("#registrarse").attr('disabled', false);
                        $("#c2").css("background-color", "#FFFFFF");
                    }
                });
            });
        </script>
    </head>
    <body>
        <form name="formuario" action="../controlador.jsp" method="post">
            Email: <input type="email" name="email" required><br/>
            Nombre: <input type="text" name="nombre" required><br/>
            Apellidos <input type="text" name="apellidos" required><br/>
            Edad: <input type="number" name="edad"><br/>
            Clave:<input id="c1" type="password" name="contrasena" required><br/>
            Repite la clave:<input id="c2" type="password" name="contrasena2" required><br/>           
            <input type="submit" id="registrarse" name="registrarse" value="Enviar">            
        </form>
    </body>
</html>
