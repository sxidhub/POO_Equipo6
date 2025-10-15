public class Libro extends Material {
    private String editorial;


    public Libro(String titulo, String autor, int anio, String editorial) {
        super(titulo, autor, anio);
        this.editorial = editorial;
    }

    public String getEditorial() {
        return editorial;
    }
    public void setEditorial(String editorial) {
        this.editorial = editorial;
    }

    @Override
    public void mostrarInformacion() {
        System.out.println("--Libro--");
        System.out.println("Título: " + getTitulo());
        System.out.println("Autor: " + getAutor());
        System.out.println("Año: " + getAnio());
        System.out.println("Editorial: " + editorial);
    }
    
}
