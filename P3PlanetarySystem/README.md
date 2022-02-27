# Sistema Planetario
![Gif del Sistema Planetario](media/planetarysystem.gif)
<br>*Lucas Olivares Pérez*

## Características
Las distancias entre planetas, sus tamaños, velocidades de traslación y rotación, así como el ángulo de rotación de los satélites (las lunas) tienen cierto punto de aleatoriedad, para darle algo de belleza a la composición. 
Para poder obtener una composición a gusto del usuario, se permite regenerar el sistema mediante la tecla R. Todos los cuerpos tienen textura.

## Implementación
Las rotaciones de los cuerpos celestes son transformaciones respecto a sus centros de masa. 
Las órbitas se dibujan como círculos sin relleno rotados para corresponderse con el plano de la eclíptica. <br>
El texto de los nombres de los planetas se dibuja como planos que intentan rotar para mirar hacia la cámara, con mayor o menor grado de éxito. 
La mejor manera de mostrar texto como billboard sería determinar las coordenadas del planeta en Screen space a partir de sus coordenadas en World space, y dibujar el texto ahí, sobre la pantalla, con un cierto offset en y. 
Pero ahora mismo no sé cómo hacer eso con PeasyCam. Supongo que tendrá que ver con las coordenadas de la cámara y la proyección perspectiva.<br>
Los planetas están iluminados por una point light. La estrella se dibuja antes que la luz para que no se vea afectada por ella, simulando que emite esa luz.<br>
En esta práctica, la cámara está implementada utilizando la librería PeasyCam.

## Controles
- R: Regenerar el sistema aleatoriamente
- H: Mostrar u ocultar la ayuda
- Click y arrastrar para rotar la cámara
- Rueda del ratón para acercar y alejar la cámara

## Herramientas
- GIMP
- Audacity
- [ezgif](https://ezgif.com)

## Referencias
- [Referencia de Processing](https://processing.org/reference/)
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
