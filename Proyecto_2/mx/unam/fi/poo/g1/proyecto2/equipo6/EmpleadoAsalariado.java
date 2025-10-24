package mx.unam.fi.poo.g1.proyecto2.equipo6;
public class EmpleadoAsalariado extends Empleado {
    private double salarioSemanal;

    public EmpleadoAsalariado(String nombre, String apellidoPaterno, int numeroSeguroSocial, double salarioSemanal) {
        super(nombre, apellidoPaterno, numeroSeguroSocial);
        setSalarioSemanal(salarioSemanal);
    }

    public void setSalarioSemanal(double salarioSemanal) {
        if (salarioSemanal < 0.0) {
            System.out.println("El salario semanal no puede ser negativo" );
            return;
        }
        this.salarioSemanal = salarioSemanal;
    }

    public double getSalarioSemanal() {
        return salarioSemanal;
    }

    
    public double ingresos() {
        return getSalarioSemanal()*4;
    }
    
    @Override
    public String toString() {
        return "Empleado: " + nombre + " " + apellidoPaterno + "\nNumero de Seguro Social: " + numeroSeguroSocial + "\nSalario Semanal: " + salarioSemanal;
    }
}