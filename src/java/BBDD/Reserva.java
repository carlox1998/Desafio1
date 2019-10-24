/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package BBDD;

/**
 *
 * @author carlox
 */
public class Reserva {
    private int ocupada;
    private String profesor="";

    public Reserva(int ocupada, String profesor) {
        this.ocupada = ocupada;
        this.profesor = profesor;
    }

    public int getOcupada() {
        return ocupada;
    }

    public void setOcupada(int ocupada) {
        this.ocupada = ocupada;
    }

    public String getProfesor() {
        return profesor;
    }

    public void setProfesor(String profesor) {
        this.profesor = profesor;
    }
    
    
    
    
    
    
}
