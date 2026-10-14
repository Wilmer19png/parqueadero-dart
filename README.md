# Sistema de gestión de parqueadero en Dart

Aplicación de consola desarrollada en Dart para gestionar los vehículos de un parqueadero.

**Estudiante:** Wilmer Alejandro Buriticá Alvira
**Materia:** Lenguaje de Programación para APPs — VIII semestre, Diseño Crossmedia, UCC

## Descripción del proyecto

El sistema permite llevar el control de los vehículos que entran y salen de un parqueadero desde la consola. Se pueden registrar vehículos (carro, moto o camioneta) con su placa, marca, color y hora de entrada; consultar todos los vehículos parqueados; buscar uno por su placa; modificar sus datos; registrar su salida calculando el cobro según la tarifa por hora de cada tipo; y ver un resumen con el total de vehículos, la cantidad por tipo, los cupos disponibles y el dinero recaudado.

El parqueadero tiene una capacidad máxima de 20 vehículos y no permite registrar dos vehículos con la misma placa.

## Bitácora

### Paso 1 — Inicialización del repositorio
- **Qué se hizo:** se creó el repositorio local y el remoto en GitHub, el archivo README con la descripción del proyecto y el archivo `.gitignore` para no subir los archivos temporales que genera Dart.
- **Cómo se probó:** se verificó con `git rev-parse --show-toplevel` que el repositorio quedara en la carpeta del proyecto y se confirmó en GitHub que aparecieran los dos archivos.
