import 'package:flutter/material.dart';
import 'package:flutter_application_1/consumibles.dart';
import 'dart:math';
import 'pokedex.dart';
import 'ataques.dart';

void main() {
  runApp(const PokemonApp());
}

class PokemonApp extends StatelessWidget {
  const PokemonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Batalla Pokémon',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.red),
      home: const PantallaSeleccion(),
    );
  }
}


// PANTALLA SELECCIÓN DE POKÉMON
class PantallaSeleccion extends StatefulWidget {
  const PantallaSeleccion({super.key});

  @override
  State<PantallaSeleccion> createState() => _PantallaSeleccionState();
}

class _PantallaSeleccionState extends State<PantallaSeleccion> {
  Pokemon? jugador1; // Tu elección

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], 
      
      appBar: AppBar(
        title: Text(jugador1 == null ? "1. Elige a tu Compañero" : "2. Elige a tu Rival"),
        backgroundColor: jugador1 == null ? Colors.blue : Colors.red, 
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.symmetric(vertical: BorderSide(color: Colors.black, width: 4)),
            boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 20)],
          ),
          
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.85,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: pokedex.length,
            itemBuilder: (context, index) {
              final pokemon = pokedex[index];
              
              // Detectamos si este pokemon está seleccionado
              bool isSelected = (jugador1 == pokemon);

              return GestureDetector(
                onTap: () {
                  if (jugador1 == null) {
                    //Elegir mi pokemon
                    setState(() {
                      jugador1 = pokemon;
                    });
                  } else {
                    //Elegir rival e ir a la batalla
                    if (pokemon == jugador1) return; // No puedes pelear contra ti mismo

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BattleScreen(
                          jugador: jugador1!, 
                          rival: pokemon
                        ),
                      ),
                    ).then((_) {
                      // Al volver, reiniciamos la selección
                      setState(() {
                        jugador1 = null;
                      });
                    });
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.blue[100] : Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: isSelected 
                        ? Border.all(color: Colors.blue, width: 3) 
                        : Border.all(color: Colors.grey[300]!),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12, 
                        blurRadius: 4, 
                        offset: const Offset(2, 2)
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Imagen un poco más grande
                      Image.network(pokemon.spriteFront, height: 110, scale: 0.8),
                      const SizedBox(height: 5),
                      Text(
                        pokemon.nombre,
                        style: TextStyle(
                          fontWeight: FontWeight.bold, 
                          fontSize: 18,
                          color: isSelected ? Colors.blue[800] : Colors.black,
                        ),
                      ),
                      // Etiqueta del tipo bonita
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          pokemon.tipo.first.toString().split('.').last,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// PANTALLA DE BATALLA
class BattleScreen extends StatefulWidget {
  // Ahora recibimos los pokemones en el constructor
  final Pokemon jugador;
  final Pokemon rival;

  const BattleScreen({super.key, required this.jugador, required this.rival});

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  late Pokemon miPokemon;
  late Pokemon oponentePokemon;
  
  late double miVidaMax;
  late double oponenteVidaMax;

  Map<Consumibles, int> mochila = {}; 
  bool mostrandoMochila = false;

  List<String> combatLog = [];
  bool turnoEnProgreso = false; 

  @override
  void initState() {
    super.initState();
    iniciarBatalla();
  }

  void agregarLog(String mensaje) {
    setState(() {
      combatLog.insert(0, mensaje); 
    });
  }

  void iniciarBatalla() {
    //Generamos una mochila al azar para el jugador
    mochila = {
      pocion: Random().nextInt(3) + 1, // Entre 1 y 3 pociones
      superPosion: Random().nextInt(2) + 1, // Entre 1 y 2 super pociones
      hiperPosion: Random().nextInt(2) + 1, // Entre 1 y 2 hiper pociones 
    };

    // Usamos los Pokémon que recibimos del constructor (widget.jugador y widget.rival)
    miPokemon = widget.jugador;
    oponentePokemon = widget.rival;


    miPokemon.curarTotalmente();
    oponentePokemon.curarTotalmente();

    miPokemon.recalcularVelocidad();
    oponentePokemon.recalcularVelocidad();

    // Establecemos la vida máxima actual
    miVidaMax = miPokemon.maxVida;
    oponenteVidaMax = oponentePokemon.maxVida;
    
    combatLog.clear();
    agregarLog("¡Batalla entre ${miPokemon.nombre} y ${oponentePokemon.nombre}!");
    turnoEnProgreso = false;
    mostrandoMochila = false;
  }

// Lógica principal del turno gestionando la velocidad ----------------------------------------------------------------------------------
  void realizarTurno(Ataque ataqueJugador) async {
    setState(() {
      turnoEnProgreso = true;
    });

    // 1. El rival elige su ataque ANTES de empezar la secuencia
    var random = Random();
    Ataque ataqueRival = oponentePokemon.ataques[random.nextInt(oponentePokemon.ataques.length)];

    // 2. Comparar velocidades
    bool jugadorEsMasRapido = miPokemon.velocidad >= oponentePokemon.velocidad;

    if (jugadorEsMasRapido) {
      // --- CASO A: TÚ ERES MÁS RÁPIDO ---
      //  Atacas tú
      await ejecutarAtaque(atacante: miPokemon, defensor: oponentePokemon, ataque: ataqueJugador, esJugador: true);
      
      // Respuesta rival si sigue vivo
      if (oponentePokemon.vida > 0) {
        await Future.delayed(const Duration(seconds: 2));
        if (!mounted) return; // Seguridad por si cierras la app
        await ejecutarAtaque(atacante: oponentePokemon, defensor: miPokemon, ataque: ataqueRival, esJugador: false);
      }

    } else {
      // --- CASO B: RIVAL ES MÁS RÁPIDO ---
      // Ataca el rival primero
      agregarLog("¡${oponentePokemon.nombre} es más rápido!"); // Aviso visual
      await Future.delayed(const Duration(seconds: 1)); // Pequeña pausa para leer que es más rápido
      
      await ejecutarAtaque(atacante: oponentePokemon, defensor: miPokemon, ataque: ataqueRival, esJugador: false);

      // Tu rrespuesta si sigues vivo
      if (miPokemon.vida > 0) {
        await Future.delayed(const Duration(seconds: 2));
        if (!mounted) return;
        await ejecutarAtaque(atacante: miPokemon, defensor: oponentePokemon, ataque: ataqueJugador, esJugador: true);
      }
    }

    // Verificar fin del juego y liberar botones
    verificarFinTurno();
  }

  //Logica para usar un objeto --------------------------------------------------------------------------------------------------------
  void usarObjeto(Consumibles item) async {
    setState(() { turnoEnProgreso = true; });

    // Aplicar efecto del objeto 
    if (item is ConsumiblesCuracion) {
      setState(() {
        mochila = item.usarCuracion(miPokemon, mochila); 
        agregarLog("¡Usaste ${item.nombre}!");
        agregarLog("Recuperaste ${item.cantidadCuracion.toInt()} HP.");
      });
    }

    // Pausa 
    await Future.delayed(const Duration(seconds: 2));

    // Turno del Rival
    if (oponentePokemon.vida > 0) {
      var random = Random();
      Ataque ataqueRival = oponentePokemon.ataques[random.nextInt(oponentePokemon.ataques.length)];
      
      await ejecutarAtaque(atacante: oponentePokemon, defensor: miPokemon, ataque: ataqueRival, esJugador: false);
    }
    verificarFinTurno();
  }



  void verificarFinTurno() {
    setState(() {
      if (miPokemon.vida <= 0) {
        agregarLog("¡${miPokemon.nombre} se debilitó! Perdiste...");
      } else if (oponentePokemon.vida <= 0) {
        agregarLog("¡${oponentePokemon.nombre} se debilitó! ¡Ganaste!");
      } else {
        turnoEnProgreso = false;
      }
    });
  }

  // Calcula daño y actualiza la vida 
  Future<void> ejecutarAtaque({
    required Pokemon atacante, 
    required Pokemon defensor, 
    required Ataque ataque, 
    required bool esJugador
  }) async {
    
    setState(() {
      // Cálculos matemáticos usando clase TablaDanio
      double danio = TablaDanio.obtenerDanioTotal(atacante, defensor, ataque);
      double multiplicador = TablaDanio.obtenerMultiplicadorTotal(ataque.tipo, defensor.tipo);

      // Restar vida
      defensor.vida -= danio;

      // Mensaje de eficacia
      String textoEficacia = "";
      if (multiplicador > 1.0) textoEficacia = "¡Es súper efectivo!";
      if (multiplicador < 1.0 && multiplicador > 0) textoEficacia = "No es muy eficaz...";
      if (multiplicador == 0) textoEficacia = "¡No afecta!";

      // Formatear mensaje
      String nombreAtacante = esJugador ? atacante.nombre : "El rival";
      
      agregarLog("$nombreAtacante usó ${ataque.nombre}.\n$textoEficacia Daño: ${danio.toStringAsFixed(1)}");
    });
  }

  Color getColorElemento(Elementos elemento) {
    switch (elemento) {
      case Elementos.Fuego: return Colors.orange;
      case Elementos.Agua: return Colors.blue;
      case Elementos.Hierba: return Colors.green;
      case Elementos.Electrico: return Colors.yellow[700]!;
      case Elementos.Psiquico: return Colors.purpleAccent;
      case Elementos.Hielo: return Colors.cyanAccent;
      case Elementos.Lucha: return Colors.brown;
      case Elementos.Veneno: return Colors.purple;
      case Elementos.Tierra: return Colors.brown[300]!;
      case Elementos.Volador: return Colors.lightBlueAccent;
      case Elementos.Bicho: return Colors.lightGreen;
      case Elementos.Roca: return Colors.grey;
      case Elementos.Fantasma: return Colors.indigo;
      case Elementos.Dragon: return Colors.deepPurple;
      case Elementos.Acero: return Colors.blueGrey;
      case Elementos.Siniestro: return Colors.black87;
      default: return Colors.grey;
    }
  }

@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Botón para salir y volver a elegir
      appBar: AppBar(
        title: const Text("Batalla Pokémon"), 
        centerTitle: true, 
        backgroundColor: Colors.redAccent, 
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black, width: 4),
            boxShadow: const [BoxShadow(color: Colors.black45, blurRadius: 10, offset: Offset(5, 5))],
            image: const DecorationImage(
              image: AssetImage("assets/fondo.png"), 
              fit: BoxFit.cover,
              alignment: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              // --- ÁREA VISUAL ---
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    Positioned(
                      top: 20, right: 20,
                      child: PokemonDisplay(pokemon: oponentePokemon, maxVida: oponenteVidaMax, imgUrl: oponentePokemon.spriteFront),
                    ),
                    Positioned(
                      bottom: 20, left: 20,
                      child: PokemonDisplay(pokemon: miPokemon, maxVida: miVidaMax, imgUrl: miPokemon.spriteBack),
                    ),
                  ],
                ),
              ),

              // --- LOG  ---
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  border: Border.all(color: Colors.grey),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: combatLog.length, 
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Text(
                        combatLog[index],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: index == 0 ? Colors.yellow : Colors.white70,
                          fontSize: 14,
                          fontFamily: 'Courier',
                        ),
                      ),
                    );
                  },
                ),
              ),

              // --- CONTROLES ---
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.grey[200],
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      // Título y Pestañas
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Botón Ataques
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: turnoEnProgreso ? null : () => setState(() => mostrandoMochila = false),
                              icon: const Icon(Icons.flash_on, size: 18),
                              label: const Text("ATAQUES"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: !mostrandoMochila ? Colors.red : Colors.grey,
                                foregroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(left: Radius.circular(10))),
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          // Botón Mochila
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: turnoEnProgreso ? null : () => setState(() => mostrandoMochila = true),
                              icon: const Icon(Icons.backpack, size: 18),
                              label: const Text("MOCHILA"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: mostrandoMochila ? Colors.blue : Colors.grey,
                                foregroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.horizontal(right: Radius.circular(10))),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 10),
                      

                      Text(
                        turnoEnProgreso 
                          ? "Esperando al rival..." 
                          : (mostrandoMochila ? "Selecciona un objeto:" : "¿Qué hará ${miPokemon.nombre}?"), 
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
                      ),
                      
                      const SizedBox(height: 5),

                      Expanded(
                        child: mostrandoMochila 
                          ? _buildMochilaGrid() // Muestra Mochila
                          : _buildAtaquesGrid() // Muestra Ataques 
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Grid de Ataques 
  Widget _buildAtaquesGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: 3.0, crossAxisSpacing: 10, mainAxisSpacing: 10,
      ),
      itemCount: miPokemon.ataques.length,
      itemBuilder: (context, index) {
        final ataque = miPokemon.ataques[index];
        final bool botonesHabilitados = !turnoEnProgreso && miPokemon.vida > 0 && oponentePokemon.vida > 0;

        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: botonesHabilitados ? getColorElemento(ataque.tipo) : Colors.grey,
            foregroundColor: Colors.white,
          ),
          onPressed: botonesHabilitados ? () => realizarTurno(ataque) : null,
          child: Text(ataque.nombre),
        );
      },
    );
  }

  // Grid de Mochila
  Widget _buildMochilaGrid() {
    if (mochila.isEmpty) {
      return const Center(
        child: Text("¡No tienes objetos!", style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic))
      );
    }

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, childAspectRatio: 3.0, crossAxisSpacing: 10, mainAxisSpacing: 10,
      ),
      itemCount: mochila.length,
      itemBuilder: (context, index) {
        Consumibles item = mochila.keys.elementAt(index);
        int cantidad = mochila[item]!;
        bool habilitado = !turnoEnProgreso && miPokemon.vida > 0 && oponentePokemon.vida > 0;

        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent, 
            foregroundColor: Colors.white
          ),
          onPressed: habilitado ? () => usarObjeto(item) : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(item.sprite, height: 24, errorBuilder: (c,e,s) => const Icon(Icons.local_drink, size: 20, color: Colors.white)),
              const SizedBox(width: 8),
              Flexible(child: Text("${item.nombre} (x$cantidad)", style: const TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis)),
            ],
          ),
        );
      },
    );
  }
}  

class PokemonDisplay extends StatelessWidget {
  final Pokemon pokemon;
  final double maxVida;
  final String imgUrl;

  const PokemonDisplay({
    super.key, 
    required this.pokemon, 
    required this.maxVida, 
    required this.imgUrl
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(pokemon.nombre, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(
          width: 120,
          child: LinearProgressIndicator(
            value: (pokemon.vida / maxVida).clamp(0.0, 1.0), // .clamp asegura que no de error si baja de 0
            color: (pokemon.vida / maxVida) > 0.5 ? Colors.green : Colors.red,
            backgroundColor: Colors.grey[300],
            minHeight: 8,
          ),
        ),
        Text("${pokemon.vida.toStringAsFixed(0)} / ${maxVida.toStringAsFixed(0)} HP"),
        Image.network(imgUrl, scale: 0.6, errorBuilder: (c,e,s) => const Icon(Icons.error)),
      ],
    );
  }
}