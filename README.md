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
- **Cobro:** las horas se calculan como (días × 24) + hora de salida − hora de entrada, y se multiplican por la tarifa del tipo de vehículo. Si el vehículo sale el mismo día y en la misma hora en que entró, se cobra 1 hora como mínimo.
- **Estadías de varios días:** el sistema no guarda fechas, así que al registrar la salida pregunta cuántos días después de la entrada sale el vehículo (0 si es el mismo día). Así se pueden cobrar estadías de un día para otro o de más de 24 horas. Si sale el mismo día, la hora de salida no puede ser menor que la de entrada.
- **Datos:** se guardan solo en memoria mientras el programa está abierto. Al salir se pierden, porque el proyecto no usa base de datos ni archivos.

## Instrucciones para ejecutarlo

**Requisito:** tener instalado el SDK de Dart, versión 3.0 o superior. Para verificarlo:

```bash
dart --version
```

**Pasos:**

1. Clonar el repositorio y entrar a la carpeta:
   ```bash
   git clone https://github.com/Wilmer19png/parqueadero-dart.git
   cd parqueadero-dart
   ```
2. Ejecutar el programa:
   ```bash
   dart run
   ```
3. Usar el menú escribiendo el número de la opción y presionando Enter. Con la opción 0 se sale del programa.

## Estructura de archivos

```
parqueadero-dart/
├── bin/
│   └── parqueadero.dart
├── lib/
│   ├── config.dart
│   ├── entrada.dart
│   ├── gestion.dart
│   └── vehiculo.dart
├── pubspec.yaml
├── pubspec.lock
├── .gitignore
└── README.md
```

| Archivo | Qué contiene |
|---|---|
| `bin/parqueadero.dart` | La función `main()`, que es el punto de inicio. Muestra la bienvenida, las tarifas y el menú principal; usa un ciclo `while` para repetir el menú y un `switch` para ejecutar la opción elegida. |
| `lib/vehiculo.dart` | La clase `Vehiculo` con sus atributos (placa, tipo, marca, color y hora de entrada), su constructor y los métodos `obtenerInfo()` y `calcularCobro()`. |
| `lib/config.dart` | Las constantes del parqueadero: la capacidad máxima y el Map de tarifas por hora. |
| `lib/entrada.dart` | Las funciones que leen datos por consola y los validan: `leerTexto()`, `leerEntero()`, `leerPlaca()`, `leerTipo()` y `leerHora()`. |
| `lib/gestion.dart` | La lista de vehículos, el Set de placas, el total recaudado y las funciones de cada opción del menú: registrar, consultar, buscar, modificar, eliminar (salida) y mostrar el resumen. |
| `pubspec.yaml` | El nombre del proyecto y la versión de Dart que necesita. |

### Uso de List, Set y Map

- **List (`vehiculos`):** guarda los objetos `Vehiculo` que están dentro del parqueadero. Se usa porque mantiene el orden en que entraron, puede crecer y reducirse a medida que entran y salen, y se puede recorrer para mostrarlos o buscarlos.
- **Set (`placasRegistradas`):** guarda las placas de los vehículos que están dentro. Se usa porque un Set no permite elementos repetidos y con `contains()` se revisa rápidamente si una placa ya está registrada.
- **Map (`tarifasPorHora` y `cantidadPorTipo`):** relacionan una clave con un valor. `tarifasPorHora` relaciona cada tipo de vehículo con su tarifa, sirve para calcular el cobro y sus claves indican qué tipos se aceptan. `cantidadPorTipo` relaciona cada tipo con la cantidad de vehículos de ese tipo y se usa en el resumen.

## Investigación: clases y objetos

### ¿Qué es una clase?
Una clase es como un molde o una plantilla. Define qué datos va a tener algo y qué va a poder hacer, pero por sí sola no es ningún elemento concreto. En este proyecto, `Vehiculo` es una clase: dice que todo vehículo del parqueadero tiene placa, tipo, marca, color y hora de entrada, y que sabe mostrar su información y calcular cuánto debe pagar.

### ¿Qué es un objeto?
Un objeto es algo concreto creado a partir de una clase, con sus propios datos. Cada vez que se registra un vehículo en el sistema se crea un objeto nuevo, por ejemplo:

```dart
Vehiculo nuevo = Vehiculo('ABC123', 'carro', 'Mazda', 'Rojo', 8);
```

Ese objeto es un carro Mazda rojo, de placa ABC123, que entró a las 8:00. Si después se registra una moto Yamaha de placa XYZ98, ese es otro objeto distinto, aunque los dos salen de la misma clase.

### ¿Cuál es la diferencia entre clase y objeto?
La clase es la definición general y el objeto es un caso real de esa definición. La clase `Vehiculo` se escribe una sola vez en el código; los objetos se crean todas las veces que se necesiten mientras el programa funciona, cada uno con sus propios datos. Es como la diferencia entre el formulario de registro del parqueadero (la clase) y cada formulario ya lleno con los datos de un carro (los objetos).

### ¿Qué es un atributo?
Un atributo es un dato que guarda cada objeto. En la clase `Vehiculo` los atributos son `placa`, `tipo`, `marca`, `color` y `horaEntrada`. Todos los vehículos tienen esos atributos, pero cada uno con sus propios valores. Algunos son `final`, como la placa y la hora de entrada, porque no deben cambiar después de registrar el vehículo; otros, como el color, sí se pueden modificar.

### ¿Qué es un método?
Un método es una acción que puede hacer un objeto, y trabaja con sus propios atributos. La clase `Vehiculo` tiene dos:

- `obtenerInfo()`: devuelve en una línea los datos del vehículo, para mostrarlo en la lista, en la búsqueda o al modificarlo.
- `calcularCobro(horas)`: usa el tipo del vehículo para buscar su tarifa y la multiplica por las horas, cobrando mínimo 1 hora.

Por ejemplo, si un carro y una moto llaman a `calcularCobro(3)`, cada uno obtiene un resultado distinto, porque el método usa el tipo de cada objeto.

### ¿Para qué sirve un constructor?
El constructor es el que crea el objeto y le asigna sus datos iniciales. Se llama igual que la clase. En `Vehiculo` es así:

```dart
Vehiculo(this.placa, this.tipo, this.marca, this.color, this.horaEntrada);
```

Cuando se registra un vehículo, el constructor recibe los cinco datos que escribió el usuario y, con `this`, guarda cada uno en el atributo correspondiente del objeto nuevo. Gracias al constructor, todo vehículo se crea con sus datos completos desde el principio.

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


### Paso 15 — Consulta de todos los vehículos
- **Qué se hizo:** se agregó en `lib/gestion.dart` la función `consultarTodos()`, que recorre la lista de vehículos con un ciclo `for` clásico y muestra cada uno numerado usando el método `obtenerInfo()`. Si la lista está vacía, muestra un aviso. Al final muestra el total. La opción 2 del menú ahora llama a esta función.
- **Cómo se probó:** se ejecutó `dart run`, se eligió la opción 2 sin vehículos y apareció el aviso "No hay vehículos en el parqueadero". Luego se registraron ABC123 y XYZ98, y la opción 2 los mostró numerados del 1 al 2 con el total.


### Paso 16 — Búsqueda de vehículo por placa
- **Qué se hizo:** se agregaron en `lib/gestion.dart` dos funciones. `buscarPorPlaca()` recorre la lista con un ciclo `for-in` y devuelve el vehículo que tenga la placa indicada, o `null` si no lo encuentra; se va a reutilizar en modificar y eliminar. `buscarVehiculo()` es la opción 3 del menú: pide la placa con `leerPlaca()` y muestra el vehículo o un aviso si no existe.
- **Cómo se probó:** se eligió la opción 3 sin vehículos y apareció el aviso sin pedir la placa. Luego se registró ABC123 y se buscó "xyz98", que no existe, y apareció el aviso; después se buscó "abc123" en minúsculas y se encontró el vehículo ABC123.


### Paso 17 — Modificación de marca, color y tipo
- **Qué se hizo:** se agregó en `lib/gestion.dart` la función `modificarVehiculo()`. Pide la placa, busca el vehículo con `buscarPorPlaca()` y, si existe, muestra sus datos actuales y un submenú con `switch` para cambiar la marca, el color o el tipo (este último validado con `leerTipo()`). La placa y la hora de entrada no se pueden modificar porque son `final` en la clase. La opción 4 del menú ahora llama a esta función.
- **Cómo se probó:** se registró ABC123 y se intentó modificar la placa ZZZ11, que no existe, y apareció el aviso. Luego se cambió el color de ABC123 a "Azul" y el tipo a "camioneta" (antes se rechazó "bus"). También se probó una opción inválida (7), que no cambió nada, y la opción 0, que canceló. Al consultar todos, el vehículo mostró los cambios.


### Paso 18 — Salida de vehículos con cobro y recaudo
- **Qué se hizo:** se agregó en `lib/gestion.dart` la función `eliminarVehiculo()`, que registra la salida de un vehículo. Busca el vehículo por placa, pide la hora de salida con `leerHora()` y valida que no sea menor que la de entrada; si lo es, muestra un mensaje indicando que el sistema no maneja salidas al día siguiente y no elimina nada. Si es válida, calcula las horas, obtiene el cobro con `calcularCobro()` (que aplica el mínimo de 1 hora), lo suma a la nueva variable `totalRecaudado` y quita el vehículo de la lista y su placa del Set. La opción 5 del menú ahora llama a esta función.
- **Cómo se probó:** se registraron ABC123 (carro, 8:00) y XYZ98 (moto, 9:00). Se intentó sacar la placa QQQ11, que no existe, y apareció el aviso. Al sacar ABC123 con hora 7 apareció el mensaje de día siguiente y el vehículo siguió registrado. Luego ABC123 salió a las 11 y se cobraron 3 horas, $12000; XYZ98 salió a las 9 y se cobró el mínimo de 1 hora, $2000. Al consultar todos, la lista estaba vacía, y se pudo volver a registrar ABC123, lo que confirma que su placa también salió del Set.


### Paso 19 — Resumen con total, cupos y recaudo
- **Qué se hizo:** se agregó en `lib/gestion.dart` la función `mostrarResumen()`, que muestra cuántos vehículos hay en el parqueadero, cuántos cupos quedan disponibles (capacidad máxima menos vehículos actuales) y el dinero recaudado en la sesión. La opción 6 del menú ahora llama a esta función, con lo que todas las opciones del menú quedaron funcionando.
- **Cómo se probó:** se eligió la opción 6 al iniciar y mostró 0 vehículos, 20 cupos y $0. Después de registrar ABC123 y XYZ98 mostró 2 vehículos y 18 cupos. Al sacar ABC123 a las 11 (entrada 8, cobro de $12000), el resumen mostró 1 vehículo, 19 cupos y $12000 recaudados.


### Paso 20 — Conteo de vehículos por tipo en el resumen
- **Qué se hizo:** se modificó `mostrarResumen()` para mostrar cuántos vehículos hay de cada tipo. Se usa un Map `cantidadPorTipo` (tipo → cantidad): primero, con un `for-in` sobre las claves de `tarifasPorHora`, se pone cada tipo en 0; luego, con otro `for-in` sobre la lista de vehículos, se suma 1 al tipo de cada vehículo. Al final se recorre el Map para mostrar el conteo.
- **Cómo se probó:** se eligió la opción 6 sin vehículos y los tres tipos aparecieron en 0. Luego se registraron ABC123 (carro), XYZ98 (moto) y DEF456 (carro), y el resumen mostró carro: 2, moto: 1, camioneta: 0, con 3 vehículos y 17 cupos disponibles.


### Paso 21 — Salidas con estadías de varios días
- **Qué se hizo:** se modificó `eliminarVehiculo()` para que, antes de la hora de salida, pregunte cuántos días después de la entrada sale el vehículo (0 si es el mismo día), validando con un ciclo `while` que no sea negativo. Las horas ahora se calculan como días × 24 + hora de salida − hora de entrada, lo que permite cobrar estadías de un día para otro y de más de 24 horas. La validación de que la salida no sea menor que la entrada ahora solo aplica cuando sale el mismo día. Se actualizó la sección de alcance y limitaciones del README.
- **Cómo se probó:** se registraron cinco vehículos y se sacaron así: carro con entrada 8, 0 días y salida 11 (3 horas, $12000); moto con entrada 20 y salida 8 con 0 días, que mostró el error, luego -1 días, que fue rechazado, y 1 día (12 horas, $24000); camioneta con entrada 8, 1 día y salida 10 (26 horas, $130000); carro con entrada 8, 3 días y salida 8 (72 horas, $288000); y moto con entrada 9, 0 días y salida 9 (mínimo 1 hora, $2000). El resumen mostró $456000 recaudados, que es la suma de los cinco cobros.


### Paso 22 — Instrucciones de ejecución y estructura de archivos
- **Qué se hizo:** se agregaron al README las secciones de instrucciones para ejecutar el proyecto, estructura de archivos (con una tabla que explica qué contiene cada uno) y una explicación de por qué se usa cada colección: List, Set y Map.
- **Cómo se probó:** se clonó el repositorio en una carpeta nueva siguiendo las instrucciones y se ejecutó `dart run`, que abrió el programa sin pasos adicionales. También se revisó en GitHub que las secciones nuevas se vieran correctamente.


### Paso 23 — Investigación sobre clases y objetos
- **Qué se hizo:** se agregó al README una investigación corta sobre qué es una clase, qué es un objeto, la diferencia entre ambos, qué es un atributo, qué es un método y para qué sirve un constructor, explicada con ejemplos de la clase `Vehiculo` del proyecto.
- **Cómo se probó:** se revisó en GitHub que la sección se viera correctamente y que los ejemplos de código coincidieran con el código real de `lib/vehiculo.dart`.
