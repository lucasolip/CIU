# Sistema Planetario
![Gif del Sistema Planetario](https://user-images.githubusercontent.com/47455265/156931797-649300f3-2f3d-483d-8c96-61d53abfede7.gif)
<br>*Lucas Olivares Pérez*

## Características
Las distancias entre planetas, sus tamaños, velocidades de traslación y rotación, así como el ángulo de rotación de los satélites (las lunas) tienen cierto punto de aleatoriedad, para darle algo de belleza a la composición. 
Para poder obtener una composición a gusto del usuario, se permite regenerar el sistema mediante la tecla R. Todos los cuerpos tienen textura.<br>
La aplicación dispone de una vista general estática, para observar el sistema desde la lejanía, y una vista "de la nave" que se puede rotar haciendo click y arrastrando el ratón por la pantalla y mover hacia adelante pulsando espacio. También se permite regresar al punto inicial en vista de nave, porque es fácil perderse en el espacio sin un punto de referencia al que seguir, e invertir los controles al arrastrar el ratón, para que el movimiento siga al ratón o se asemeje más al arrastre táctil de los dispositivos móviles.

## Implementación
Las rotaciones de los cuerpos celestes son transformaciones respecto a sus centros de masa. 
Las órbitas se dibujan como círculos sin relleno rotados para corresponderse con el plano de la eclíptica. <br>
La cámara se compone de dos puntos o vectores en el espacio: un ojo y un objetivo, utilizados en el método camera() de Processing junto al vector vertical (0, 1, 0). Cuando se pulsa la tecla espacio, el ojo y el objetivo se desplazan en la dirección del vector que los une. Cuando se arrastra el ratón, se utiliza la diferencia entre las posiciones actual y anterior del ratón, escalada con un parámetro, para rotar el objetivo en torno al ojo. La rotación de la cámara está suavizada con una interpolación lineal regida por otros dos parámetros dampening, y se almacena para poder utilizarse de referencia en la propia rotación de la cámara y rotaciones de objetos que deban apuntar hacia ella o darle la espalda.<br>
El texto de los nombres de los planetas se dibuja como planos que se escalan según su distancia a la cámara y siguen el ángulo de rotación de la cámara para mirar hacia el usuario, al igual que hace el modelo de la nave para intentar apuntar siempre hacia el centro de la pantalla. El modelo de la nave se escaló y formateó un poco en Blender después de descargarlo.<br>
El texto de ayuda se dibuja simulando un modo 2D desactivando el Z-buffer por defecto, apagando las luces y recolocando la cámara.<br>
Hubo que implementar métodos de rotación para los tres ejes y un método de traslación, dado que los métodos rotate y translate de Processing no permiten transformar y almacenar coordenadas en memoria, solamente transformar los ejes del mundo en el frame actual.

## Controles
- Comunes
  - R: Regenerar el sistema aleatoriamente
  - H: Mostrar u ocultar la ayuda
- Vista general
  - Q: Cambiar a vista de nave
- Vista de nave
  - Q: Cambiar a vista general
  - Click y arrastrar para rotar la cámara
  - Espacio: Avanzar hacia adelante
  - I: Invertir controles del ratón
  - E: Regresar al punto de partida de la vista de nave

## Herramientas
- GIMP
- Audacity
- Blender
- [ezgif](https://ezgif.com)

## Referencias
- [Referencia de Processing](https://processing.org/reference/)
- [Wikipedia - Rotation matrix](https://en.wikipedia.org/wiki/Rotation_matrix)
- Recursos
  - [Background, NASA](https://svs.gsfc.nasa.gov/3895)
  - Music (Bubblaine theme - Underwater version): Naoto Kubo, Super Mario Odyssey, Nintendo
  - [Star (Color modified by me)](https://www.solarsystemscope.com/textures/download/2k_sun.jpg)
  - [Gruye](https://www.pinterest.es/pin/547117054727314654/)
  - [Ésoso, YCbCr](https://opengameart.org/content/planet-texture-80004000px) 
  - [Ávalon, Thunorrad](https://www.deviantart.com/thunorrad/art/Planet-Texture-42489691)
  - [Megera, vektorDex](https://opengameart.org/content/planetary-textures-2048x1024-gas-giant-equirectangular-5-2048x1024png) 
  - [Dómino, vektorDex](https://opengameart.org/content/planetary-textures-2048x1024-gas-giant-equirectangular-7-2048x1024png)
  - [Sedna](https://planet-texture-maps.fandom.com/wiki/Sedna)
  - [Vanth](https://planet-texture-maps.fandom.com/wiki/Vanth)
  - [Nave espacial](https://www.cgtrader.com/items/830734/download-page)
