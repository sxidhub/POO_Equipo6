import 'dart:math';
import 'ataques.dart';

/// =========================
///        MODELO
/// =========================

enum Elementos { Normal, Fuego, Agua, Electrico, Hierba, Hielo, Lucha, Veneno, Tierra, Volador, Psiquico, Bicho, Roca, Fantasma, Dragon, Siniestro, Acero}
enum Estados { Paralizado, Dormido, Quemado, Congelado, Envenenado }

class Pokemon {
  final String nombre;
  final int nivel;
  final Set<Elementos> tipo; // Tipo de elemento
  final List<Ataque> ataques; // Lista de ataques
  final Map<Estados, int> estados = {}; // Estados y su duración
  

  final String spriteFront; // Imagen de frente (para el oponente)
  final String spriteBack;  // Imagen de espalda (para mi pokemon)
  
  late double _maxVida;
  late double _vida;
  double velocidad;
  static final Random _random = Random();

  Pokemon({
    required this.nombre,
    required this.nivel,
    required this.tipo,
    required this.ataques,
    required this.spriteFront, 
    required this.spriteBack,
  })  : 
        velocidad = (_random.nextDouble() * 3 + 1) * nivel
      {
        double generarVida = (_random.nextDouble() * 5 + 5) * nivel;
        _vida = generarVida;
        _maxVida = generarVida;
      }

  //getter
  double get maxVida => _maxVida;
  double get vida => _vida;
  //setter
  set vida(double nuevaVida) {
    if (nuevaVida < 0) {
      _vida = 0;
      return;
    }
    if (nuevaVida > _maxVida) {
      _vida = _maxVida;
      return;
    }
    _vida = nuevaVida;
  }

  void curarTotalmente() {
      _vida = _maxVida; 
      estados.clear();
      
      // --- NUEVO: Recalcular velocidad aleatoria ---
      velocidad = (_random.nextDouble() * 3 + 1) * nivel;
  }
}

// Nuestros Pokemones (de cada tipo)
final List<Pokemon> pokedex = [
  Pokemon(
    nombre: "Snorlax", 
    nivel: 20, 
    tipo: {Elementos.Normal}, 
    ataques: [tacleada, golpeCuerpo],
    spriteFront: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/143.png",
    spriteBack: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/143.png"
  ),
  Pokemon(
    nombre: "Charmander", 
    nivel: 20, 
    tipo: {Elementos.Fuego}, 
    ataques: [lanzallamas,ascuas],
    spriteFront: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png",
    spriteBack: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/4.png"
  ),
  Pokemon(
    nombre: "Squirtle", 
    nivel: 20, 
    tipo: {Elementos.Agua}, 
    ataques: [hidroBomba,pistolaAgua],
    spriteFront: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png",
    spriteBack: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/7.png"
  ),
  Pokemon(
    nombre: "Pikachu", 
    nivel: 20, 
    tipo: {Elementos.Electrico}, 
    ataques: [rayo,impactrueno],
    spriteFront: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png",
    spriteBack: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/25.png"
  ),
  Pokemon(
    nombre: "Chikorita", 
    nivel: 20, 
    tipo: {Elementos.Hierba}, 
    ataques: [hojaAfilada,latigoCepa],
    spriteFront: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/152.png",
    spriteBack: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/152.png"
  ),
  Pokemon(
    nombre: "Glaceon", 
    nivel: 20, 
    tipo: {Elementos.Hielo}, 
    ataques: [rayoHielo,cantoHelado],
    spriteFront: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/471.png",
    spriteBack: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/471.png"
  ),
  Pokemon(
    nombre: "Machamp", 
    nivel: 20, 
    tipo: {Elementos.Lucha}, 
    ataques: [golpeKarate,aBocajarro],
    spriteFront: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/68.png",
    spriteBack: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/68.png"
  ),
  Pokemon(
    nombre: "Arbok", 
    nivel: 20, 
    tipo: {Elementos.Veneno}, 
    ataques: [bombaAcida,picotazoVen],
    spriteFront: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/24.png",
    spriteBack: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/24.png"
  ),
  Pokemon(
    nombre: "Cubone", 
    nivel: 20, 
    tipo: {Elementos.Tierra}, 
    ataques: [terremoto,disparoLodo],
    spriteFront: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/104.png",
    spriteBack: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/104.png"
  ),
  Pokemon(
    nombre: "Tornadus", 
    nivel: 20, 
    tipo: {Elementos.Volador}, 
    ataques: [vendaval,picotazo],
    spriteFront: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/641.png",
    spriteBack: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/641.png"
  ),
  Pokemon(
    nombre: "Mewtwo", 
    nivel: 20, 
    tipo: {Elementos.Psiquico}, 
    ataques: [psiquico,confusion],
    spriteFront: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/150.png",
    spriteBack: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/150.png"
  ),
  Pokemon(
    nombre: "Pinsir", 
    nivel: 20, 
    tipo: {Elementos.Bicho}, 
    ataques: [tijeraX,corteFuria],
    spriteFront: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/127.png",
    spriteBack: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/127.png"
  ),
  Pokemon(
    nombre: "Sudowoodo", 
    nivel: 20, 
    tipo: {Elementos.Roca}, 
    ataques: [avalancha,lanzarrocas],
    spriteFront: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/185.png",
    spriteBack: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/185.png"
  ),
  Pokemon(
    nombre: "Misdreavus", 
    nivel: 20, 
    tipo: {Elementos.Fantasma}, 
    ataques: [bolaSombra,lenguetazo],
    spriteFront: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/200.png",
    spriteBack: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/200.png"
  ),
  Pokemon(
    nombre: "Dratini", 
    nivel: 20, 
    tipo: {Elementos.Dragon}, 
    ataques: [garraDragon,dragoaliento],
    spriteFront: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/147.png",
    spriteBack: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/147.png"
  ),
  Pokemon(
    nombre: "Umbreon", 
    nivel: 20, 
    tipo: {Elementos.Siniestro}, 
    ataques: [pulsoUmbrio,mordisco],
    spriteFront: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/197.png",
    spriteBack: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/197.png"
  ),
  Pokemon(
    nombre: "Magnemite", 
    nivel: 20, 
    tipo: {Elementos.Acero}, 
    ataques: [focoResplandor],
    spriteFront: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/81.png",
    spriteBack: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/81.png"
  ),
];