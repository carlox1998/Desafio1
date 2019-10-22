<%-- 
    Document   : gest_aula
    Created on : 17-oct-2019, 10:15:35
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
            var t = false;
            function contar() {
                if (t)
                    clearTimeout(t);
                s = arguments[0] || 0;
                if (s > 10)
                    location.reload();
                s++;
                t = setTimeout("contar(" + s + ")", 1000);
            }
            window.onload = document.onmousemove = contar;


        </script>
    </head>
    <body>
        <h1>Listas de Aulas</h1>
        <form name="formulario" id="formulario" action="../controlador.jsp" method="post">
            <%
                if (session.getAttribute("expirado") != null) {
                    response.sendRedirect("../controlador.jsp");
                } else {
                    session.setAttribute("expirado", false);
                    LinkedList<Aula> aula = (LinkedList) (session.getAttribute("aulas"));
                    for (Aula paux : aula) {
            %>
            <form name="formulario" action="../controlador.jsp" method="post">
                <input type="number" name="numero" value="<%=paux.getNumero()%>" readonly>
                <input type="text" name="descripcion" value="<%= paux.getDescripcion()%>">
                <input type="submit" name="EliminarAula" value="eliminar">
                <input type="submit"  name="GuardarCambios" value="guardar">
            </form>
            <%
                    }
                }
            %>
            <form name="formulario" action="../controlador.jsp" method="post">
                <input type="number" name="numero" value="" required>
                <input type="text" name="descripcion" value="" required>
                <input type="submit"  name="AnadirAula" value="Añadir">
                <input type="submit"  name="anterior_aula" value="Anterior">
            </form>
            <form name="formulario2" action="../controlador.jsp" method="post">
                <input type="submit" name="cerrar_sesion" value="Cerrar Sesion">
                <input type="submit" name="cambiar_rol" value="Cambiar Rol">
            </form>
    </body>
</html>
