import java.util.ArrayList;

public class Reto {
    public static void main(String[] args) {
        ArrayList<Double> l = new ArrayList<Double>();
        for(String valores:args){
            l.add(Double.parseDouble(valores));
        }
        if (l.size() != 6){
            System.out.println("Valores no chidos");
            return;
        }
        Punto punto1 = new Punto(l.get(0),l.get(1));
        Punto punto2 = new Punto(l.get(2),l.get(3));
        Punto punto3 = new Punto(l.get(4),l.get(5));
        Mensajes controlador = new Mensajes();

        Ventana ventana = new Ventana(controlador,punto1,punto2,punto3);
        ventana.setVisible(true);
    }
}
