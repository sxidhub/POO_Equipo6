
// Interfaz
abstract class ServicioTaller {
  double calcularServicio();
  String generarReporteServicio();
}

// Clase Abstracta Padre
abstract class Vehiculo implements ServicioTaller {
  String _marca;
  String _modelo;
  int _anio;

  Vehiculo(this._marca, this._modelo, this._anio);

  // Getters
  String get marca => _marca;
  String get modelo => _modelo;
  int get anio => _anio;

  // Setters con validaciones
  set marca(String nuevaMarca) {
    if (nuevaMarca.isEmpty) {
      throw ArgumentError("La marca no puede ser vacía...");
    }
    _marca = nuevaMarca;
  }

  set modelo(String nuevaModelo) {
    if (nuevaModelo.isEmpty) {
      throw ArgumentError("El modelo no puede ser vacío...");
    }
    _modelo = nuevaModelo;
  }

  set anio(int nuevoAnio) {
    if (nuevoAnio < 1900) {
      throw ArgumentError("El año no puede ser menor que 1900...");
    }
    _anio = nuevoAnio;
  }

  // Método para descripción
  String descripcion() {
    return "$marca $modelo ($anio)";
  }
}

class Auto extends Vehiculo {
  bool _tieneAireAcondicionado;

  Auto(String marca, String modelo, int anio, this._tieneAireAcondicionado)
      : super(marca, modelo, anio);

  bool get tieneAireAcondicionado => _tieneAireAcondicionado;

  set tieneAireAcondicionado(bool valor) {
    _tieneAireAcondicionado = valor;
  }

  @override
  double calcularServicio() {
    double costoBase = 500.0;
    double alineacion = 350.0;
    double recargaAC = _tieneAireAcondicionado ? 400.0 : 0.0;
    return costoBase + alineacion + recargaAC;
  }

  @override
  String generarReporteServicio() {
    return "Servicio para AUTO ${marca} ${modelo}:\n"
        "- Año: $_anio\n"
        "- A/C: ${_tieneAireAcondicionado ? 'sí' : 'no'}\n"
        "- Total: \$${calcularServicio().toStringAsFixed(2)}";
  }

  @override
  String descripcion() {
    return "Auto: ${super.descripcion()} - A/C: ${_tieneAireAcondicionado ? 'sí' : 'no'}";
  }
}

// Subclase Moto
class Moto extends Vehiculo {
  int _cilindrada; //CC

  Moto(String marca, String modelo, int anio, this._cilindrada)
      : super(marca, modelo, anio);

  int get cilindrada => _cilindrada;

  set cilindrada(int nuevaCilindrada) {
    if (nuevaCilindrada <= 0) {
      throw ArgumentError("La cilindrada debe ser positiva...");
    }
    _cilindrada = nuevaCilindrada;
  }

  @override
  double calcularServicio() {
    double costoBase = 300.0;
    double ajusteCadena = 150.0;
    double recargoAltoDesempeno = _cilindrada >= 600 ? 200.0 : 0.0;
    return costoBase + ajusteCadena + recargoAltoDesempeno;
  }

  @override
  String generarReporteServicio() {
    return "Servicio para MOTO ${marca} ${modelo}:\n"
        "- Año: $anio\n"
        "- Cilindrada: ${_cilindrada}cc\n"
        "- Total: \$${calcularServicio().toStringAsFixed(2)}";
  }

  @override
  String descripcion() {
    return "Moto: ${super.descripcion()} - ${_cilindrada}cc";
  }
}

class Camion extends Vehiculo {
  double _capacidadToneladas;

  Camion(String marca, String modelo, int anio, this._capacidadToneladas)
      : super(marca, modelo, anio);

  double get capacidadToneladas => _capacidadToneladas;

  set capacidadToneladas(double nuevaCapacidad) {
    if (nuevaCapacidad <= 0) {
      throw ArgumentError("La capacidad debe ser positiva...");
    }
    _capacidadToneladas = nuevaCapacidad;
  }

  @override
  double calcularServicio() {
    double costoBase = 1200.0;
    double revisionFrenos = 800.0;
    double revisionSuspension = 600.0;
    double recargoCargaPesada = _capacidadToneladas > 10 ? 1000.0 : 0.0;
    return costoBase + revisionFrenos + revisionSuspension + recargoCargaPesada;
  }

  @override
  String generarReporteServicio() {
    return "Servicio para CAMIÓN ${marca} ${modelo}:\n"
        "- Año: $anio\n"
        "- Capacidad: ${_capacidadToneladas} toneladas\n"
        "- Total: \$${calcularServicio().toStringAsFixed(2)}";
  }

  @override
  String descripcion() {
    return "Camión: ${super.descripcion()} - Capacidad: ${_capacidadToneladas} toneladas";
  }
}