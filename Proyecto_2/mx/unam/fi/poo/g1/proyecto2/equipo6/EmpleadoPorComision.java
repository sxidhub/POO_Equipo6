package mx.unam.fi.poo.g1.proyecto2.equipo6;
public class EmpleadoPorComision extends Empleado {

    private double ventasNetas;
    private double tarifaComision;

    public EmpleadoPorComision(String nombre, String apellidoPaterno, int numeroSeguroSocial,double ventasNetas, double tarifaComision) {
        super(nombre, apellidoPaterno, numeroSeguroSocial);
        setVentasNetas(ventasNetas);
        setTarifaComision(tarifaComision);
    }

    public void setVentasNetas(double ventasNetas) {
        if (ventasNetas < 0.0) {
            System.out.println("Las ventas netas no pueden ser negativas");
            return;
        }
        this.ventasNetas = ventasNetas;
    }

    public double getVentasNetas() {
        return ventasNetas;
    }

    public void setTarifaComision(double tarifaComision) {
        if (tarifaComision < 0.0 || tarifaComision > 1.0) {
            System.out.println("La tarifa de comisión debe estar entre 0.0 y 1.0.");
            return;
        }
        this.tarifaComision = tarifaComision;
    }

    public double getTarifaComision() {
        return tarifaComision;
    }

    @Override
    public double ingresos() {
        return getVentasNetas() * getTarifaComision();
    }

    @Override
    public String toString() {
        return "Empleado: " + nombre + " " + apellidoPaterno + "\nNumero de Seguro Social: " + numeroSeguroSocial + "\nVentas Netas: " + ventasNetas + "\nTarifa de Comisión: " + tarifaComision;
    }
}