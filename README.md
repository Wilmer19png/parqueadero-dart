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
