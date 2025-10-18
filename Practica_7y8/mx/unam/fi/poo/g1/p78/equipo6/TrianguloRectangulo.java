package mx.unam.fi.poo.g1.p78.equipo6;
import java.awt.Dimension;
import java.awt.Graphics2D;

public class TrianguloRectangulo extends Figura{
    private double base,altura;

    public TrianguloRectangulo(double base, double altura) {
        this.base = base;
        this.altura = altura;
    }

    public double getBase() {
        return base;
    }

    public void setBase(double base) {
        this.base = base;
    }

    public double getAltura() {
        return altura;
    }

    public void setAltura(double altura) {
        this.altura = altura;
    }

    @Override 
    public double area (){
        return (base*altura)/2;
    }

    @Override
    public double perimetro(){
        return base + altura + Math.sqrt(Math.pow(base,2)+Math.pow(altura,2));
    }
    

    @Override
    public void dibujar(Graphics2D g, Dimension size) {
        double margen = 20;
        double maxW = size.width - 2 * margen;
        double maxH = size.height - 2 * margen;

        double escalaW = maxW / Math.max(getBase(), 1.0);
        double escalaH = maxH / Math.max(getAltura(), 1.0);
        double escala = Math.min(escalaW, escalaH);

        int b = (int) Math.round(getBase() * escala);
        int h = (int) Math.round(getAltura() * escala);

        int x0 = (size.width - b) / 2;
        int y0 = (size.height + h) / 2;

        int x1 = x0 + b;
        int y1 = y0;
        int x2 = x0;
        int y2 = y0 - h;

        int[] xs = {x0, x1, x2};
        int[] ys = {y0, y1, y2};
        g.drawPolygon(xs, ys, 3);
    }
}