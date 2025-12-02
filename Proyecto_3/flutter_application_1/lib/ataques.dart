import 'pokedex.dart';

/// =========================
///        MODELO
/// =========================

class Ataque {
  final String nombre;
  final Elementos tipo;
  final double danio;
  Ataque(this.nombre, this.tipo, this.danio);
}


// BANCO DE ATAQUES (2 por tipo: Uno Débil y Uno Fuerte) ----------------------
// --- NORMAL ---
final tacleada = Ataque("Tacleada", Elementos.Normal, 1.0);       // Débil
final golpeCuerpo = Ataque("Golpe Cuerpo", Elementos.Normal, 2.5); // Fuerte
// --- FUEGO ---
final ascuas = Ataque("Ascuas", Elementos.Fuego, 1.2);            // Débil 
final lanzallamas = Ataque("Lanzallamas", Elementos.Fuego, 3.0);  // Fuerte
// --- AGUA ---
final pistolaAgua = Ataque("Pistola Agua", Elementos.Agua, 1.0);  // Débil 
final hidroBomba = Ataque("Hidro Bomba", Elementos.Agua, 3.0);    // Fuerte
// --- ELÉCTRICO ---
final impactrueno = Ataque("Impactrueno", Elementos.Electrico, 1.2); // Débil 
final rayo = Ataque("Rayo", Elementos.Electrico, 2.8);               // Fuerte
// --- HIERBA ---
final latigoCepa = Ataque("Látigo Cepa", Elementos.Hierba, 1.0);  // Débil )
final hojaAfilada = Ataque("Hoja Afilada", Elementos.Hierba, 2.5); // Fuerte
// --- HIELO ---
final cantoHelado = Ataque("Canto Helado", Elementos.Hielo, 1.0); // Débil 
final rayoHielo = Ataque("Rayo Hielo", Elementos.Hielo, 2.8);     // Fuerte
// --- LUCHA ---
final golpeKarate = Ataque("Golpe Karate", Elementos.Lucha, 1.5); // Débil
final aBocajarro = Ataque("A Bocajarro", Elementos.Lucha, 3.0);   // Fuerte 
// --- VENENO ---
final picotazoVen = Ataque("Picotazo Ven", Elementos.Veneno, 0.8); // Débil 
final bombaAcida = Ataque("Bomba Ácida", Elementos.Veneno, 2.5);   // Fuerte
// --- TIERRA ---
final disparoLodo = Ataque("Disparo Lodo", Elementos.Tierra, 1.0); // Débil
final terremoto = Ataque("Terremoto", Elementos.Tierra, 3.0);      // Fuerte
// --- VOLADOR ---
final picotazo = Ataque("Picotazo", Elementos.Volador, 0.8);      // Débil 
final vendaval = Ataque("Vendaval", Elementos.Volador, 2.5);      // Fuerte
// --- PSIQUICO ---
final confusion = Ataque("Confusión", Elementos.Psiquico, 1.2);   // Débil 
final psiquico = Ataque("Psíquico", Elementos.Psiquico, 2.8);     // Fuerte
// --- BICHO ---
final corteFuria = Ataque("Corte Furia", Elementos.Bicho, 0.8);   // Débil 
final tijeraX = Ataque("Tijera X", Elementos.Bicho, 2.5);         // Fuerte
// --- ROCA ---
final lanzarrocas = Ataque("Lanzarrocas", Elementos.Roca, 1.0);   // Débil 
final avalancha = Ataque("Avalancha", Elementos.Roca, 2.5);       // Fuerte
// --- FANTASMA ---
final lenguetazo = Ataque("Lengüetazo", Elementos.Fantasma, 0.8); // Débil 
final bolaSombra = Ataque("Bola Sombra", Elementos.Fantasma, 2.5); // Fuerte
// --- DRAGÓN ---
final dragoaliento = Ataque("Dragoaliento", Elementos.Dragon, 1.5); // Débil 
final garraDragon = Ataque("Garra Dragón", Elementos.Dragon, 2.5);  // Fuerte
// --- SINIESTRO ---
final mordisco = Ataque("Mordisco", Elementos.Siniestro, 1.2);      // Débil 
final pulsoUmbrio = Ataque("Pulso Umbrío", Elementos.Siniestro, 2.5); // Fuerte
// --- ACERO ---
final garraMetal = Ataque("Garra Metal", Elementos.Acero, 1.2);     // Débil 
final focoResplandor = Ataque("Foco Resplandor", Elementos.Acero, 2.5); // Fuerte



class TablaDanio{
  TablaDanio._(); //Constructor privado para evitar crear objeto

  //Obtener el valor
  static double obtener(Elementos ataque, Elementos defensa) {
    return tablaDanio[ataque]?[defensa] ?? 1.0;
  }

  //Obtener el daño total (para la resta de vida)
  static double obtenerDanioTotal(Pokemon atacante, Pokemon defensor, Ataque ataque) {
    Elementos tipoAtaque = ataque.tipo;
    double multiplicadorTotal = 1.0;
    for (var tipoDefensor in defensor.tipo) {
      double efectividad = TablaDanio.obtener(tipoAtaque, tipoDefensor);
      multiplicadorTotal = multiplicadorTotal * efectividad;
    } //   nivel * poderAtaque * multiplicadorTotal
    return atacante.nivel*ataque.danio*multiplicadorTotal;
  }

  //Obtener el multiplicador total (para mensajes de efectividad)
  static double obtenerMultiplicadorTotal(Elementos ataque, Set<Elementos> tiposDefensa) {
    double multiplicadorTotal = 1.0;
    for (var tipoDefensor in tiposDefensa) {
      double efectividad = TablaDanio.obtener(ataque, tipoDefensor);
      multiplicadorTotal = multiplicadorTotal * efectividad;
    }
    return multiplicadorTotal;
  }

  //Calcular efectividad tabla de daño
  static final Map<Elementos, Map<Elementos, double>> tablaDanio = {
    Elementos.Normal: {
      Elementos.Roca: 0.5,
      Elementos.Fantasma: 0.0,
      Elementos.Acero: 0.5,
    },

    Elementos.Fuego: {
      Elementos.Fuego: 0.5,
      Elementos.Agua: 0.5,
      Elementos.Hierba: 2.0,
      Elementos.Hielo: 2.0,
      Elementos.Bicho: 2.0,
      Elementos.Roca: 0.5,
      Elementos.Dragon: 0.5,
      Elementos.Acero: 2.0,
    },

    Elementos.Agua: {
      Elementos.Fuego: 2.0,
      Elementos.Agua: 0.5,
      Elementos.Hierba: 0.5,
      Elementos.Tierra: 2.0,
      Elementos.Roca: 2.0,
      Elementos.Dragon: 0.5,
    },

    Elementos.Electrico: {
      Elementos.Agua: 2.0,
      Elementos.Electrico: 0.5,
      Elementos.Hierba: 0.5,
      Elementos.Tierra: 0.0,
      Elementos.Volador: 2.0,
      Elementos.Dragon: 0.5,
    },

    Elementos.Hierba: {
      Elementos.Fuego: 0.5,
      Elementos.Agua: 2.0,
      Elementos.Hierba: 0.5,
      Elementos.Veneno: 0.5,
      Elementos.Tierra: 2.0,
      Elementos.Volador: 0.5,
      Elementos.Bicho: 0.5,
      Elementos.Roca: 2.0,
      Elementos.Dragon: 0.5,
      Elementos.Acero: 0.5,
    },

    Elementos.Hielo: {
      Elementos.Fuego: 0.5,
      Elementos.Agua: 0.5,
      Elementos.Hierba: 2.0,
      Elementos.Hielo: 0.5,
      Elementos.Tierra: 2.0,
      Elementos.Volador: 2.0,
      Elementos.Dragon: 2.0,
      Elementos.Acero: 0.5,
    },

    Elementos.Lucha: {
      Elementos.Normal: 2.0,
      Elementos.Hielo: 2.0,
      Elementos.Veneno: 0.5,
      Elementos.Volador: 0.5,
      Elementos.Psiquico: 0.5,
      Elementos.Bicho: 0.5,
      Elementos.Roca: 2.0,
      Elementos.Fantasma: 0.0,
      Elementos.Siniestro: 2.0,
      Elementos.Acero: 2.0,
    },

    Elementos.Veneno: {
      Elementos.Hierba: 2.0,
      Elementos.Veneno: 0.5,
      Elementos.Tierra: 0.5,
      Elementos.Roca: 0.5,
      Elementos.Fantasma: 0.5,
      Elementos.Acero: 0.0,
    },

    Elementos.Tierra: {
      Elementos.Fuego: 2.0,
      Elementos.Electrico: 2.0,
      Elementos.Hierba: 0.5,
      Elementos.Veneno: 2.0,
      Elementos.Volador: 0.0,
      Elementos.Bicho: 0.5,
      Elementos.Roca: 2.0,
      Elementos.Acero: 2.0,
    },

    Elementos.Volador: {
      Elementos.Electrico: 0.5,
      Elementos.Hierba: 2.0,
      Elementos.Lucha: 2.0,
      Elementos.Bicho: 2.0,
      Elementos.Roca: 0.5,
      Elementos.Acero: 0.5,
    },

    Elementos.Psiquico: {
      Elementos.Lucha: 2.0,
      Elementos.Veneno: 2.0,
      Elementos.Psiquico: 0.5,
      Elementos.Siniestro: 0.0,
      Elementos.Acero: 0.5,
    },

    Elementos.Bicho: {
      Elementos.Fuego: 0.5,
      Elementos.Hierba: 2.0,
      Elementos.Lucha: 0.5,
      Elementos.Veneno: 0.5,
      Elementos.Volador: 0.5,
      Elementos.Psiquico: 2.0,
      Elementos.Fantasma: 0.5,
      Elementos.Siniestro: 2.0,
      Elementos.Acero: 0.5,
    },

    Elementos.Roca: {
      Elementos.Fuego: 2.0,
      Elementos.Hielo: 2.0,
      Elementos.Lucha: 0.5,
      Elementos.Tierra: 0.5,
      Elementos.Volador: 2.0,
      Elementos.Bicho: 2.0,
      Elementos.Acero: 0.5,
    },

    Elementos.Fantasma: {
      Elementos.Normal: 0.0,
      Elementos.Psiquico: 2.0,
      Elementos.Fantasma: 2.0,
      Elementos.Siniestro: 0.5,
      Elementos.Acero: 0.5, 
    },

    Elementos.Dragon: {
      Elementos.Dragon: 2.0,
      Elementos.Acero: 0.5,
    },

    Elementos.Siniestro: {
      Elementos.Lucha: 0.5,
      Elementos.Psiquico: 2.0,
      Elementos.Fantasma: 2.0,
      Elementos.Siniestro: 0.5,
      Elementos.Acero: 0.5,
    },

    Elementos.Acero: {
      Elementos.Fuego: 0.5,
      Elementos.Agua: 0.5,
      Elementos.Electrico: 0.5,
      Elementos.Hielo: 2.0,
      Elementos.Roca: 2.0,
      Elementos.Acero: 0.5,
    },
  };
}