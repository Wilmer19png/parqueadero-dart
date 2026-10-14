import 'package:parqueadero/config.dart';
import 'package:parqueadero/entrada.dart';
import 'package:parqueadero/vehiculo.dart';

// Lista con los vehículos que están dentro del parqueadero
final List<Vehiculo> vehiculos = [];

// Placas de los vehículos que están dentro; un Set no permite repetidos
final Set<String> placasRegistradas = {};

// Dinero que se ha cobrado en las salidas durante esta sesión
int totalRecaudado = 0;

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

void modificarVehiculo() {
  print('\n--- MODIFICAR VEHÍCULO ---');

  if (vehiculos.isEmpty) {
    print('No hay vehículos en el parqueadero.');
    return;
  }

  String placa = leerPlaca('Placa del vehículo a modificar: ');
  Vehiculo? vehiculo = buscarPorPlaca(placa);

  if (vehiculo == null) {
    print('No hay ningún vehículo con la placa $placa en el parqueadero.');
    return;
  }

  print('\nDatos actuales:');
  print(vehiculo.obtenerInfo());

  print('\n¿Qué dato quieres modificar?');
  print('1. Marca');
  print('2. Color');
  print('3. Tipo');
  print('0. Cancelar');
  int opcion = leerEntero('Elige una opción: ');

  switch (opcion) {
    case 1:
      vehiculo.marca = leerTexto('Nueva marca: ');
    case 2:
      vehiculo.color = leerTexto('Nuevo color: ');
    case 3:
      vehiculo.tipo = leerTipo('Nuevo tipo (carro, moto, camioneta): ');
    case 0:
      print('Modificación cancelada.');
      return;
    default:
      print('Opción no válida. No se modificó ningún dato.');
      return;
  }

  print('\nVehículo modificado correctamente:');
  print(vehiculo.obtenerInfo());
}

void eliminarVehiculo() {
  print('\n--- SALIDA DE VEHÍCULO ---');

  if (vehiculos.isEmpty) {
    print('No hay vehículos en el parqueadero.');
    return;
  }

  String placa = leerPlaca('Placa del vehículo que sale: ');
  Vehiculo? vehiculo = buscarPorPlaca(placa);

  if (vehiculo == null) {
    print('No hay ningún vehículo con la placa $placa en el parqueadero.');
    return;
  }

  print('\nVehículo encontrado:');
  print(vehiculo.obtenerInfo());

  int horaSalida = leerHora('Hora de salida (0 a 23): ');

  if (horaSalida < vehiculo.horaEntrada) {
    print('La hora de salida no puede ser menor que la de entrada (${vehiculo.horaEntrada}:00). El sistema no maneja salidas al día siguiente.');
    return;
  }

  int horas = horaSalida - vehiculo.horaEntrada;
  int cobro = vehiculo.calcularCobro(horas);

  totalRecaudado = totalRecaudado + cobro;
  vehiculos.remove(vehiculo);
  placasRegistradas.remove(placa);

  print('\nSalida registrada correctamente.');
  if (horas < 1) {
    print('Tiempo: menos de 1 hora (se cobra 1 hora como mínimo)');
  } else {
    print('Tiempo: $horas hora(s)');
  }
  print('Total a pagar: \$$cobro');
}

void mostrarResumen() {
  print('\n--- RESUMEN DEL PARQUEADERO ---');

  int cuposDisponibles = capacidadMaxima - vehiculos.length;

  print('Vehículos en el parqueadero: ${vehiculos.length}');
  print('Cupos disponibles: $cuposDisponibles de $capacidadMaxima');
  print('Dinero recaudado en la sesión: \$$totalRecaudado');
}

