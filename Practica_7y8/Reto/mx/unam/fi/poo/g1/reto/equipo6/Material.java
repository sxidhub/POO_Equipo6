package mx.unam.fi.poo.g1.reto.equipo6;

public class Material {
    private String titulo;
    private String autor;
    private int anio;

    public Material(String titulo, String autor, int anio) {
        this.titulo = titulo;
        this.autor = autor;
        this.anio = anio;
    }

    public String getTitulo() {
        return titulo;
    }
    public String getAutor() {
        return autor;
    }
    public int getAnio() {
        return anio;
    }
    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }
    public void setAutor(String autor) {
        this.autor = autor;
    }
    public void setAnio(int anio) {
        this.anio = anio;
    }

    public void mostrarInformacion() {
        System.out.println("--Material--");
        System.out.println("Título: " + titulo);
        System.out.println("Autor: " + autor);
        System.out.println("Año: " + anio);
    }


}
