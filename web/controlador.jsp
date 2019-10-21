<%-- 
    Document   : controlador
    Created on : 15-oct-2019, 10:02:02
    Author     : carlox
--%>

<%@page import="java.util.LinkedList"%>
<%@page import="Auxiliar.*"%>
<%@page import="BBDD.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
//-----------------------------Del Index-------------------------------------------
    if (request.getParameter("validar") != null) {
        String nom = request.getParameter("usuario");
        String clave = request.getParameter("contra");
        String codClave = Codificar.codifica(clave);
        ConexionEstatica.abrirBD();
        if (ConexionEstatica.existeUsuario2(nom, codClave)) {
            
            Usuario f = ConexionEstatica.existeUsuario(request.getParameter("usuario"), codClave);
            session.setAttribute("usuario", f.getCorreo());
            
            int rol = ConexionEstatica.obtenerIdRoles(f.getId());
            session.setAttribute("roles", rol);
            
            LinkedList<String> descripcion = ConexionEstatica.obtenerDescripcionRoles(f.getId());
            session.setAttribute("descripcionRol", descripcion);
            response.sendRedirect("vistas/opcion.jsp");
            Bitacora.escribirBitacora("Usuario " + f.getCorreo() + " ha entrado");
        } else {
            response.sendRedirect("vistas/incorrecta.jsp");
        }
        ConexionEstatica.cerrarBD();
    }

//-----------------------------Del formulario-------------------------------------------
    if (request.getParameter("registrarse") != null) {
        ConexionEstatica.abrirBD();
        String correo = request.getParameter("email");
        String clave = request.getParameter("contrasena");
        String codClave = Codificar.codifica(clave);
        int edad = Integer.parseInt(request.getParameter("edad"));
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        ConexionEstatica.insertar_Usuario(correo, codClave, nombre, apellidos, edad);
        int id_usuario = ConexionEstatica.obtenerIdUsuario(correo);
        ConexionEstatica.insertar_Rol(id_usuario);
        String usuario = (String) (session.getAttribute("usuario"));
        LinkedList<Usuario> usuarios = ConexionEstatica.obtenerUsuarios();
        session.setAttribute("usuarios", usuarios);
        response.sendRedirect("index.html");
        ConexionEstatica.cerrarBD();
    }

//-----------------------------De la Opcion-------------------------------------------
    if (request.getParameter("iniciar") != null) {
        int opcion= Integer.parseInt(request.getParameter("roles"));
        if(opcion==1){
            response.sendRedirect("vista/profesor.jsp");
        }
        if(opcion==2){
            response.sendRedirect("vista/adm_aula.jsp");
        }
        if(opcion==3){
            response.sendRedirect("vista/adm_general.jsp");
        }
    }

    if (request.getParameter("cerrar_sesion") != null) {
        ConexionEstatica.abrirBD();
        Usuario f= (Usuario)(session.getAttribute("usuario"));
        Bitacora.escribirBitacora("Usuario " + f.getCorreo() + " se ha desconectado");        
        ConexionEstatica.cerrarBD();
    }
//-----------------------------De la Opcion-------------------------------------------

%>
