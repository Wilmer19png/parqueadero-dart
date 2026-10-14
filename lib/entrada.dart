import 'dart:io';

import 'package:parqueadero/config.dart';

// Lee un texto por consola y lo vuelve a pedir si queda vacío.
String leerTexto(String mensaje) {
  String texto = '';

  while (texto.isEmpty) {
    stdout.write(mensaje);
    texto = (stdin.readLineSync() ?? '').trim();

    if (texto.isEmpty) {
      print('Este campo no puede estar vacío. Intenta de nuevo.');
    }
  }

  return texto;
}

// Lee un número entero. Si el usuario escribe algo que no es número, lo vuelve a pedir.
int leerEntero(String mensaje) {
  int? numero;

  while (numero == null) {
    String texto = leerTexto(mensaje);
    numero = int.tryParse(texto);

    if (numero == null) {
      print('Debes escribir un número entero. Intenta de nuevo.');
    }
  }

  return numero;
}

// Lee una placa. Debe tener entre 5 y 6 caracteres y se devuelve en mayúsculas.
String leerPlaca(String mensaje) {
  String placa = leerTexto(mensaje).toUpperCase();

  while (placa.length < 5 || placa.length > 6) {
    print('La placa debe tener entre 5 y 6 caracteres. Intenta de nuevo.');
    placa = leerTexto(mensaje).toUpperCase();
  }

  return placa;
}

// Lee el tipo de vehículo. Solo acepta los tipos que tienen tarifa en el Map.
String leerTipo(String mensaje) {
  String tipo = leerTexto(mensaje).toLowerCase();

  while (!tarifasPorHora.containsKey(tipo)) {
    print('Tipo no válido. Los tipos permitidos son: ${tarifasPorHora.keys.join(', ')}.');
    tipo = leerTexto(mensaje).toLowerCase();
  }

  return tipo;
}
