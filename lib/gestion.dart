import 'package:parqueadero/config.dart';
import 'package:parqueadero/entrada.dart';
import 'package:parqueadero/vehiculo.dart';

// Lista con los vehículos que están dentro del parqueadero
final List<Vehiculo> vehiculos = [];

// Placas de los vehículos que están dentro; un Set no permite repetidos
final Set<String> placasRegistradas = {};

void registrarVehiculo() {
  print('\n--- REGISTRAR VEHÍCULO ---');

  if (vehiculos.length >= capacidadMaxima) {
    print('El parqueadero está lleno ($capacidadMaxima vehículos). No se pueden registrar más hasta que salga alguno.');
    return;
  }

  String placa = leerPlaca('Placa: ');

  if (placasRegistradas.contains(placa)) {
    print('Ya hay un vehículo con la placa $placa en el parqueadero. No se puede registrar de nuevo.');
    return;
  }

  String tipo = leerTipo('Tipo (carro, moto, camioneta): ');
  String marca = leerTexto('Marca: ');
  String color = leerTexto('Color: ');
  int horaEntrada = leerHora('Hora de entrada (0 a 23): ');

  Vehiculo nuevo = Vehiculo(placa, tipo, marca, color, horaEntrada);
  vehiculos.add(nuevo);
  placasRegistradas.add(placa);

  print('\nVehículo registrado correctamente:');
  print(nuevo.obtenerInfo());
  print('Vehículos en el parqueadero: ${vehiculos.length} de $capacidadMaxima');
}

void consultarTodos() {
  print('\n--- VEHÍCULOS EN EL PARQUEADERO ---');

  if (vehiculos.isEmpty) {
    print('No hay vehículos en el parqueadero.');
    return;
  }

  for (int i = 0; i < vehiculos.length; i++) {
    print('${i + 1}. ${vehiculos[i].obtenerInfo()}');
  }

  print('Total: ${vehiculos.length} vehículo(s)');
}

// Busca un vehículo en la lista por su placa. Si no lo encuentra, devuelve null.
Vehiculo? buscarPorPlaca(String placa) {
  for (Vehiculo vehiculo in vehiculos) {
    if (vehiculo.placa == placa) {
      return vehiculo;
    }
  }

  return null;
}

void buscarVehiculo() {
  print('\n--- BUSCAR VEHÍCULO ---');

  if (vehiculos.isEmpty) {
    print('No hay vehículos en el parqueadero.');
    return;
  }

  String placa = leerPlaca('Placa a buscar: ');
  Vehiculo? encontrado = buscarPorPlaca(placa);

  if (encontrado == null) {
    print('No hay ningún vehículo con la placa $placa en el parqueadero.');
  } else {
    print('\nVehículo encontrado:');
    print(encontrado.obtenerInfo());
  }
}
