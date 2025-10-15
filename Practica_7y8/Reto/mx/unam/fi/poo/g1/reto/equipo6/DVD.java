public class DVD extends Material {
    private int duracion; 

    public DVD(String titulo, String autor, int anio, int duracion) {
        super(titulo, autor, anio);
        this.duracion = duracion;
    }

    public int getDuracion() {
        return duracion;
    }
    public void setDuracion(int duracion) {
        this.duracion = duracion;
    }

    @Override
    public void mostrarInformacion() {
        System.out.println("--DVD--");
        System.out.println("Título: " + getTitulo());
        System.out.println("Autor: " + getAutor());
        System.out.println("Año: " + getAnio());
        System.out.println("Duración: " + duracion + " segundos");
    }
    
}
