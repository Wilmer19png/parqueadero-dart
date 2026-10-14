import 'package:parqueadero/entrada.dart';
import 'package:parqueadero/vehiculo.dart';

// Lista con los vehículos que están dentro del parqueadero
final List<Vehiculo> vehiculos = [];

// Placas de los vehículos que están dentro; un Set no permite repetidos
final Set<String> placasRegistradas = {};

void registrarVehiculo() {
  print('\n--- REGISTRAR VEHÍCULO ---');

  String placa = leerPlaca('Placa: ');

  if (placasRegistradas.contains(placa)) {
    print('Ya hay un vehículo con la placa $placa en el parqueadero. No se puede registrar de nuevo.');
    return;
  }

  String tipo = leerTexto('Tipo (carro, moto, camioneta): ');
  String marca = leerTexto('Marca: ');
  String color = leerTexto('Color: ');
  int horaEntrada = leerEntero('Hora de entrada (0 a 23): ');

  Vehiculo nuevo = Vehiculo(placa, tipo, marca, color, horaEntrada);
  vehiculos.add(nuevo);
  placasRegistradas.add(placa);

  print('\nVehículo registrado correctamente:');
  print(nuevo.obtenerInfo());
  print('Vehículos en el parqueadero: ${vehiculos.length}');
}
