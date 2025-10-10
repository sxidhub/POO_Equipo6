package mx.unam.fi.poo.g1.reto.equipo6;
import javax.swing.SwingUtilities;
import javax.swing.JTextField;

public class MainApp {

    public static void main(String[] args) {
        // Sin excepciones; SwingUtilities no requiere try/catch
        SwingUtilities.invokeLater(() -> {
            Operaciones operacones = new Operaciones();
            Vista view = new Vista("Calculadora");

            // Listeners
            view.getNumero0().addActionListener(e ->
                agregarDigito(view, "0")
            );
            view.getNumero1().addActionListener(e ->
                agregarDigito(view, "1")
            );
            view.getNumero2().addActionListener(e ->
                agregarDigito(view, "2")
            );
            view.getNumero3().addActionListener(e ->
                agregarDigito(view, "3")
            );
            view.getNumero4().addActionListener(e ->
                agregarDigito(view, "4")
            );
            view.getNumero5().addActionListener(e ->
                agregarDigito(view, "5")
            );
            view.getNumero6().addActionListener(e ->
                agregarDigito(view, "6")
            );
            view.getNumero7().addActionListener(e ->
                agregarDigito(view, "7")
            );
            view.getNumero8().addActionListener(e ->
                agregarDigito(view, "8")
            );
            view.getNumero9().addActionListener(e ->
                agregarDigito(view, "9")
            );
            view.getSuma().addActionListener(e ->{
                igualFuncion(view, operacones);
                agregarDigito(view, "+");
            });
            view.getResta().addActionListener(e ->{
                igualFuncion(view, operacones);
                agregarDigito(view, "-");
            });
            view.getMultiplicacion().addActionListener(e ->{
                igualFuncion(view, operacones);
                agregarDigito(view, "*");
            });
            view.getDivision().addActionListener(e ->{
                igualFuncion(view, operacones);
                agregarDigito(view, "/");
    
            });
            view.getClear().addActionListener(e -> {
                view.getPantalla().setText("0"); 
            });

        
            view.getIgual().addActionListener(e -> {
                igualFuncion(view, operacones);
            });


            // Mostrar ventana

            view.setVisible(true);
        });
    }




    // --------- Utilidades ---------

    private static void agregarDigito(Vista view, String digito) {
        JTextField pantalla = view.getPantalla();
        String textoActual = pantalla.getText();

        // Si el texto es "0", se reemplaza por el nuevo dígito.
        if (textoActual.equals("0")) {
            pantalla.setText(digito);
        } else {
            // Si no, simplemente se concatena.
            pantalla.setText(textoActual + digito);
        }
    }

    private static void igualFuncion(Vista view,Operaciones operacones) {
                String expresion = view.getPantalla().getText();
                if (expresion == null || expresion.equals("") ||expresion.trim().isEmpty()) {
                    view.getPantalla().setText("0");
                    return;
                }

                // Evaluar expresión simple (número operador número)
                String trimmed = expresion.trim();
                System.out.println("Expresion trimmed: "+trimmed);
                //Busca el operador y su posición
                char op = 0;
                int opPos = -1;
                for (int i = 1; i < trimmed.length(); i++) {
                    char c = trimmed.charAt(i);
                    if (c == '+' || c == '-' || c == '*' || c == '/') {
                        op = c;
                        opPos = i;
                        break;
                    }
                }
                System.out.println("Op: "+op);
                System.out.println("OpPos: "+opPos);
                if (opPos == -1 || opPos == 0) {
                    return;
                }
                if (opPos == trimmed.length() - 1) {
                    view.getPantalla().setText(expresion.substring(0, expresion.length() - 1));
                    return;
                }
                

                // Divide la cadena en dos números (sin contar el operador)
                String numeroIzquierdoStr = trimmed.substring(0, opPos).trim();
                String numeroDerechoStr = trimmed.substring(opPos + 1).trim();
                double numeroIzquierdo = Double.parseDouble(numeroIzquierdoStr);
                double numeroDerecho = Double.parseDouble(numeroDerechoStr);
                System.out.println(numeroIzquierdo + " " + op + " " + numeroDerecho);


                double resultado = 0.0;

                switch (op) {
                    case '+':
                        resultado = operacones.sumar(numeroIzquierdo, numeroDerecho);
                        break;
                    case '-':
                        resultado = operacones.restar(numeroIzquierdo, numeroDerecho);
                        break;
                    case '*':
                        resultado = operacones.multiplicar(numeroIzquierdo, numeroDerecho);
                        break;
                    case '/':
                        if (numeroDerecho == 0) {
                            view.getPantalla().setText("0");
                            return;
                        }
                        resultado = operacones.dividir(numeroIzquierdo, numeroDerecho);
                        break;
                    default:
                        view.getPantalla().setText("0");
                        return;
                }
                if (resultado % 1 == 0) {
                    view.getPantalla().setText(String.valueOf((long)resultado));
                    return;
                }
    
                view.getPantalla().setText(String.valueOf(resultado));
    }

    

    /**
     * Convierte String a double sin lanzar excepciones:
     * - Acepta dígitos y un solo punto decimal.
     * - Si es inválido, regresa -1 como bandera.
     */

     //Lo estaba usando pero me daba problemas con los negativos, asi que usé 
    private static double safeParsePrecio(String s) {
        if (s == null) return -1.0;
        String t = s.trim();
        if (t.length() == 0) return -1.0;

        int dots = 0;
        for (int i = 0; i < t.length(); i++) {
            char c = t.charAt(i);
            boolean isDigit = (c >= '0' && c <= '9');
            if (c == '.') {
                dots++;
                if (dots > 1) return -1.0;
            } else if (!isDigit) {
                return -1.0;
            }
        }

        // Construcción manual del valor para evitar NumberFormatException
        double result = 0.0;
        double frac = 0.0;
        double divisor = 1.0;
        boolean afterDot = false;

        for (int i = 0; i < t.length(); i++) {
            char c = t.charAt(i);
            if (c == '.') {
                afterDot = true;
            } else {
                int d = c - '0';
                if (!afterDot) {
                    result = result * 10 + d;
                } else {
                    divisor *= 10.0;
                    frac = frac + d / divisor;
                }
            }
        }
        return result + frac;
    }
}
