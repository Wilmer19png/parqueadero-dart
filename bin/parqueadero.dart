import 'package:parqueadero/config.dart';
import 'package:parqueadero/entrada.dart';
import 'package:parqueadero/gestion.dart';

void main() {
  mostrarBienvenida();
  mostrarTarifas();

  bool continuar = true;

  while (continuar) {
    mostrarMenu();
    int opcion = leerEntero('Elige una opción: ');

    switch (opcion) {
      case 1:
        registrarVehiculo();
      case 2:
        consultarTodos();
      case 3:
        buscarVehiculo();
      case 4:
        modificarVehiculo();
      case 5:
        eliminarVehiculo();
      case 6:
        print('\n[Mostrar resumen] Opción en construcción.');
      case 0:
        print('\nGracias por usar el sistema. ¡Hasta pronto!');
        continuar = false;
      default:
        print('\nOpción no válida. Escribe un número del 0 al 6.');
    }
  }
}

void mostrarBienvenida() {
  print('======================================');
  print('   SISTEMA DE GESTIÓN DE PARQUEADERO');
  print('======================================');
}

void mostrarTarifas() {
  print('Capacidad máxima: $capacidadMaxima vehículos');
  print('Tarifas por hora:');
  for (String tipo in tarifasPorHora.keys) {
    print('  - $tipo: \$${tarifasPorHora[tipo]}');
  }
}

void mostrarMenu() {
  print('\n----------- MENÚ PRINCIPAL -----------');
  print('1. Registrar vehículo');
  print('2. Consultar todos');
  print('3. Buscar vehículo');
  print('4. Modificar vehículo');
  print('5. Eliminar vehículo (salida)');
  print('6. Mostrar resumen');
  print('0. Salir');
  print('--------------------------------------');
}
