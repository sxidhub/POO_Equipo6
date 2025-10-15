public class Tienda {
    public static void main(String[] args) {
        Material libro = new Libro("Wigetta y el báculo dorado", "Willyrex", 2015," Ediciones Martínez Roca");
        Material revista = new Revista("Muy Interesante", "Varios Autores", 2021, "Edición Especial");
        Material dvd = new DVD("Los Backyardigans", "Janice Burgess", 2004, 600);

        libro.mostrarInformacion();
        System.out.println();
        revista.mostrarInformacion();
        System.out.println();
        dvd.mostrarInformacion();
    }
}
