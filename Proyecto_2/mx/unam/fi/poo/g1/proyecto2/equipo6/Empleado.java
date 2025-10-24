package mx.unam.fi.poo.g1.proyecto2.equipo6;
public abstract  class Empleado {
    protected String nombre;
    protected String apellidoPaterno;
    protected int numeroSeguroSocial;

    public Empleado(String nombre, String apellidoPaterno, int numeroSeguroSocial) {
        this.nombre = nombre;
        this.apellidoPaterno = apellidoPaterno;
        this.numeroSeguroSocial = numeroSeguroSocial;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }
    public String getNombre() {
        return nombre;
    }

    public void setApellidoPaterno(String apellidoPaterno) {
        this.apellidoPaterno = apellidoPaterno;
    }
    public String getApellidoPaterno() {
        return apellidoPaterno;
    }

    public void setNumeroSeguroSocial(int numeroSeguroSocial) {
        this.numeroSeguroSocial = numeroSeguroSocial;
    }
    public int getNumeroSeguroSocial() {
        return numeroSeguroSocial;
    }

    public abstract double ingresos();
}