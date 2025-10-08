import java.util.Scanner;

public class TrianguloPascal {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        System.out.print("Introduce el número de filas del triángulo de Pascal: ");
        int filas = sc.nextInt();

        int[][] pascal = new int[filas][filas];

        for (int i = 0; i < filas; i++) {
            pascal[i][0] = 1; 
            pascal[i][i] = 1; 
            for (int j = 1; j < i; j++) {
                pascal[i][j] = pascal[i-1][j-1] + pascal[i-1][j];
            }
        }

        for (int i = 0; i < filas; i++) {
            for (int k = 0; k < filas - i; k++) {
                System.out.print(" ");
            }
            for (int j = 0; j <= i; j++) {
                System.out.print(pascal[i][j] + " ");
            }
            System.out.println();
        }
        sc.close();
    }
}