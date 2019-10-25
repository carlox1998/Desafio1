<%-- 
    Document   : gest_usuarios
    Created on : 23-oct-2019, 13:53:08
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
        <script>
            function volver() {
                location.href = "adm_general.jsp";
            }
        </script>
    </head>
    <body>
        <%
            LinkedList<Usuario> usuarios = (LinkedList) (session.getAttribute("usuarios"));
            for (Usuario paux : usuarios) {
        %>
        <form name="formulario" action="../controlador.jsp" method="post">
            <input type="text" name="correo" value="<%= paux.getCorreo()%>" readonly>
            <input type="text" name="nombre" value="<%= paux.getNombre()%>">
            <input type="text" name="apellido" value="<%= paux.getApellidos()%>">
            <input type="number" name="edad" value="<%=paux.getEdad()%>">
            <input type="number" name="activo" value="<%=paux.getActivo()%>" max="1" min="0">
            <input type="number" name="rol" value="<%=paux.getRol()%>" min="1" max="3"> 
            <input type="submit" name="EliminarUsuario" value="eliminar">
            <input type="submit"  name="ModificarUsuario" value="guardar">
        </form>
        <%
            }
        %>
        <input type="submit"  name="anterior_aula" value="Anterior" onclick="volver()">
        <form name="formulario2" action="../controlador.jsp" method="post">
            <input type="submit" name="cerrar_sesion" value="Cerrar Sesion">
            <input type="submit" name="cambiar_rol" value="Cambiar Rol">
        </form>
    </body>
</html>
