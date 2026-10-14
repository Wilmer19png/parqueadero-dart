# Sistema de gestión de parqueadero en Dart

Aplicación de consola desarrollada en Dart para gestionar los vehículos de un parqueadero.

**Estudiante:** Wilmer Alejandro Buriticá Alvira
**Materia:** Lenguaje de Programación para APPs — VIII semestre, Diseño Crossmedia, UCC

## Descripción del proyecto

El sistema permite llevar el control de los vehículos que entran y salen de un parqueadero desde la consola. Se pueden registrar vehículos (carro, moto o camioneta) con su placa, marca, color y hora de entrada; consultar todos los vehículos parqueados; buscar uno por su placa; modificar sus datos; registrar su salida calculando el cobro según la tarifa por hora de cada tipo; y ver un resumen con el total de vehículos, la cantidad por tipo, los cupos disponibles y el dinero recaudado.

## Alcance y limitaciones

Estas son decisiones que se tomaron para mantener el proyecto sencillo:

- **Tipos de vehículo:** solo carro, moto y camioneta. No se incluyen bicicletas porque no tienen placa y el sistema identifica cada vehículo por su placa.
- **Tarifas por hora:** carro $4.000, moto $2.000 y camioneta $5.000.
- **Capacidad:** máximo 20 vehículos al mismo tiempo.
- **Placa:** es obligatoria, debe tener entre 5 y 6 caracteres, se guarda en mayúsculas y no se puede repetir ni modificar.
- **Horas:** se escriben como números enteros de 0 a 23 (por ejemplo, 8 para las 8:00). No se manejan minutos.
- **Cobro:** se calcula como hora de salida menos hora de entrada. Si el vehículo sale en la misma hora en que entró, se cobra 1 hora como mínimo.
- **Salidas al día siguiente:** no se manejan. La hora de salida debe ser mayor o igual que la de entrada; si es menor, el sistema muestra un error indicando que no maneja salidas al día siguiente.
- **Datos:** se guardan solo en memoria mientras el programa está abierto. Al salir se pierden, porque el proyecto no usa base de datos ni archivos.

## Bitácora

### Paso 1 — Inicialización del repositorio
- **Qué se hizo:** se creó el repositorio local y el remoto en GitHub, el README con la descripción del proyecto y el archivo `.gitignore` para no subir los archivos temporales que genera Dart. En el primer commit los archivos quedaron vacíos porque no se habían guardado, así que su contenido se agregó en un segundo commit. En un tercer commit se agregó la sección de alcance y limitaciones, que había quedado por fuera.
- **Cómo se probó:** se verificó con `git rev-parse --show-toplevel` que el repositorio quedara en la carpeta del proyecto y se confirmó en GitHub que el README mostrara todas sus secciones.


### Paso 2 — Estructura del proyecto y programa principal
- **Qué se hizo:** se creó el archivo `pubspec.yaml` con el nombre del proyecto y la versión de Dart, y el archivo `bin/parqueadero.dart` con la función `main()`, que es el punto de inicio del programa. Por ahora solo muestra un mensaje de bienvenida.
- **Cómo se probó:** se ejecutó `dart run` en la terminal y se verificó que apareciera el mensaje de bienvenida sin errores.


### Paso 3 — Menú principal con switch y ciclo while
- **Qué se hizo:** se creó el menú principal con las opciones del 0 al 6. Un ciclo `while` repite el menú hasta que el usuario elige salir, y un `switch` decide qué hacer según la opción. Se separaron las funciones `mostrarBienvenida()` y `mostrarMenu()` para que `main()` quedara más ordenado. Las opciones del 1 al 6 todavía muestran "en construcción".
- **Cómo se probó:** se ejecutó `dart run` y se probaron las opciones 1 a 6 (cada una muestra su mensaje), una opción inexistente (9) y un texto ("hola"), que muestran "Opción no válida". Con 0 el programa terminó correctamente.


### Paso 4 — Funciones de lectura por consola y validación del menú
- **Qué se hizo:** se creó el archivo `lib/entrada.dart` con dos funciones reutilizables: `leerTexto()`, que no acepta campos vacíos, y `leerEntero()`, que no acepta valores que no sean números enteros. El menú ahora lee la opción con `leerEntero()` y el `switch` compara números. Con esto el código quedó dividido en más de un archivo.
- **Cómo se probó:** se ejecutó `dart run` y se probó presionar Enter sin escribir nada (pide de nuevo el dato), escribir "hola" (avisa que debe ser un número), escribir 9 (opción no válida), escribir 2 (muestra su mensaje) y escribir 0 (sale del programa).


### Paso 5 — Clase Vehiculo con atributos y constructor
- **Qué se hizo:** se creó el archivo `lib/vehiculo.dart` con la clase `Vehiculo`, que tiene los atributos placa, tipo, marca, color y hora de entrada, y un constructor para crear vehículos con esos datos. La placa y la hora de entrada se declararon como `final` porque no deben cambiar después de registrar el vehículo. En `main()` se creó un objeto de prueba para comprobar que la clase funciona.
- **Cómo se probó:** se ejecutó `dart run` y se verificó que antes del menú aparecieran los datos del vehículo de prueba (ABC123, carro, Mazda, Rojo, 8:00).


### Paso 6 — Método para obtener la información del vehículo
- **Qué se hizo:** se agregó a la clase `Vehiculo` el método `obtenerInfo()`, que devuelve en una sola línea la placa, el tipo, la marca, el color y la hora de entrada. En `main()` se reemplazaron los cinco `print` del vehículo de prueba por una sola llamada a este método, lo que evita repetir código cada vez que se necesite mostrar un vehículo.
- **Cómo se probó:** se ejecutó `dart run` y se verificó que antes del menú apareciera la línea `Placa: ABC123 | Tipo: carro | Marca: Mazda | Color: Rojo | Entrada: 8:00`.


### Paso 7 — Constantes del parqueadero y Map de tarifas
- **Qué se hizo:** se creó el archivo `lib/config.dart` con la constante `capacidadMaxima` (20 vehículos) y el Map `tarifasPorHora`, que relaciona cada tipo de vehículo con su tarifa por hora (carro $4000, moto $2000, camioneta $5000). Se agregó la función `mostrarTarifas()`, que recorre el Map con un ciclo `for-in` y muestra las tarifas al iniciar el programa.
- **Cómo se probó:** se ejecutó `dart run` y se verificó que debajo del título aparecieran la capacidad máxima y las tres tarifas.



### Paso 8 — Método calcularCobro en la clase Vehiculo
- **Qué se hizo:** se agregó a la clase `Vehiculo` el método `calcularCobro(horas)`, que busca la tarifa del tipo de vehículo en el Map `tarifasPorHora` y la multiplica por las horas. Con un `if/else` se aplica la regla de cobrar mínimo 1 hora cuando el vehículo sale en la misma hora en que entró. En `main()` se agregaron dos líneas temporales para probar el cálculo.
- **Cómo se probó:** se ejecutó `dart run` con el vehículo de prueba (un carro) y se verificó que 3 horas dieran $12000 (3 × 4000) y que 0 horas cobraran el mínimo de 1 hora, $4000.


### Paso 9 — Registro de vehículos en una lista
- **Qué se hizo:** se creó el archivo `lib/gestion.dart`, donde va la lógica de las opciones del menú. Tiene la lista `vehiculos` (List de objetos `Vehiculo`) y la función `registrarVehiculo()`, que pide los datos por consola, crea el objeto con el constructor y lo agrega a la lista. La opción 1 del menú ahora llama a esta función, y se quitó el vehículo de prueba de `main()`.
- **Cómo se probó:** se ejecutó `dart run`, se registraron dos vehículos (ABC123 carro y XYZ98 moto) y se verificó que el contador subiera de 1 a 2. También se comprobó que al dejar la marca vacía o escribir "ocho" en la hora, el programa volviera a pedir el dato.


### Paso 10 — Validación del formato de la placa
- **Qué se hizo:** se agregó en `lib/entrada.dart` la función `leerPlaca()`, que usa `leerTexto()` para no aceptar placas vacías, vuelve a pedir la placa si no tiene entre 5 y 6 caracteres y la convierte a mayúsculas. El registro de vehículos ahora lee la placa con esta función. Se dejó en `entrada.dart` porque también se va a usar en buscar, modificar y eliminar.
- **Cómo se probó:** se registró un vehículo escribiendo primero "AB1" (muy corta) y "ABCD1234" (muy larga), que fueron rechazadas; luego Enter vacío, que pidió de nuevo el dato; y por último "abc123", que se guardó como "ABC123".


### Paso 11 — Validación de placa repetida con un Set
- **Qué se hizo:** se agregó en `lib/gestion.dart` el Set `placasRegistradas`, que guarda las placas de los vehículos que están dentro del parqueadero. Al registrar, si la placa ya está en el Set se muestra un error y se vuelve al menú sin pedir los demás datos; si no está, se registra el vehículo y se agrega su placa al Set.
- **Cómo se probó:** se registró el vehículo ABC123 y luego se intentó registrar "abc123", que el sistema rechazó por estar repetida (al pasarla a mayúsculas es la misma placa). Después se registró XYZ98 sin problema y el contador quedó en 2.


### Paso 12 — Validación del tipo de vehículo
- **Qué se hizo:** se agregó en `lib/entrada.dart` la función `leerTipo()`, que convierte el tipo a minúsculas y solo lo acepta si existe como clave en el Map `tarifasPorHora`. Si no existe, muestra los tipos permitidos y lo vuelve a pedir. El registro ahora lee el tipo con esta función, así que todo vehículo registrado tiene una tarifa válida.
- **Cómo se probó:** se registró un vehículo escribiendo "bicicleta" y "bus", que fueron rechazados mostrando los tipos permitidos, y luego "CARRO", que fue aceptado y se guardó como "carro".


### Paso 13 — Validación de la hora de entrada
- **Qué se hizo:** se agregó en `lib/entrada.dart` la función `leerHora()`, que usa `leerEntero()` y además vuelve a pedir la hora si es menor que 0 o mayor que 23. El registro ahora lee la hora de entrada con esta función. También se usará más adelante para la hora de salida.
- **Cómo se probó:** se registró un vehículo escribiendo como hora "24" y "-3", que fueron rechazados por estar fuera de rango, luego "ocho", que fue rechazado por no ser un número, y por último "0", que fue aceptado como hora válida (medianoche).


### Paso 14 — Validación de la capacidad máxima
- **Qué se hizo:** al inicio de `registrarVehiculo()` se agregó una validación que compara la cantidad de vehículos de la lista con la constante `capacidadMaxima`. Si el parqueadero está lleno, muestra un aviso y vuelve al menú sin pedir datos. También se cambió el mensaje final del registro para mostrar cuántos cupos se están usando (por ejemplo, "1 de 20").
- **Cómo se probó:** para no registrar 20 vehículos, se cambió temporalmente `capacidadMaxima` a 2 en `config.dart`. Se registraron dos vehículos y, al intentar un tercero, apareció el aviso de parqueadero lleno sin pedir la placa. Después se volvió a dejar la capacidad en 20.
