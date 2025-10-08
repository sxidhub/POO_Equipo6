import javax.swing.*;
import java.awt.event.*;

public class Ventana extends JFrame {
    JButton boton;
    Mensajes controlador;
    Punto primero;
    Punto segundo;
    Punto tercero;
    
    public Ventana(Mensajes controlador,Punto primero,Punto segundo,Punto tercero) {;
        this.controlador = controlador;
        this.primero = primero;
        this.segundo = segundo;
        this.tercero = tercero;
    


        Double distancia1y2 = Math.sqrt(Math.pow(segundo.x-primero.x, 2)+Math.pow(segundo.y-primero.y, 2));
        Double distancia2y3 = Math.sqrt(Math.pow(tercero.x-segundo.x, 2)+Math.pow(tercero.y-segundo.y, 2));
        Double distancia1y3 = Math.sqrt(Math.pow(tercero.x-primero.x, 2)+Math.pow(tercero.y-primero.y, 2));
        //String equilatero = (distancia1y2==distancia1y3 && distancia1y2==distancia2y3)?"Si es equilatero":"No es equilatero";
        String equilatero = 
        (Math.abs(distancia1y2 - distancia1y3) < 0.0001 &&
        Math.abs(distancia1y2 - distancia2y3) < 0.0001 )
        ? "Si es equilatero" 
        : "No es equilatero";

        setTitle("Triangulo Equilatero");
        setSize(300, 200);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLocationRelativeTo(null);

        boton = new JButton("Click para resultados");
        boton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                JOptionPane.showMessageDialog(null, 
                controlador.mensajePuntoA() + primero.toString() + "\n" + 
                controlador.mensajePuntoB() + segundo.toString() + "\n" + 
                controlador.mensajePuntoC() + tercero.toString() + "\n" + 
                controlador.mensajeDistancia1y2() + String.format("%.3f", distancia1y2) + "\n" + 
                controlador.mensajeDistancia2y3() + String.format("%.3f", distancia2y3) + "\n" + 
                controlador.mensajeDistancia1y3() + String.format("%.3f", distancia1y3) + "\n" +
                equilatero
                );
            }
        });

        add(boton);
    }
}
