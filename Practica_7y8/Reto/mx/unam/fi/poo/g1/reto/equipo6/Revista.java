package mx.unam.fi.poo.g1.reto.equipo6;

public class Revista extends Material {
    private String numeroEdicion;

    public Revista(String titulo, String autor, int anio, String numeroEdicion) {
        super(titulo, autor, anio);
        this.numeroEdicion = numeroEdicion;
    }

    public String getNumeroEdicion() {
        return numeroEdicion;
    }
    public void setNumeroEdicion(String numeroEdicion) {
        this.numeroEdicion = numeroEdicion;
    }

    @Override
    public void mostrarInformacion() {
        System.out.println("--Revista--");
        System.out.println("Título: " + getTitulo());
        System.out.println("Autor: " + getAutor());
        System.out.println("Año: " + getAnio());
        System.out.println("Número de Edición: " + numeroEdicion);
    }
}

