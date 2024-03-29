package BBDD;

import Auxiliar.Bitacora;
import Auxiliar.Constantes;
import java.sql.*;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;

public class ConexionEstatica {

    //********************* Atributos *************************
    private static java.sql.Connection Conex;
    //Atributo a través del cual hacemos la conexión física.
    private static java.sql.Statement Sentencia_SQL;
    //Atributo que nos permite ejecutar una sentencia SQL
    private static java.sql.ResultSet Conj_Registros;
    /**
     * Abre la base de datos
     */
    public static void abrirBD() {
        try {
            //Cargar el driver/controlador
            String controlador = "com.mysql.jdbc.Driver";
            //String controlador = "oracle.jdbc.driver.OracleDriver";
            //String controlador = "sun.jdbc.odbc.JdbcOdbcDriver"; 
            //String controlador = "org.mariadb.jdbc.Driver"; // MariaDB la version libre de MySQL (requiere incluir la librería jar correspondiente).
            //Class.forName(controlador).newInstance();
            Class.forName(controlador);

            String URL_BD = "jdbc:mysql://localhost/" + Constantes.BBDD;
            //String URL_BD = "jdbc:mariadb://"+this.servidor+":"+this.puerto+"/"+this.bbdd+"";
            //String URL_BD = "jdbc:oracle:oci:@REPASO";
            //String URL_BD = "jdbc:oracle:oci:@REPASO";
            //String URL_BD = "jdbc:odbc:REPASO";

            //Realizamos la conexión a una BD con un usuario y una clave.
            Conex = java.sql.DriverManager.getConnection(URL_BD, Constantes.usuario, Constantes.password);
            Sentencia_SQL = Conex.createStatement();
            System.out.println("Conexion realizada con éxito");
        } catch (Exception e) {
            System.err.println("Exception: " + e.getMessage());
        }
    }
    /**
     * Cierra la base de datos
     */
    public static void cerrarBD() {
        try {
            // resultado.close();
            Conex.close();
            System.out.println("Desconectado de la Base de Datos"); // Opcional para seguridad
        } catch (SQLException ex) {
            JOptionPane.showMessageDialog(null, ex.getMessage(), "Error de Desconexion", JOptionPane.ERROR_MESSAGE);
        }
    }
    /**
     * Devuelve null en caso de que no haya usuario
     * @param usuario
     * @param contra
     * @return 
     */
    public static Usuario existeUsuario(String usuario, String contra) {
        Usuario existe = null;
        try {
            String sentencia = "SELECT * FROM usuarios WHERE Correo =? AND Clave =?";
            //Preparamos la sentencia para evitar la inyección.
            PreparedStatement sentenciaPreparada = ConexionEstatica.Conex.prepareStatement(sentencia);
            sentenciaPreparada.setString(1, usuario);
            sentenciaPreparada.setString(2, contra);
            ConexionEstatica.Conj_Registros = sentenciaPreparada.executeQuery();
            //http://www.mclibre.org/consultar/php/lecciones/php-db-inyeccion-sql.html

            //Sección no segura que no evita la inyección de SQL.
            //Código para inyectar -->   ' or 'b'='b
            //String sentencia = "SELECT * FROM personas WHERE Nombre ='"+ usuario +"' AND contra = '" + contra + "'";
            //ConexionEstatica.Conj_Registros = ConexionEstatica.Sentencia_SQL.executeQuery(sentencia);
            //Fin de la sección no segura.
            if (ConexionEstatica.Conj_Registros.next())//Si devuelve true es que existe.
            {
                existe = new Usuario(Conj_Registros.getInt("Id"), Conj_Registros.getString("Correo"), Conj_Registros.getString("Clave"), Conj_Registros.getString("Nombre"), Conj_Registros.getString("Apellidos"), Conj_Registros.getInt("Edad"));
            }
        } catch (SQLException ex) {
            System.out.println("Error en el acceso a la BD.");
        }
        return existe;//Si devolvemos null el usuario no existe.
    }
    /**
     * Devuelve si existe un usuario
     * @param usuario
     * @param clave
     * @return 
     */
    public static boolean existeUsuarioExcepcion(String usuario, String clave) {
        Usuario existe = null;
        boolean sol = false;
        try {
            String sentencia = "SELECT * FROM usuarios WHERE Correo = '" + usuario + "' AND Clave = '" + clave + "'";
            ConexionEstatica.Conj_Registros = ConexionEstatica.Sentencia_SQL.executeQuery(sentencia);
            if (ConexionEstatica.Conj_Registros.next())//Si devuelve true es que existe.
            {
                existe = new Usuario(Conj_Registros.getInt("Id"), Conj_Registros.getString("Correo"), Conj_Registros.getString("Clave"), Conj_Registros.getString("Nombre"), Conj_Registros.getString("Apellidos"), Conj_Registros.getInt("Edad"));
                sol = true;
            }
        } catch (SQLException ex) {
            System.out.println("Error en el acceso a la BD.");
        }
        return sol;
    }

    /**
     * Obtienes una lista de todos los usuarios
     * @return 
     */
    public static LinkedList obtenerUsuarios() {
        LinkedList personasBD = new LinkedList<>();
        Usuario p = null;
        try {
            String sentencia = "SELECT * FROM usuarios";
            ConexionEstatica.Conj_Registros = ConexionEstatica.Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                p = new Usuario(Conj_Registros.getInt("Id"), Conj_Registros.getString("Correo"), Conj_Registros.getString("Clave"), Conj_Registros.getString("Nombre"), Conj_Registros.getString("Apellidos"), Conj_Registros.getInt("Edad"));
                personasBD.add(p);
            }
        } catch (SQLException ex) {
        }
        return personasBD;
    }
    /**
     * Obtienes una lista de usuarios en donde no aparece la persona logeada
     * @param correo
     * @param id_usuario
     * @return 
     */
    public static LinkedList obtenerUsuariosExcepcion(String correo,int id_usuario) {
        LinkedList usuarios = new LinkedList();
        Usuario b;
        try {
           // SELECT usuarios.*, asignar_roles.Id_rol FROM usuarios, asignar_roles Where usuarios.Correo ='d@d.d' AND asignar_roles.Id_usuario=2 
            String sentencia = "SELECT usuarios.*, asignar_roles.Id_rol FROM usuarios, asignar_roles Where usuarios.Id=asignar_roles.Id_usuario AND usuarios.Correo !='"+correo+"' AND asignar_roles.Id_usuario!="+id_usuario;
            ConexionEstatica.Conj_Registros = ConexionEstatica.Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                b = new Usuario(Conj_Registros.getInt("Id"), Conj_Registros.getString("Correo"), Conj_Registros.getString("Clave"), Conj_Registros.getString("Nombre"), Conj_Registros.getString("Apellidos"), Conj_Registros.getInt("Edad"), Conj_Registros.getInt("Activo"), Conj_Registros.getInt("Id_rol"));
//                System.out.println("----");
//                b.mostrarInfo();
//                System.out.println("----");
                usuarios.add(b);
            }
        } catch (SQLException ex) {
        }
        return usuarios;
    }
    /**
     * Obtienes las aulas
     * @return 
     */
    public static LinkedList obtenerAulas() {
        LinkedList Aulas = new LinkedList<>();
        Aula a = null;
        try {
            String sentencia = "SELECT * FROM aula";
            ConexionEstatica.Conj_Registros = ConexionEstatica.Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                a = new Aula(Conj_Registros.getInt("Numero"), Conj_Registros.getString("Descripcion"));
                Aulas.add(a);
            }
        } catch (SQLException ex) {
        }
        return Aulas;
    }
    /**
     * Obtienes el numero de franjas
     * @return 
     */
    public static LinkedList obtenerFranjas() {
        LinkedList Franjas = new LinkedList<>();
        Franja a = null;
        try {
            String sentencia = "SELECT * FROM franjas";
            ConexionEstatica.Conj_Registros = ConexionEstatica.Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                a = new Franja(Conj_Registros.getInt("Numero"), Conj_Registros.getString("Comienzo"), Conj_Registros.getString("Final"));
                Franjas.add(a);
            }
        } catch (SQLException ex) {
        }
        return Franjas;
    }
    /**
     * Obtiene una lista de Las reservas
     * @param aula
     * @param fecha
     * @return 
     */
    public static LinkedList obtenerReservas(int aula, String fecha) {
        LinkedList Reserva = new LinkedList<>();
        Reserva a = null;
        try {
            String sentencia = "SELECT asignar_franjas.Ocupada,usuarios.Nombre FROM asignar_franjas, usuarios Where asignar_franjas.Id_aula ='"+aula +"' and asignar_franjas.Fecha='"+ fecha +"'";
            ConexionEstatica.Conj_Registros = ConexionEstatica.Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                a = new Reserva(Conj_Registros.getInt("Ocupada"),Conj_Registros.getString("Profesor"));
                Reserva.add(a);
            }
        } catch (SQLException ex) {
        }
        return Reserva;
    }

    /**
     * Obtienes los Id de un Usuario
     * @param correo
     * @return 
     */
    public static int obtenerIdUsuario(String correo) {
        int sol = 0;
        Usuario p = null;
        try {
            String sentencia = "SELECT * FROM usuarios Where Correo ='" + correo + "'";
            ConexionEstatica.Conj_Registros = ConexionEstatica.Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                p = new Usuario(Conj_Registros.getInt("Id"), Conj_Registros.getString("Correo"), Conj_Registros.getString("Clave"), Conj_Registros.getString("Nombre"), Conj_Registros.getString("Apellidos"), Conj_Registros.getInt("Edad"));
                sol = p.getId();
            }

        } catch (SQLException ex) {
            System.out.println("Error");
        }
        return sol;
    }
    /**
     * Obtienes la Id de los roles
     * @param usuario
     * @return 
     */
    public static int obtenerIdRoles(int usuario) {
        int r = 0;
        try {
            String sentencia = "SELECT Id_rol FROM asignar_roles Where Id_usuario='" + usuario + "'";
            ConexionEstatica.Conj_Registros = ConexionEstatica.Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                r = Conj_Registros.getInt("Id_rol");
            }
        } catch (SQLException ex) {
        }
        return r;
    }
    /**
     * 
     * @param usuario
     * @return 
     */
    public static LinkedList obtenerDescripcionRoles(int usuario) {
        LinkedList roles = new LinkedList<>();
        String r;
        try {
            String sentencia = "SELECT Descripcion FROM rol Where Numero in(Select Id from asignar_roles Where Id_usuario='" + usuario + "')";
            ConexionEstatica.Conj_Registros = ConexionEstatica.Sentencia_SQL.executeQuery(sentencia);
            while (Conj_Registros.next()) {
                r = Conj_Registros.getString("Descripcion");
                roles.add(r);
            }
        } catch (SQLException ex) {
        }
        return roles;
    }

    /**
     * Usando una tabla Hash.
     *
     * @return
     */
//    public static HashMap<String, Usuario> obtenerPersonas2() {
//        HashMap <String, Usuario> personos = new HashMap<String, Usuario>();
//        Usuario p = null;
//        try {
//            String sentencia = "SELECT * FROM personas";
//            ConexionEstatica.Conj_Registros = ConexionEstatica.Sentencia_SQL.executeQuery(sentencia);
//            while(Conj_Registros.next()){
//                p =new Usuario(Conj_Registros.getString("DNI"), Conj_Registros.getString("nombre"), Conj_Registros.getInt("Tfno"));;
//                personos.put(p.getDNI(), p);
//            }
//        } catch (SQLException ex) {
//        }
//        return personos;
//    }
    //----------------------------------------------------------
    public static void Modificar_Dato(String tabla, String DNI, String Nuevo_Nombre) throws SQLException {
        String Sentencia = "UPDATE " + tabla + " SET Nombre = '" + Nuevo_Nombre + "' WHERE DNI = '" + DNI + "'";
        ConexionEstatica.Sentencia_SQL.executeUpdate(Sentencia);
    }

    //----------------------------------------------------------
    public static void insertarDato(String DNI, String clave, String Nombre, String Tfno) {
        try {
            String Sentencia = "INSERT INTO personas VALUES ('" + DNI + "','" + clave + "','" + Nombre + "','" + Tfno + "')";
            ConexionEstatica.Sentencia_SQL.executeUpdate(Sentencia);
        } catch (SQLException ex) {
        }
    }

    //----------------------------------------------------------
    public static void Borrar_Dato(String tabla, String DNI) throws SQLException {
        String Sentencia = "DELETE FROM " + tabla + " WHERE DNI = '" + DNI + "'";
        ConexionEstatica.Sentencia_SQL.executeUpdate(Sentencia);
    }
    /**
     * Insertar un Usuario
     * @param correo
     * @param clave
     * @param nombre
     * @param apellidos
     * @param edad 
     */
    public static void insertar_Usuario(String correo, String clave, String nombre, String apellidos, int edad) {
        try {
            String Sentencia = "INSERT INTO usuarios VALUES ('" + 0 + "','" + correo + "','" + clave + "','" + nombre + "','" + apellidos + "','" + edad + "','0')";
            ConexionEstatica.Sentencia_SQL.executeUpdate(Sentencia);
        } catch (SQLException ex) {
        }
    }
    /**
     * Inserta una franja
     * @param numero
     * @param comienzo
     * @param termina 
     */
    public static void insertarFranja(int numero, String comienzo, String termina) {
        try {
            String Sentencia = "INSERT INTO franjas VALUES ('" + numero + "','" + comienzo + "','" + termina + "')";
            ConexionEstatica.Sentencia_SQL.executeUpdate(Sentencia);
        } catch (SQLException ex) {
        }
    }
    /**
     * Insertar un rol para un Usuario
     * @param id_usuario 
     */
    public static void insertar_Rol(int id_usuario) {
        try {
            String Sentencia = "INSERT INTO asignar_roles VALUES ('" + 0 + "','" + id_usuario + "','1')";
            ConexionEstatica.Sentencia_SQL.executeUpdate(Sentencia);
        } catch (SQLException ex) {
        }
    }
    /**
     * Añade un aula
     * @param Descripcion
     * @param Aula
     * @param f 
     */
    public static void AñadirAula(String Descripcion, int Aula, Usuario f) {
        try {
            String Sentencia = "INSERT INTO aula VALUES ('" + Aula + "','" + Descripcion + "')";
            ConexionEstatica.Sentencia_SQL.executeUpdate(Sentencia);
            Bitacora.escribirBitacora("El usuario " + f.getCorreo() + "ha añadido el aula" + Aula);
        } catch (SQLException ex) {
        }
    }
    /**
     * Elimina un aula
     * @param Numero
     * @throws SQLException 
     */
    public static void EliminarAula(int Numero) throws SQLException {
        String Sentencia = "DELETE FROM aula WHERE Numero = '" + Numero + "'";
        ConexionEstatica.Sentencia_SQL.executeUpdate(Sentencia);
    }
    /**
     * Elimina un Usuario
     * @param Correo
     * @throws SQLException 
     */
    public static void EliminarUsuario(String Correo) throws SQLException {
        String Sentencia = "DELETE FROM usuarios WHERE Correo = '" + Correo + "'";
        ConexionEstatica.Sentencia_SQL.executeUpdate(Sentencia);
    }
    /**
     * Cambia la descripcion del aula
     * @param Descripcion
     * @param Aula
     * @throws SQLException 
     */
    public static void CambiarAula(String Descripcion, int Aula) throws SQLException {
        String Sentencia = "UPDATE aula SET Descripcion = '" + Descripcion + "' WHERE Numero = '" + Aula + "'";
        ConexionEstatica.Sentencia_SQL.executeUpdate(Sentencia);
    }
    /**
     * Cambia el rol de una persona
     * @param rol
     * @param usuario_id
     * @throws SQLException 
     */
    public static void CambiarRol(int rol,int usuario_id) throws SQLException {
        String Sentencia = "UPDATE aignar_roles SET Id_rol = '" + rol + "' WHERE Id_usuario = '" + usuario_id + "'";
        ConexionEstatica.Sentencia_SQL.executeUpdate(Sentencia);
    }
    
    /**
     * Cambiar los datos de un Usuario
     * @param nombre
     * @param apellido
     * @param edad
     * @param activo
     * @param rol
     * @param usuario_id
     * @throws SQLException 
     */
    public static void CambiarUsuario(String nombre, String apellido,int edad,int activo,int rol,int usuario_id) throws SQLException {
        String Sentencia = "UPDATE usuarios,asignar_roles SET asignar_roles.Id_rol = '" + rol + "', usuarios.Nombre='"+nombre+"', usuarios.Apellidos='"+apellido+"' ,usuarios.Edad='"+edad+"', usuarios.Activo='"+activo+"' WHERE usuarios.Id=asignar_roles.Id_usuario and asignar_roles.Id_usuario = '" + usuario_id + "'";
        ConexionEstatica.Sentencia_SQL.executeUpdate(Sentencia);
    }

}
