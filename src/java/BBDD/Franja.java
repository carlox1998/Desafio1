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
public class Franja {
    private int numero;
    private String Comienzo;
    private String Final;

    public Franja(int numero, String Comienzo, String Final) {
        this.numero = numero;
        this.Comienzo = Comienzo;
        this.Final = Final;
    }
    
    

    public int getNumero() {
        return numero;
    }

    public void setNumero(int numero) {
        this.numero = numero;
    }
    
    

    public String getComienzo() {
        return Comienzo;
    }

    public void setComienzo(String Comienzo) {
        this.Comienzo = Comienzo;
    }

    public String getFinal() {
        return Final;
    }

    public void setFinal(String Final) {
        this.Final = Final;
    }
    
    
    
}
