import 'package:parqueadero/config.dart';

class Vehiculo {
  // La placa y la hora de entrada no cambian, por eso son final.
  final String placa;
  String tipo;
  String marca;
  String color;
  final int horaEntrada;

  Vehiculo(this.placa, this.tipo, this.marca, this.color, this.horaEntrada);

  // Devuelve los datos del vehículo en una sola línea
  String obtenerInfo() {
    return 'Placa: $placa | Tipo: $tipo | Marca: $marca | Color: $color | Entrada: $horaEntrada:00';
  }

  // Calcula el valor a pagar según las horas y la tarifa de su tipo
  int calcularCobro(int horas) {
    int horasCobradas;

    // Si sale en la misma hora en que entró, se cobra 1 hora como mínimo
    if (horas < 1) {
      horasCobradas = 1;
    } else {
      horasCobradas = horas;
    }

    int tarifa = tarifasPorHora[tipo] ?? 0;
    return horasCobradas * tarifa;
  }
}
