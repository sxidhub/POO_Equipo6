package mx.unam.fi.poo.g1.proyecto2.equipo6;
public class MainApp {
    public static void main(String[] args) {
        EmpleadoAsalariado empleadoAsalariado = new EmpleadoAsalariado("Juan", "Perez", 123456789, 800.00);
        EmpleadoPorComision empleadoPorComision = new EmpleadoPorComision("Ana", "Gomez", 987654321, 5000.00, 0.10);

        System.out.println("Empleado Asalariado:");
        System.out.println(empleadoAsalariado);
        System.out.println("Ingresos: $" + empleadoAsalariado.ingresos());

        System.out.println("\nEmpleado por Comisión:");
        System.out.println(empleadoPorComision);
        System.out.println("Ingresos: $" + empleadoPorComision.ingresos());
    }

}