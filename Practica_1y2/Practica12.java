import java.util.Scanner;

public class Practica12 {
    public static void main(String[] args) {
        int opcion;
        int numero;
        Scanner e = new Scanner(System.in);
        do {
            System.out.println("Elige una opcion:");
            System.out.println("1 - Calcular factorial");
            System.out.println("2 - Calcular serie de Fibonacci");
            System.out.println("3 - Calcular conjetura de Collatz");
            System.out.println("4 - Salir");
            opcion = e.nextInt();
        
            switch (opcion) {
                case 1:
                    System.out.println("Dame el numero para calcular su factorial: ");
                    numero =e.nextInt();
                    numero = factorial(numero); 
                    System.out.println("El factorial es: " + numero);
                    break;
                case 2:
                    System.out.println("¿Que numero de la serie de Fibonacci quieres? : ");
                    numero =e.nextInt();
                    System.out.println("");
                    for (int i = 1; i < numero+1; i++) {
                        System.out.println(fibonacci(i));
                    }
                    System.out.println("El numero de fibonacci es " + fibonacci(numero));
                    break;
                case 3:
                    System.out.println("Dame el numero sobre el que calcular la conjetura de Collatz: ");
                    numero =e.nextInt();
                    System.out.println("La conjetura de collatz de este numero es:");
                    collatz(numero);
                    break;
                case 4:
                    System.out.println("Saliendo...");
                    continue;
                default:
                    break;
            }
            
        } while (opcion != 4);
        e.close();
   }

    public static int factorial(int numero){
        if (numero<2) {
            return 1;
        }
        return numero * factorial(numero-1);
    }

    public static int fibonacci(int numero){
        if (numero<1){
            System.out.println("Numero no valido");
            return 1000000;
        }
        if (numero == 1) {
            return 0;
        }
        if (numero == 2 || numero == 3) {
            return 1;
        }
        return fibonacci(numero -1) + fibonacci(numero -2);
    }

    public static void collatz(int numero){
        if (numero<1){
            System.out.println("Numero no valido");
            return;
        }
        while (numero!= 1) {
            if (numero % 2 == 0) {
                numero /= 2;
                System.out.println(numero);
            }
            else{
                numero= (numero*3)+1;
                System.out.println(numero);
            }
        }
    }
}