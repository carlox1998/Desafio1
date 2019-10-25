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
        if (ConexionEstatica.existeUsuarioExcepcion(nom, codClave)) {

            Usuario f = ConexionEstatica.existeUsuario(request.getParameter("usuario"), codClave);
            session.setAttribute("usuario", f);

            int rol = ConexionEstatica.obtenerIdRoles(f.getId());
            session.setAttribute("roles", rol);

            LinkedList<String> descripcion = ConexionEstatica.obtenerDescripcionRoles(f.getId());
            session.setAttribute("descripcionRol", descripcion);
            if (rol == 1) {
                response.sendRedirect("vistas/profesor.jsp");
            } else {
                response.sendRedirect("vistas/opcion.jsp");
            }
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
//-----------------------------Del Profesor-------------------------------------------
    if (request.getParameter("mostrar_reserva") != null) {

    }
//-----------------------------De la Opcion-------------------------------------------
    if (request.getParameter("iniciar") != null) {
        int opcion = Integer.parseInt(request.getParameter("roles"));
        if (opcion == 1) {
            ConexionEstatica.abrirBD();

            LinkedList<Aula> aulas = ConexionEstatica.obtenerAulas();
            session.setAttribute("aulas", aulas);

            LinkedList<Franja> franjas = ConexionEstatica.obtenerFranjas();
            session.setAttribute("franjas", franjas);

            response.sendRedirect("vistas/profesor.jsp");
            ConexionEstatica.cerrarBD();
        }
        if (opcion == 2) {
            response.sendRedirect("vistas/adm_aula.jsp");
        }
        if (opcion == 3) {
            response.sendRedirect("vistas/adm_general.jsp");
        }
    }
//-----------------------------Del Admin_aula-------------------------------------------

    if (request.getParameter("gestionar_aula") != null) {
        ConexionEstatica.abrirBD();
        LinkedList<Aula> aulas = ConexionEstatica.obtenerAulas();
        session.setAttribute("aulas", aulas);
        ConexionEstatica.cerrarBD();
        response.sendRedirect("vistas/gest_aula.jsp");
    }

    if (request.getParameter("gestionar_franja") != null) {
        ConexionEstatica.abrirBD();
        LinkedList<Franja> franjas = ConexionEstatica.obtenerFranjas();
        session.setAttribute("franjas", franjas);
        ConexionEstatica.cerrarBD();
        response.sendRedirect("vistas/gest_franjas.jsp");
    }

//-----------------------------Del Admin_general-------------------------------------------
    if (request.getParameter("gestionar_usuarios") != null) {
        ConexionEstatica.abrirBD();
        Usuario u = (Usuario) (session.getAttribute("usuario"));
        LinkedList<Usuario> usuarios = ConexionEstatica.obtenerUsuariosExcepcion(u.getCorreo(),u.getId());
        session.setAttribute("usuarios", usuarios);
        ConexionEstatica.cerrarBD();
        response.sendRedirect("vistas/gest_usuarios.jsp");
    }

    if (request.getParameter("bitacora") != null) {

    }
//-----------------------------Del Gest_aula-------------------------------------------
    if (request.getParameter("EliminarAula") != null) {
        session.removeAttribute("expirado");
        ConexionEstatica.abrirBD();
        Usuario f = (Usuario) (session.getAttribute("usuario"));
        ConexionEstatica.EliminarAula(Integer.parseInt(request.getParameter("numero")));
        Bitacora.escribirBitacora("El usuario " + f.getCorreo() + "ha eliminado el aula" + request.getParameter("numero"));
        LinkedList<Aula> aulas = ConexionEstatica.obtenerAulas();
        session.setAttribute("aulas", aulas);
        ConexionEstatica.cerrarBD();
        response.sendRedirect("vistas/gest_aula.jsp");
    }

    if (request.getParameter("GuardarCambios") != null) {
        session.removeAttribute("expirado");
        ConexionEstatica.abrirBD();
        Usuario f = (Usuario) (session.getAttribute("usuario"));
        ConexionEstatica.CambiarAula(request.getParameter("descripcion"), Integer.parseInt(request.getParameter("numero")));
        Bitacora.escribirBitacora("El usuario " + f.getCorreo() + "ha cambiado el aula" + request.getParameter("numero"));
        LinkedList<Aula> aulas = ConexionEstatica.obtenerAulas();
        session.setAttribute("aulas", aulas);
        ConexionEstatica.cerrarBD();
        response.sendRedirect("vistas/gest_aula.jsp");
    }

    if (request.getParameter("AnadirAula") != null) {
        session.removeAttribute("expirado");
        ConexionEstatica.abrirBD();
        Usuario f = (Usuario) (session.getAttribute("usuario"));
        ConexionEstatica.AñadirAula(request.getParameter("descripcion"), Integer.parseInt(request.getParameter("numero")), f);
        LinkedList<Aula> aulas = ConexionEstatica.obtenerAulas();
        session.setAttribute("aulas", aulas);
        ConexionEstatica.cerrarBD();
        response.sendRedirect("vistas/gest_aula.jsp");
    }

    if (request.getParameter("anterior_aula") != null) {
        session.removeAttribute("expirado");
        response.sendRedirect("vistas/adm_aula.jsp");
    }

//-----------------------------Del Gest_franja-------------------------------------------
    if (request.getParameter("anadir_franja") != null) {
        ConexionEstatica.abrirBD();
        ConexionEstatica.insertarFranja(Integer.parseInt(request.getParameter("numero")), request.getParameter("nueva_franjaComienzo"), request.getParameter("nueva_franjaFinal"));
        LinkedList<Franja> franjas = ConexionEstatica.obtenerFranjas();
        session.setAttribute("franjas", franjas);
        ConexionEstatica.cerrarBD();
        response.sendRedirect("vistas/gest_franjas.jsp");
    }

//-----------------------------Del Gest_usuario--------------------------------------------------------------
    if (request.getParameter("EliminarUsuario") != null) {
        ConexionEstatica.abrirBD();
        ConexionEstatica.EliminarUsuario(request.getParameter("correo"));

        ConexionEstatica.cerrarBD();
        response.sendRedirect("vistas/gest_usuario.jsp");
    }  
    if (request.getParameter("ModificarUsuario") != null) {
        ConexionEstatica.abrirBD();        
        LinkedList<Usuario> usuarios = (LinkedList) (session.getAttribute("usuarios"));
        for (int i = 0; i < usuarios.size(); i++) {
                if (usuarios.get(i).getCorreo().equals(request.getParameter("correo"))){
                    session.setAttribute("usuarioMod", usuarios.get(i));
                }                
            }
        
        Usuario f = (Usuario) (session.getAttribute("usuarioMod"));
        int n=Integer.parseInt(request.getParameter("edad"));
        n=Integer.parseInt(request.getParameter("activo"));
        n=Integer.parseInt(request.getParameter("rol"));
        ConexionEstatica.CambiarUsuario(request.getParameter("nombre"),request.getParameter("apellido"),Integer.parseInt(request.getParameter("edad")),Integer.parseInt(request.getParameter("activo")),Integer.parseInt(request.getParameter("rol")), f.getId());
        Usuario u = (Usuario) (session.getAttribute("usuario"));
        usuarios = ConexionEstatica.obtenerUsuariosExcepcion(u.getCorreo(),u.getId());
        session.setAttribute("usuarios", usuarios);
        ConexionEstatica.cerrarBD();
        response.sendRedirect("vistas/gest_usuarios.jsp");
    }

//-----------------------------Del formualrio en todos los usuarios-------------------------------------------
    if (request.getParameter("cerrar_sesion") != null) {
        session.removeAttribute("expirado");
        Usuario f = (Usuario) (session.getAttribute("usuario"));
        Bitacora.escribirBitacora("Usuario " + f.getCorreo() + " se ha desconectado");
        session.invalidate();
        response.sendRedirect("index.html");
    }
    if (request.getParameter("cambiar_rol") != null) {
        session.removeAttribute("expirado");
        response.sendRedirect("vistas/opcion.jsp");
    }

//-----------------------------De cualquier pagina tras logearse-------------------------------------------
    /**
     * if (session.getAttribute("expirado") != null) {//Esto hacer con
     * application session.removeAttribute("expirado"); Usuario f = (Usuario)
     * (session.getAttribute("usuario")); Bitacora.escribirBitacora("Usuario " +
     * f.getCorreo() + " se ha desconectado");
     * response.sendRedirect("index.html"); }
     *
     */
%>
