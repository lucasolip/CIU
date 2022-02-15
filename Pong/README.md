# Pong!
![ezgif-5-717afc8c97](https://user-images.githubusercontent.com/47455265/153283496-124530cf-142f-4950-901d-519f9b7ff0e7.gif)
<br>*Lucas Olivares Pérez*
## Experiencia de Usuario
- En cada colisión con los jugadores, el ángulo de salida de la pelota está ligeramente desviado aleatoriamente para añadir algo de variedad
- Después de marcar, hay un segundo de margen para que la pelota se aleje y no siga marcando
- Se han añadido sonidos, hechos por mí en FL Studio, para cada interacción
- Se ha añadido una pantalla de pausa a la que se puede acceder pulsando espacio
- Se muestran los controles en pantalla antes de comenzar cada partida. Se ocultan durante la partida para mayor inmersión
- Posibilidad de reiniciar la partida después de terminar
## Implementación
Se separaron los objetos principales del juego en clases independientes con métodos para calcular física, entrada de los jugadores y mostrar los gráficos. Como Processing solo detecta la última tecla pulsada, se mantiene un registro de qué teclas se pulsan y se sueltan en cada momento, se almacena en un array y se consulta en cada frame para mover las palas.
## Herramientas
- **Audio:** FL Studio
- **Imágenes:** GIMP
