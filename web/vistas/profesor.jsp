<%-- 
    Document   : profesor
    Created on : 17-oct-2019, 9:40:41
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
                var hoy = new Date();
                var anio = hoy.getFullYear();
                var mes = hoy.getMonth() + 1;
                var dia = hoy.getDate();
                var fecha = anio + "-" + mes + "-" + dia;
                $("#fecha").attr('min', fecha);
                $("#fecha").val(fecha);
            });

            /**       
             Meter datos dentro de un select con JavaScript
             function myOnLoad() {
             cargar_Aula();
             }
             function cargar_Aula() {
             var array = ["101", "102", "103", "104", "105"];
             addOptions("aula", array);
             }
             
             function addOptions(domElement, array) {
             var select = document.getElementsByName(domElement)[0];
             for (value in array) {
             var option = document.createElement("option");
             option.text = array[value];
             select.add(option);
             }
             }
             **/
            function mostrarAula() {

            }

        </script>
    </head>
    <body>
        Elije la fecha: <input id="fecha" type="date" onchange="mostrarAula()"/><br/>
        Elije el Aula:
        <select name="aula" onchange="mostrarAula()">
            <%
                LinkedList<Aula> aula = (LinkedList) (session.getAttribute("aulas"));
                for (Aula paux : aula) {
            %>
            <option><%=paux.getNumero()%></option>
            <%
                }
            %>
        </select>
            <p>Aula:<%=aula.get(0).getNumero() %></p>
        <table>
            <thead>
                <tr>
                    <th>Comienzo</th>
                    <th>Final</th>
                    <th>Reservado</th>
                </tr>                
            </thead>
            <tbody>
                <%
                    LinkedList<Franja> franja = (LinkedList) (session.getAttribute("franjas"));
                    for (Franja faux : franja) {%>
                    <tr>
                        <td><%=faux.getComienzo()%></td>
                        <td><%=faux.getFinal()%></td>
                        <td></td>
                    </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <form name="formulario2" action="../controlador.jsp" method="post">
            <input type="submit" name="cerrar_sesion" value="Cerrar Sesion">
            <input type="submit" name="cambiar_rol" value="Cambiar Rol">
        </form>
    </body>
</html>
