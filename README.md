# choppi_prueba - Jonathan Ruiz

## Desarrollo

1. Copia el archivo `.env.template` y renómbralo a `.env`.

2. Cambia las variables de entorno en el archivo `.env` (por ejemplo, la URL de la API de Rick and Morty).

## Acerca de la App

Este proyecto es una aplicación Flutter que utiliza diferentes paquetes y tecnologías para mostrar información sobre la serie de televisión "Rick and Morty". La aplicación cuenta con las siguientes funcionalidades y características:

- **Tecnología Utilizada:** La aplicación está desarrollada en Flutter, utilizando Dart como lenguaje de programación.

- **Paquetes Utilizados:**
  - `dio`: Librería para realizar peticiones HTTP.
  - `flutter_bloc`: Manejo de estado basado en el patrón BLoC.
  - `flutter_dotenv`: Cargar variables de entorno desde archivos.
  - `flutter_launcher_icons`: Generar íconos de la aplicación.
  - `go_router`: Manejo de rutas y navegación.

- **Estructura de la Aplicación:**
  La aplicación cuenta con 4 pantallas distintas:
  - **Home:** Presenta dos opciones: "Listado de Personajes" y "Listado de Episodios".
  - **Listado de Personajes:** Muestra una lista de personajes de la serie. Al hacer clic en un personaje, se muestra su detalle.
  - **Listado de Episodios:** Muestra un listado de episodios de la serie.
  - **Detalle de Personaje:** Muestra información detallada sobre un personaje específico.

- **Navegación:** Se utiliza el paquete `go_router` para manejar la navegación entre pantallas de manera eficiente.

## Requisitos

- Flutter 3.10.1
- Dart 3.0.1

## Instrucciones de Uso

1. Clona este repositorio.

2. Asegúrate de tener Flutter y Dart instalados en tu máquina.

3. Ejecuta `flutter pub get` en la terminal para instalar las dependencias.

4. Copia el archivo `.env.template` y renómbralo a `.env`. Luego, actualiza las variables de entorno en el archivo `.env`, como la URL de la API de Rick and Morty.

5. Ejecuta la aplicación con `flutter run`.

¡Explora y disfruta la aplicación!

---

Creado por Jonathan Ruiz - [GitHub](https://github.com/jerd-dev)