class Vehiculo {
  // La placa y la hora de entrada no cambian, por eso son final.
  final String placa;
  String tipo;
  String marca;
  String color;
  final int horaEntrada;

  Vehiculo(this.placa, this.tipo, this.marca, this.color, this.horaEntrada);
}
