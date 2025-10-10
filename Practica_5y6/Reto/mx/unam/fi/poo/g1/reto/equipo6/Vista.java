package mx.unam.fi.poo.g1.reto.equipo6;
import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.GridLayout;
import javax.swing.*;

public class Vista extends JFrame{
    // Componentes encapsulados
    private final JButton numero0;
    private final JButton numero1;
    private final JButton numero2;
    private final JButton numero3;
    private final JButton numero4;
    private final JButton numero5;
    private final JButton numero6;
    private final JButton numero7;
    private final JButton numero8;
    private final JButton numero9;
    private final JButton suma;
    private final JButton resta;
    private final JButton multiplicacion;
    private final JButton division;
    private final JButton igual;
    private final JButton clear;
    private final JTextField pantalla;


    public Vista(String titulo) {
        super(titulo);// Esto es de herencia

        numero0 = new JButton("0");
        numero1 = new JButton("1");
        numero2 = new JButton("2");
        numero3 = new JButton("3");
        numero4 = new JButton("4");
        numero5 = new JButton("5");
        numero6 = new JButton("6");
        numero7 = new JButton("7");
        numero8 = new JButton("8");
        numero9 = new JButton("9");
        suma = new JButton("+");
        resta = new JButton("-");
        multiplicacion = new JButton("*");
        division = new JButton("/");
        igual = new JButton("=");
        clear = new JButton("Clear");
        pantalla = new JTextField("0");


        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setPreferredSize(new Dimension(640, 250));
        setLayout(new BorderLayout(10, 10));

        JPanel entrada = new JPanel(new BorderLayout());
        entrada.setBorder(BorderFactory.createTitledBorder("Pantalla"));
        pantalla.setEditable(false);
        entrada.add(pantalla, BorderLayout.CENTER);

        JPanel acciones = new JPanel(new GridLayout(4, 4, 8, 8));
        acciones.add(numero7);
        acciones.add(numero8);
        acciones.add(numero9);
        acciones.add(suma);
        acciones.add(numero4);
        acciones.add(numero5);
        acciones.add(numero6);
        acciones.add(resta);
        acciones.add(numero1);
        acciones.add(numero2);
        acciones.add(numero3);
        acciones.add(multiplicacion);
        acciones.add(clear);
        acciones.add(numero0);
        acciones.add(igual);
        acciones.add(division);


        JPanel top = new JPanel(new BorderLayout(8, 8));
        top.add(entrada, BorderLayout.CENTER);
        top.add(acciones, BorderLayout.SOUTH);



        add(entrada, BorderLayout.CENTER);
        add(acciones, BorderLayout.SOUTH);
        add(top, BorderLayout.NORTH);

        pack();
        setLocationRelativeTo(null);
    }

    // Getters para que la lógica de la app manipule la UI sin exponer campos
    public JButton getNumero0() { return numero0; }
    public JButton getNumero1() { return numero1; }
    public JButton getNumero2() { return numero2; }
    public JButton getNumero3() { return numero3; }
    public JButton getNumero4() { return numero4; }
    public JButton getNumero5() { return numero5; }
    public JButton getNumero6() { return numero6; }
    public JButton getNumero7() { return numero7; }
    public JButton getNumero8() { return numero8; }
    public JButton getNumero9() { return numero9; }
    public JButton getSuma() { return suma; }
    public JButton getResta() { return resta; }
    public JButton getMultiplicacion() { return multiplicacion; }
    public JButton getDivision() { return division; }
    public JButton getIgual() { return igual; }
    public JButton getClear() { return clear; }
    public JTextField getPantalla() { return pantalla; }
    
}
