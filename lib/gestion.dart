import 'package:parqueadero/entrada.dart';
import 'package:parqueadero/vehiculo.dart';

// Lista con los vehículos que están dentro del parqueadero
final List<Vehiculo> vehiculos = [];

void registrarVehiculo() {
  print('\n--- REGISTRAR VEHÍCULO ---');

  String placa = leerTexto('Placa: ');
  String tipo = leerTexto('Tipo (carro, moto, camioneta): ');
  String marca = leerTexto('Marca: ');
  String color = leerTexto('Color: ');
  int horaEntrada = leerEntero('Hora de entrada (0 a 23): ');

  Vehiculo nuevo = Vehiculo(placa, tipo, marca, color, horaEntrada);
  vehiculos.add(nuevo);

  print('\nVehículo registrado correctamente:');
  print(nuevo.obtenerInfo());
  print('Vehículos en el parqueadero: ${vehiculos.length}');
}
