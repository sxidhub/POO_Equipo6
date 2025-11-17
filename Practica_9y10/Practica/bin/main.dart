import 'dart:io';
import 'package:taller_equipo6_p910/mx/unam/fi/poo/g1/p910/equipo6/vehiculos.dart';

// Para capturar desde CLI

String leerLinea(String prompt) {
  stdout.write(prompt);
  final linea = stdin.readLineSync();
  return linea ?? "";
}

int leerEntero(String prompt) {
  while (true) {
    stdout.write(prompt);
    final linea = stdin.readLineSync();
    if (linea == null) continue;
    final valor = int.tryParse(linea);
    if (valor != null) return valor;
    print("Valor inválido. Debe ser un número entero...");
  }
}

double leerDouble(String prompt) {
  while (true) {
    stdout.write(prompt);
    final linea = stdin.readLineSync();
    if (linea == null) continue;
    final valor = double.tryParse(linea);
    if (valor != null) return valor;
    print("Valor inválido. Debe ser un número real...");
  }
}

bool leerBoolSN(String prompt) {
  while (true) {
    stdout.write(prompt);
    final linea = stdin.readLineSync();
    if (linea == null) continue;
    final l = linea.trim().toLowerCase();
    if (l == "s") return true;
    if (l == "n") return false;
    print("Responde 's' o 'n' por favor...");
  }
}

// Métodos para registrar objetos
Vehiculo crearAutoInteractivo() {
  print("\n== Registro de Auto ==");
  String marca = leerLinea("Marca: ");
  String modelo = leerLinea("Modelo: ");
  int anio = leerEntero("Año: ");
  bool ac = leerBoolSN("¿Tiene aire acondicionado? (s/n): ");
  return Auto(marca, modelo, anio, ac);
}

Vehiculo crearMotoInteractiva() {
  print("\n== Registro de Moto ==");
  String marca = leerLinea("Marca: ");
  String modelo = leerLinea("Modelo: ");
  int anio = leerEntero("Año: ");
  int cc = leerEntero("Cilindrara (cc): ");
  return Moto(marca, modelo, anio, cc);
}

Vehiculo crearCamionInteractivo() {
  print("\n== Registro de Camion ==");
  String marca = leerLinea("Marca: ");
  String modelo = leerLinea("Modelo: ");
  int anio = leerEntero("Año: ");
  double toneladas = leerDouble("Capacidad de carga (toneladas): ");
  return Camion(marca, modelo, anio, toneladas);
}

// Mostrar Reportes

void mostrarListadoBasico(List<Vehiculo> flotilla) {
  if (flotilla.isEmpty) {
    print("\n(No hay vehículos registrados todavía)\n");
    return;
  }

  print("\n=== Flotilla registrada ===\n");
  for (var i = 0; i < flotilla.length; i++) {
    var v = flotilla[i];
    print("[$i] ${v.descripcion()} | Servicio: \$${v.calcularServicio().toStringAsFixed(2)}");
  }
  print("");
}

void mostrarReportesDetallados(List<Vehiculo> flotilla) {
  if (flotilla.isEmpty) {
    print("\n(No hay vehículos registrados todavía)\n");
    return;
  }

  print("\n=== Flotilla registrada ===\n");
  for (var v in flotilla) {
    print(v.generarReporteServicio());
    print("");
  }
}

void main() {
  List<Vehiculo> flotilla = [];

  while (true) {
    print("==================================");
    print("   SISTEMA PARA TALLER MECÁNICO");
    print("==================================");
    print("1) Registrar Auto");
    print("2) Registrar Moto");
    print("3) Registrar Camión");
    print("4) Ver flotilla (resumen)");
    print("5) Ver reportes detallados");
    print("0) Salir");

    int opcion = leerEntero("Elige una opción: ");

    if (opcion == 0) {
      print("\nSaliendo del sistema. Buen día.\n");
      break;
    }

    switch (opcion) {
      case 1:
        try {
          Vehiculo nuevoAuto = crearAutoInteractivo();
          flotilla.add(nuevoAuto);
          print("\n[OK] Auto agregado.\n");
        } catch (e) {
          print("\n[ERROR] $e");
        }
        break;
      case 2:
        try {
          Vehiculo nuevaMoto = crearMotoInteractiva();
          flotilla.add(nuevaMoto);
          print("\n[OK] Moto agregada.\n");
        } catch (e) {
          print("\n[ERROR] $e");
        }
        break;
      case 3:
        try {
          Vehiculo nuevoCamion = crearCamionInteractivo();
          flotilla.add(nuevoCamion);
          print("\n[OK] Camión agregado.\n");
        } catch (e) {
          print("\n[ERROR] $e");
        }
        break;
      case 4:
        mostrarListadoBasico(flotilla);
        break;
      case 5:
        mostrarReportesDetallados(flotilla);
        break;
      default:
        print("\Opción inválida\n");
    }

    //Pausa intermedia antes de volver a mostrar el menú
    leerLinea("Presiona ENTER para continuar...");
    print("\n");
  }
}