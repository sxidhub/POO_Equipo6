import 'package:flutter_application_1/pokedex.dart';

class Consumibles {
  final String nombre;
  final String descripcion;
  final String sprite;

  Consumibles(this.nombre, this.descripcion, this.sprite);
}

class ConsumiblesCuracion extends Consumibles {
  final double cantidadCuracion;
  ConsumiblesCuracion(
      String nombre, String descripcion, String sprite, this.cantidadCuracion)
      : super(nombre, descripcion, sprite);
  
  Map<Consumibles, int> usarCuracion(Pokemon pokemon, Map<Consumibles, int> mochila) {
    pokemon.vida += cantidadCuracion;
    //Restar lo usado
    mochila[this] = mochila[this]! - 1;
    //Borrrar si ya no hay
    if (mochila[this] == 0) {
      mochila.remove(this);
    }
    return mochila;
  }
}

//No lo usamos al final (pero puede servir para futuros estados)
class ConsumiblesEstado extends Consumibles {
  final String estadoAEliminar;
  ConsumiblesEstado(
      String nombre, String descripcion,String sprite, this.estadoAEliminar)
      : super(nombre, descripcion, sprite);
}


final pocion = ConsumiblesCuracion("Poción", "Restaura 20 puntos de vida.","https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/potion.png" ,20.0);
final superPosion = ConsumiblesCuracion("Super Poción", "Restaura 60 puntos de vida.","https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/super-potion.png" ,60.0);
final hiperPosion = ConsumiblesCuracion("Hiper Poción", "Restaura 120 puntos de vida.","https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/items/hyper-potion.png" ,120.0);

