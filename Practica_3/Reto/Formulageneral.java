import java.util.ArrayList;

public class Formulageneral {
    public static void main(String[] args) {
        ArrayList<Integer> lista = new ArrayList<Integer>();
        for(String valores:args){
            lista.add(Integer.parseInt(valores));
        }

        Double resultado1;
        Double resultado2;

        if(Math.pow(lista.get(1),2)-4*lista.get(0)*lista.get(2) < 0){
            System.out.println("Son imaginarios");
        }
        else{
            resultado1 =  (-lista.get(1)+Math.sqrt(Math.pow(lista.get(1),2)-4*lista.get(0)*lista.get(2)))/2*lista.get(0);
            resultado2 =  (-lista.get(1)-Math.sqrt(Math.pow(lista.get(1),2)-4*lista.get(0)*lista.get(2)))/2*lista.get(0);
            System.out.println("Valor de X1 = "+resultado1+"   Valor de X2 = "+resultado2);
        }
    }
}
