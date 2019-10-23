<%-- 
    Document   : gest_franjas
    Created on : 17-oct-2019, 10:15:54
    Author     : carlox
--%>

<%@page import="java.util.LinkedList"%>
<%@page import="BBDD.Franja"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script src="jquery-3.4.1.min.js" ></script>
        <script>
            $(document).ready(function () {
                $("#anadir_franja").attr('disabled', true);

                $("#nueva_franjaComienzo").blur(function () {

                    var hora = $(this).val();
                    var hora2 = $("#nueva_franjaFinal").val();
                    alert(hora2);
                    alert(hora);
                    var numeros = hora.split(":");
                    var num1 = numeros[0];
                    num1 = parseInt(num1);
                    alert(num1);
                    var num2 = numeros[1];
                    ;
                    num2 = parseInt(num2);
                    alert(num2);
                    if ((num1 < 23 && num1 >= 0) && (num2 < 60 && num2 >= 0)) {
                        alert("hora correcta");
                        alert("hora correcta");
                        num2 = num2 + 55;
                        alert("antes del if");
                        if (num2 >= 60) {
                            alert("dentro del if");
                            num2 = num2 - 60;
                            num1 = num1 + 1;
                        }
                        alert("Despues del if");
                        if (num1 >= 24) {
                            alert("dentro del if 2");
                            num1 = "00";
                        }
                        alert("Despues del segundo if");
                        $("#nueva_franjaFinal").val(num1 + ":" + num2);
                        $("#anadir_franja").attr('disabled', false);
                        $("#anadir_franja").attr('disabled', false);
                    } else {
                        alert("hora incorrecta");
                        $("#anadir_franja").attr('disabled', true);
                    }
                });

                $("#nueva_franjaFinal").blur(function () {
                    var hora = $(this).val();
                    var hora2 = $("#nueva_franjaComienzo").val();
                    alert(hora);
                    var numeros = hora.split(":");
                    var num1 = numeros[0];
                    num1 = parseInt(num1);
                    alert(num1);
                    var num2 = numeros[1];
                    num2 = parseInt(num2);
                    alert(num2);
                    if ((num1 < 23 && num1 >= 00) && (num2 < 60 && num2 >= 00)) {
                        num2 = num2 - 55;
                        if (num2 < 0) {
                            num2 = num2 + 60;
                            num1 = num1 - 1;
                        }
                        if (num1 ==24) {
                            num1 = 23;
                        }
                        $("#nueva_franjaComienzo").val(num1 + ":" + num2);
                    } else {
                        alert("hora incorrecta");
                        $("#anadir_franja").attr('disabled', true);
                    }
                });

                /**  
                 Otra
                 $("#nueva_franjaFinal").blur(function () {
                 var hora = $(this).val();
                 var expresion_regular_hora;
                 expresion_regular_hora = /^\d{2}\:\d{2}$/;
                 if (expresion_regular_hora.test(hora) == true) {
                 $("#añadir_franja").attr('disabled', false);
                 }
                 else{
                 alert("hora incorrecta");
                 }
                 
                 });
                 **/
            });
        </script>
    </head>
    <body>
        <h1>Listado de franjas</h1>
        <table>
            <thead>
            <th>Numero</th>
            <th>Inicio</th>
            <th>Final</th>
        </thead>
        <tbody>
            <%
                LinkedList<Franja> franja = (LinkedList) (session.getAttribute("franjas"));
                for (Franja faux : franja) {%>
            <tr>
                <td><%=faux.getNumero()%></td>
                <td><%=faux.getComienzo()%></td>
                <td><%=faux.getFinal()%></td>
            </tr>
            <%
                }
            %>
        </tbody>
    </table>
    <form name="formulario" action="../controlador.jsp" method="post">
        <input type="number" name="numero" min="0" max="26">
        <input type="time" id="nueva_franjaComienzo" name="nueva_franjaComienzo" required>
        <input type="time" id="nueva_franjaFinal" name="nueva_franjaFinal" readonly required>
        <input type="submit" id="anadir_franja" name="anadir_franja" value="Añadir">
    </form>
    <form name="formulario2" action="../controlador.jsp" method="post">
        <input type="submit" name="cerrar_sesion" value="Cerrar Sesion">
        <input type="submit" name="cambiar_rol" value="Cambiar Rol">
    </form>
</body>
</html>
