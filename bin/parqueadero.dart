import 'dart:io';

void main() {
  mostrarBienvenida();

  bool continuar = true;

  while (continuar) {
    mostrarMenu();
    stdout.write('Elige una opción: ');
    String opcion = (stdin.readLineSync() ?? '').trim();

    switch (opcion) {
      case '1':
        print('\n[Registrar vehículo] Opción en construcción.');
      case '2':
        print('\n[Consultar todos] Opción en construcción.');
      case '3':
        print('\n[Buscar vehículo] Opción en construcción.');
      case '4':
        print('\n[Modificar vehículo] Opción en construcción.');
      case '5':
        print('\n[Eliminar vehículo] Opción en construcción.');
      case '6':
        print('\n[Mostrar resumen] Opción en construcción.');
      case '0':
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
