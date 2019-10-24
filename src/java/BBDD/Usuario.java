/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BBDD;

/**
 *
 * @author fernando
 */
public class Usuario {
    private int id;
    private String correo;
    private String clave;
    private String nombre;
    private String apellidos;
    private int edad;
    private int activo;
    private int rol;

    public Usuario() {
    }

    public Usuario(int id, String correo, String clave, String nombre, String apellidos, int edad) {
        this.id = id;
        this.correo = correo;
        this.clave = clave;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.edad = edad;
    }

    public Usuario(int id, String correo, String clave, String nombre, String apellidos, int edad, int activo, int rol) {
        this.id = id;
        this.correo = correo;
        this.clave = clave;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.edad = edad;
        this.activo = activo;
        this.rol = rol;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public int getActivo() {
        return activo;
    }

    public void setActivo(int activo) {
        this.activo = activo;
    }

    public int getRol() {
        return rol;
    }

    public void setRol(int rol) {
        this.rol = rol;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }
    
    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public int getEdad() {
        return edad;
    }

    public void setEdad(int edad) {
        this.edad = edad;
    }   
   
    
}
